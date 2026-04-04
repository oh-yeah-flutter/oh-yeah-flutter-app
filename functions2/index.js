const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendNewsNotification = functions.firestore
  .document("news/{newsId}")
  .onCreate(async (snap, context) => {

    const data = snap.data();

    console.log("🔥 Firestore trigger OK");
    console.log("🔥 送信newsId:", context.params.newsId);

    const title = data.title || "新着ニュース";
    const body = data.body || "";

    const message = {
      notification: {
        title: title,
        body: body,
      },
      data: {
        newsId: String(context.params.newsId),
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