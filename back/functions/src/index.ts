import { initializeApp } from "firebase-admin/app";
import { getFirestore } from "firebase-admin/firestore";

export const firebaseConfig = {
  apiKey: "AIzaSyBVKECxc5lOkJLBl_Siv7MjBY7TiwFMeu0",
  authDomain: "tasks-app-b53c1.firebaseapp.com",
  projectId: "tasks-app-b53c1",
  storageBucket: "tasks-app-b53c1.appspot.com",
  messagingSenderId: "837347397183",
  appId: "1:837347397183:web:7459af4a625032b543b28a",
  measurementId: "G-TYQ8Z7H17C",
};

initializeApp(firebaseConfig);
export const db = getFirestore();

export { api } from "./infrastructure/routes";
