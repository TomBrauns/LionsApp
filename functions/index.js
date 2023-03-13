const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');
admin.initializeApp();






exports.sendNotification = functions.https.onCall(async (data, context) => {
  const { title, body } = data;

  try {
    const snapshot = await admin.firestore().collection('users').get();
    const tokens = [];
    snapshot.forEach((doc) => {
      const { deviceToken } = doc.data();
      if (deviceToken) {
        tokens.push(deviceToken);
      }
    });
    


    //TODO: title = Eventitel
    //TODO: body = E
    
    if (tokens.length > 0) {
      const message = {
        notification: {
          title,
          body,
        },
        tokens,
      };

      const response = await admin.messaging().sendMulticast(message);
      console.log(`Notification sent to ${response.successCount} devices`);
      return { success: true };
    } else {
      console.log('No devices found to send notification');
      return { success: false };
    }
  } catch (error) {
    console.error(`Error sending notification: ${error}`);
    return { error: error.message };
  }
});

exports.sendEmailWithAttachments = functions.https.onCall(async (data, context) => {
  
  const transporter = nodemailer.createTransport({
    host: "sslout.df.eu",
    port: "25",
    secure: true,
    auth: {
      user: "info@serviceclub-app.de",
      pass: "T#k2lcJYnmK6",
    },
  });

  try {
    await transporter.sendMail(data.mailOptions);
    return { success: true };
  } catch (error) {
    return { success: false, error: error.message };
  }
});


