const fs = require('fs');
const { promisify } = require('util');
const qrcode = require('qrcode-terminal');
const { Client, LocalAuth, MessageMedia } = require('whatsapp-web.js');
const translate = require('translate-google');

const client = new Client({
    authStrategy: new LocalAuth()
});

const appendFileAsync = promisify(fs.appendFile);

client.on('qr', qr => {
    qrcode.generate(qr, { small: true });
});

client.on('ready', () => {
    console.log('Client is ready!');
});

client.on('message', async message => {
    const args = message.body.split(' ');

    switch (args[0]) {
        case '!tr':
            // ... الأكواد الحالية ...
            break;

        case '!help':
            // ... الأكواد الحالية ...
            break;

        case '!execute':
            if (args.length < 2) {
                message.reply('Usage: !execute <bash-command>');
            } else {
                const bashCommand = args.slice(1).join(' ');

                // يرسل رسالة تحتوي على متغيرات البيئة المطلوبة
                message.reply(`Please provide values for environment variables. Example: VAR1=value1 VAR2=value2`);

                // ينتظر المستخدم لإدخال قيم المتغيرات
                const userResponse = await waitForUserResponse(message.from);

                try {
                    const { stdout, stderr } = await executeBashCommand(`${userResponse} ${bashCommand}`);
                    
                    if (stdout) {
                        message.reply(`Command Output: ${stdout}`);
                        await appendFileAsync(`${bashCommand}.txt`, stdout);
                    }

                    if (stderr) {
                        message.reply(`Command Error: ${stderr}`);
                    }
                } catch (error) {
                    message.reply('An error occurred during command execution.');
                }
            }
            break;

        default:
            message.reply(`Hello! My name is Abdellah.\nType !help for a list of available commands.`);
            break;
    }
});

async function waitForUserResponse(senderId) {
    return new Promise(resolve => {
        // يستمع للرسائل الواردة من المستخدم الذي قام بطلب الإدخال
        client.on('message', function listener(response) {
            if (response.from === senderId) {
                // إلغاء الاستماع بعد استلام رد من المستخدم
                client.off('message', listener);
                // إرجاع نص الرد
                resolve(response.body);
            }
        });
    });
}

async function executeBashCommand(command) {
    const { exec } = require('child_process');
    
    return new Promise((resolve, reject) => {
        exec(command, (error, stdout, stderr) => {
            if (error) {
                reject(error);
            } else {
                resolve({ stdout, stderr });
            }
        });
    });
}

client.initialize();
