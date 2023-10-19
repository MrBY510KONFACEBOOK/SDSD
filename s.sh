# تثبيت أداة gdown
pip install gdown

# تحميل الملف الأول وفك الضغط
gdown https://drive.google.com/uc?id=1IuwwbU-AfsH9moZcbumPtCrLo-jiDmO1
unzip whatsapp-web-project-20231019T080437Z-001.zip

# التنقل إلى المجلد الجديد
cd whatsapp-web-project

# تحميل الملف الثاني
gdown https://drive.google.com/uc?id=1QZIo7pd2d67Qb59j33cn3URAM-i5fRxE

# تشغيل السكريبت
bash i.sh

# تثبيت حزم npm
npm install qrcode-terminal whatsapp-web.js translate-google

# تشغيل التطبيق
node index.js "هل هناك خطأ؟"
