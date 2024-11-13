# Safety App

## Project Overview

The Solo Travel Safety Companion app is an AI-powered solution designed to address the safety challenges faced by women traveling alone. Leveraging advanced AI technologies, particularly Google Gemini, the app provides real-time safety insights, predictive safety alerts, and an emergency chatbot, all tailored to the unique needs of solo female travelers. It offers a range of features, including a real-time safety index, predictive risk analysis, a location-sharing safety companion mode, and customized safety profiles based on user preferences.

## Contribution to Gender Equality

This app is crafted to empower women by addressing a fundamental safety concern that often limits their freedom and independence. By providing a reliable, AI-powered tool for real-time safety insights, it allows women to travel confidently and securely, aligning with global gender equality objectives, particularly UN Sustainable Development Goal 5. Additionally, the app’s community-sourced data and AI-driven personalization challenge gender stereotypes that discourage women from traveling solo, thereby promoting women’s agency and leadership

live at: https://safety-app-edf4a.web.app/#/login 

## REQUIREMENTS

## To run the backend:

Node version ^18

Firebase cli installed with credentials (you might need to create a new project within your console and replace the project id )


- You must create a .env file containing:
  
**PLACES_API_KEY**={YOUR GOOGLE PLACES API KEY}

**GOOGLE_API_KEY**={YOUR GOOGLE AI STUDIO API KEY}

**YOUR_FIREBASE_API_KEY**={YOUR FIREBASE API KEY}  --> make sure not to use reserved FIREBASE_*** As Keys

You must activate this APIs within each respective console.

## Setup

1. Check the Node version:

```
node --version
```

Install Firebase `functions` and `admin` in the functions directory. At the top level project directory:

```
cd functions
npm install firebase-functions@latest --save
```

2. Your Node version needs to be version 18. If you need multiple Node versions, consider using [nvm](https://github.com/nvm-sh/nvm):

```
nvm use 18
nvm alias default 18 # set the version for vs code
```

**Setting up Firebase**

Taken from the Firebase [getting started documentation](https://firebase.google.com/docs/functions/get-started?authuser=1).

3. Install the latest firebase tools

```
npm install -g firebase-tools
```

4. Log in

```
firebase login
```

5. Set your active project (optionally, list available projects with `firebase projects:list`):

```
firebase use project-id
```



Run the following commands

- cd back
- cd functions
- npm run serve

  
**To run front:**

**REQUIREMENTS** 
flutter version 3.24.3

Create .env file in front directory with: 

for testing locally
```
BASE_URL=http://127.0.0.1:5001/safety-app-edf4a/us-central1/api
```

for production 
```
BASE_URL=https://us-central1-safety-app-edf4a.cloudfunctions.net/api
```

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
