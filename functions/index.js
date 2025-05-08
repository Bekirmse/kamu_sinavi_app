const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { initializeApp } = require("firebase-admin/app");

initializeApp();

exports.logNotificationData = onDocumentCreated("notifications_queue/{docId}", async (event) => {
  const data = event.data.data();
  const { to, title, body } = data;

  if (!to || !title || !body) {
    console.log("❌ Eksik veri:", data);
    return;
  }

  // Sadece gelen veriyi logla
  console.log("📥 Gelen veri:", { to, title, body });
});