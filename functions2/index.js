const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendNewsNotification = functions.firestore
  .document("news/{newsId}")
  .onCreate(async (snap, context) => {

    const data = snap.data();

    console.log("🔥 Firestore trigger OK");

    const title = data.title || "新着ニュース";
    const body = data.body || "";

    const message = {
      notification: {
        title: title,
        body: body,
      },
      topic: "all",
    };

    try {
      const response = await admin.messaging().send(message);
      console.log("🔥 通知送信成功:", response);
    } catch (error) {
      console.error("❌ 通知送信エラー:", error);
    }
  });