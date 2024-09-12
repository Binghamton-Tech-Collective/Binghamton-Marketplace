/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
const functions = require("firebase-functions/v2"); // Firebase Functions v2
const admin = require('firebase-admin');
admin.initializeApp();

const firestore = admin.firestore();
const messaging = admin.messaging();

exports.sendNotificationOnNewMessage = functions.firestore.onDocumentUpdated("conversations/{id}",
    async (event) => {
        console.log("Firestore document updated!");

        // Access the data before and after the update
        const afterData = event.data.after.data();
        const beforeData = event.data.before.data();

        // Get the messages from before and after the update
        const beforeMessages = beforeData.messages || [];
        const afterMessages = afterData.messages || [];

        // Check if a new message was added
        if (beforeMessages.length < afterMessages.length) {
            const newMessage = afterMessages[afterMessages.length - 1];

            // Get the conversation details to identify the receiver
            const buyerUID = afterData.buyerUID;
            const sellerUID = afterData.sellerUID;

            // Determine the recipient (receiver)
            const currentUserUID = newMessage.author;
            let receiverUID = null;

            if (currentUserUID === buyerUID) {
                receiverUID = sellerUID;
            } else if (currentUserUID === sellerUID) {
                receiverUID = buyerUID;
            }
            if (!receiverUID) {
                console.log('Could not determine the receiver.');
                return;
            }

            try {
                // Get the receiver's FCM token from the users collection
                const userDoc = await firestore.collection('users').doc(receiverUID).get();
                if (!userDoc.exists) {
                    console.log(`User with ID ${receiverUID} does not exist.`);
                    return;
                }

                const receiverData = userDoc.data();
                const receiverFcmToken = receiverData.fcmToken;

                if (!receiverFcmToken) {
                    console.log(`No FCM token found for user ${receiverUID}.`);
                    return;
                }
                console.log(`This is the receiver's FCM Token: ${receiverFcmToken}`);

                const payload = {
                    receiverFcmToken: receiverFcmToken,
                    data: {
                        title: `New message from ${newMessage.author}`, // Customize the title
                        body: newMessage.content || "A new Message",  // The message content
                    },
                };

                // Send the notification
                await admin.messaging().send(payload);
                console.log('Notification sent successfully');

            } catch (error) {
                console.error('Error retrieving FCM token or sending notification:', error);
            }
        }
    }
);
