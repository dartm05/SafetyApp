import { initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";

export const firebaseConfig = {
  apiKey: "AIzaSyAN-0YySo2sbt_YGTmxGP6cdUFT0Me9MAA",
  authDomain: "safety-app-ff42c.firebaseapp.com",
  projectId: "safety-app-ff42c",
  storageBucket: "safety-app-ff42c.firebasestorage.app",
  messagingSenderId: "1091468216825",
  appId: "1:1091468216825:web:eaafc18da78dc7be699528"
};

initializeApp(firebaseConfig);
export const db = getFirestore();

export { api } from "./infrastructure/routes";
