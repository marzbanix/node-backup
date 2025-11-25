# node-backup
سیستم بکاپ‌گیری پیشرفته و خودکار برای نودها، داکر و داده‌های حیاتی سرور با ارسال به تلگرام.

# 🔥 Node & Docker Auto Backup Bot  
اسکریپت بکاپ‌گیری پیشرفته برای نودها، داکر، و فایل‌های حیاتی سرور با ارسال امن به تلگرام.

این ابزار به صورت خودکار تمام مسیرهای مهم را ZIP کرده و مستقیم به تلگرام ارسال می‌کند.  
نیازی به تنظیم دستی نیست — فقط نصب کن، توکن بده، کار انجامه.

---

## 🚀 نصب خودکار

اسکریپت زیر را مستقیم در سرور اجرا کنید:

```bash
bash <(curl -Ls https://raw.githubusercontent.com/marzbanix/node-backup/main/install.sh)

# حذف کامل (Uninstall)

دستور زیر را مستقیم در سرور اجرا کنید:

```bash
rm -rf /opt/backupbot-venv /opt/backup_bot.py /etc/backup_bot.conf /backup /var/log/backup_bot.log && crontab -l | grep -v "backup_bot.py" | crontab -
