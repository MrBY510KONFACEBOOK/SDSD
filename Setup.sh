pip install gdown

# تحميل الملف الأول وفك الضغط
gdown https://drive.google.com/uc?id=1IuwwbU-AfsH9moZcbumPtCrLo-jiDmO1
unzip whatsapp-web-project-20231019T080437Z-001.zip

# التنقل إلى المجلد الجديد
cd whatsapp-web-project
npm install qrcode-terminal whatsapp-web.js translate-google
rm index.js
wget https://raw.githubusercontent.com/MrBY510KONFACEBOOK/SDSD/main/index.js
node .
