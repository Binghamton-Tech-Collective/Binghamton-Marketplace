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

            // Determine the sender and the receiver
            const currentUserUID = newMessage.author;
            let receiverUID = null;
            let senderUID = null;
            if (currentUserUID === buyerUID) {
                receiverUID = sellerUID;
                senderUID = buyerUID;
            } else if (currentUserUID === sellerUID) {
                receiverUID = buyerUID;
                senderUID = sellerUID;
            }
            if (!receiverUID || !sellerUID) {
                console.log('Could not determine the receiver or the sender.');
                return;
            }

            try {
                // Get the receiver's FCM token from the users collection
                const userDoc = await firestore.collection('users').doc(receiverUID).get();
                const senderDoc = await firestore.collection('users').doc(senderUID).get();
                if (!userDoc.exists || !senderDoc.exists) {
                    console.log(`User with ID ${receiverUID} does not exist.`);
                    return;
                }

                const receiverData = userDoc.data();
                const senderData = senderDoc.data();
                const senderName = senderData.name;
                const receiverFcmToken = receiverData.token;

                if (!receiverFcmToken) {
                    console.log(`No FCM token found for user ${receiverUID}.`);
                    return;
                }
                console.log(`This is the receiver's FCM Token: ${receiverFcmToken}`);

                const payload = {
                    token: receiverFcmToken,
                    data: {
                        conversationId: event.params["id"],
                    },
                    notification: {
                        title: `${senderName}`,
                        body: newMessage.content || "A new Message",
                        
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
