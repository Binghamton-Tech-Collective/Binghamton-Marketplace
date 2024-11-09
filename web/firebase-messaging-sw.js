// Please see this file for the latest firebase-js-sdk version:
// https://github.com/firebase/flutterfire/blob/master/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyDsKJxU9wEyhKGIU3YBslMZoe6VheAisdU",
  authDomain: "",
  databaseURL: "...",
  projectId: "btc-market-575d9",
  storageBucket: "btc-market-575d9.appspot.com",
  messagingSenderId: "458210387235",
  appId: "1:458210387235:web:7eca713677d204bb8f9896",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
