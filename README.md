# node-backup
سیستم بکاپ‌گیری پیشرفته و خودکار برای نودها، داکر و داده‌های حیاتی سرور با ارسال به تلگرام.

<div align="center">

# Node Backup Bot

**بکاپ خودکار تمام نودها به تلگرام — هر ۳۰ دقیقه یکبار!**

</div>

## نصب یک خطه (فقط ۲۰ ثانیه)

```bash
bash <(curl -Ls https://raw.githubusercontent.com/marzbanix/node-backup/main/install.sh)

اولین بار فقط می‌خواد:
توکن ربات (@BotFather)
چت آیدی (شخصی یا گروه)
دفعه‌های بعدی دیگه هیچی نمی‌پرسه و کاملاً خودکار کار می‌کنه
قابلیت‌ها
بکاپ خودکار هر ۳۰ دقیقه
هر پوشه داخل /opt/marznode جدا جدا ارسال میشه
فایل‌های بزرگتر از ۴۵ مگ ارسال نمیشن
بعد از ارسال، فایل زیپ خودکار حذف میشه
پیام وضعیت نهایی با زمان دقیق میاد
لاگ هر روز ساعت ۲۳:۵۵ پاک میشه
محیط مجازی جداگانه (بدون تداخل)
فارسی کامل + ایموجی‌های خفن تو لاگ و تلگرام

مسیرهای بکاپ
/root/Marzban-node
/var/lib/marzban-node
/opt/pg-node
/var/lib/pg-node
/opt/marznode

حذف کامل (Uninstall)
rm -rf /opt/backupbot-venv /opt/backup_bot.py /etc/backup_bot.conf /backup /var/log/backup_bot.log
crontab -l | grep -v "backup_bot.py" | crontab -

ساخته شده با عشق و دقت توسط marzbanix
اگه حال کردی استار یادت نره داداش
�
