# node-backup
سیستم بکاپ‌گیری پیشرفته و خودکار برای نودها، داکر و داده‌های حیاتی سرور با ارسال به تلگرام.

<div align="center">

# Node Backup Bot

**بکاپ خودکار تمام نودها به تلگرام — هر ۳۰ دقیقه یکبار!**

زیپ می‌کنه · می‌فرسته · پاک می‌کنه — کاملاً خودکار

</div>

## نصب با یک خط (فقط ۲۰ ثانیه)

```bash
bash <(curl -Ls https://raw.githubusercontent.com/marzbanix/node-backup/main/install.sh)

بعد از اجرا فقط دو تا چیز می‌خواد:
توکن ربات تلگرام (@BotFather)
چت آیدی (شخصی یا گروه)
همین! تموم

/root/Marzban-node
/var/lib/marzban-node
/opt/pg-node
/var/lib/pg-node
/opt/marznode        هر پوشه داخلش جدا جدا ارسال میشه

ویژگی‌های خفن
ارسال خودکار هر ۳۰ دقیقه (کرون)
فشرده‌سازی با ZIP + حذف خودکار بعد از ارسال
رعایت محدودیت ۴۵ مگ تلگرام
محیط مجازی جداگانه (بدون تداخل)
لاگ روزانه پاک میشه
بدون نیاز به دیتابیس یا تنظیمات پیچیده
فارسی کامل + پشتیبانی ۲۴ ساعته

حذف کامل (Uninstall)

rm -rf /opt/backupbot-venv /opt/backup_bot.py /etc/backup_bot.conf /backup /var/log/backup_bot.log
crontab -l | grep -v "backup_bot.py" | crontab -

ساخته شده با عشق توسط marzbanix
اگه خوشت اومد استار فراموش نشه
```
