# Safety App

**To run the backend:**

**REQUIREMENTS**

Node version ^18

Firebase cli installed with credentials (you might need to create a new project within your console and replace the project id )

- use command: firebase use **project_id**

- You must create a .env file containing with:
  
**PLACES_API_KEY**={YOUR GOOGLE PLACES API KEY}

**GOOGLE_API_KEY**={YOUR GOOGLE AI STUDIO API KEY}

**YOUR_FIREBASE_API_KEY**={YOUR FIREBASE API KEY}  --> make sure not to use reserved FIREBASE_*** As Keys

You must activate this APIs within each respective console.


Run the following commands

- cd back
- cd functions
- npm run serve

  
**To run front:**

**REQUIREMENTS** 
flutter version 3.24.3

Create .env file with: 

for testing locally
BASE_URL=http://127.0.0.1:5001/safety-app-edf4a/us-central1/api 

on ios
- cd front
- cd ios
- flutter run
  

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
