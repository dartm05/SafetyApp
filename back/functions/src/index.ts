import { initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyDe7fPzka5hF8FwqEkNrur3qrBn1veYoKo",
  authDomain: "safety-app-edf4a.firebaseapp.com",
  projectId: "safety-app-edf4a",
  storageBucket: "safety-app-edf4a.firebasestorage.app",
  messagingSenderId: "669764617478",
  appId: "1:669764617478:web:469416fb7145ba8049ca87"
};

initializeApp(firebaseConfig);
export const db = getFirestore();

export { api } from "./infrastructure/routes";
