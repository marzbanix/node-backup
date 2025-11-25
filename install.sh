#!/bin/bash

echo "📦 Setting up Telegram Backup Bot..."

apt update
apt install -y python3-pip python3-venv nano curl

python3 -m venv /opt/backupbot-venv
source /opt/backupbot-venv/bin/activate
pip install --upgrade pip
pip install python-telegram-bot==20.7
deactivate

cat << 'EOF' > /opt/backup_bot.py
#!/usr/bin/env python3
import os
import zipfile
import time
import asyncio
from telegram import Bot
from telegram.error import TelegramError

BACKUP_PATHS = [
    "/root/Marzban-node",
    "/var/lib/marzban-node",
    "/opt/pg-node",
    "/var/lib/pg-node",
    "/opt/marznode"
]

CONFIG_FILE = "/etc/backup_bot.conf"
LOCAL_BACKUP_DIR = "/backup"
MAX_SIZE = 45 * 1024 * 1024  # 45MB Telegram limit

def zip_item(item_path):
    """Zip a single file or folder"""
    if not os.path.exists(item_path):
        return None
    timestamp = time.strftime("%Y-%m-%d_%H-%M-%S")
    name = os.path.basename(item_path.rstrip("/"))
    zip_path = os.path.join(LOCAL_BACKUP_DIR, f"{name}_{timestamp}.zip")
    os.makedirs(LOCAL_BACKUP_DIR, exist_ok=True)
    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as zipf:
        if os.path.isdir(item_path):
            for root, dirs, files in os.walk(item_path):
                for file in files:
                    filepath = os.path.join(root, file)
                    arcname = os.path.relpath(filepath, "/")
                    zipf.write(filepath, arcname)
        else:
            zipf.write(item_path, arcname=os.path.relpath(item_path, "/"))
    return zip_path

async def send_file(bot, chat_id, filepath):
    """Send a single ZIP file then delete"""
    if not os.path.exists(filepath):
        return
    if os.path.getsize(filepath) > MAX_SIZE:
        print(f"⚠ File too large to send: {filepath}")
        return
    try:
        with open(filepath, "rb") as f:
            await bot.send_document(chat_id=chat_id, document=f, caption=f"📦 {os.path.basename(filepath)}")
        print(f"✅ Sent: {filepath}")
    except TelegramError as e:
        print(f"❌ Error sending {filepath}: {e}")
    finally:
        os.remove(filepath)
        print(f"🗑 Deleted: {filepath}")

def setup():
    """Ask user for token and chat ID the first time"""
    if os.path.exists(CONFIG_FILE):
        return
    token = input("Enter Telegram Bot Token: ").strip()
    chat_id = input("Enter Chat ID: ").strip()
    with open(CONFIG_FILE, "w") as f:
        f.write(f"TOKEN={token}\nCHAT_ID={chat_id}\n")
    print("✅ Config saved.")

def load_config():
    """Read saved config"""
    conf = {}
    with open(CONFIG_FILE) as f:
        for line in f:
            k, v = line.strip().split("=", 1)
            conf[k] = v
    return conf

async def main():
    """Main backup process"""
    if not os.path.exists(CONFIG_FILE):
        setup()
    conf = load_config()
    bot = Bot(token=conf["TOKEN"])
    chat_id = conf["CHAT_ID"]

    print("🚀 Starting backup process...")
    for folder in BACKUP_PATHS:
        if not os.path.exists(folder):
            print(f"⚠ Skipped missing: {folder}")
            continue

        # ✅ Special case: send each file/folder inside /opt/marznode separately
        if folder == "/opt/marznode":
            for item in os.listdir(folder):
                item_path = os.path.join(folder, item)
                zip_path = zip_item(item_path)
                if zip_path:
                    await send_file(bot, chat_id, zip_path)
        else:
            zip_path = zip_item(folder)
            if zip_path:
                await send_file(bot, chat_id, zip_path)

    # ✅ Final status message
    now = time.strftime("%Y-%m-%d %H:%M:%S")
    msg = f"---------------------------------\n✅ Backup completed successfully.\n🕒 Date: {now}\n---------------------------------"
    await bot.send_message(chat_id=chat_id, text=msg)
    print("✅ Backup summary message sent.")

if __name__ == "__main__":
    asyncio.run(main())
EOF

chmod +x /opt/backup_bot.py

source /opt/backupbot-venv/bin/activate
python /opt/backup_bot.py
deactivate

# Cron: backup every 30 minutes + clear log every 24h
(crontab -l 2>/dev/null; echo "*/30 * * * * /opt/backupbot-venv/bin/python /opt/backup_bot.py >> /var/log/backup_bot.log 2>&1
") | crontab -
(crontab -l 2>/dev/null; echo "55 23 * * * > /var/log/backup_bot.log 2>&1") | crontab -

echo "✅ Installation complete! Robot runs every 30 minutes and clears logs daily."
