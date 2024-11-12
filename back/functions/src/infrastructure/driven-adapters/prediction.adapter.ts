import { ITrip } from "../../domain/models/trip/trip";
import { IProfile } from "../../domain/models/profile/profile";
import { IMessage } from "../../domain/models/message/message";
import dotenv from "dotenv";

dotenv.config();
const { GoogleGenerativeAI } = require("@google/generative-ai");
const genAI = new GoogleGenerativeAI(process.env.GOOGLE_API_KEY);
const model = genAI.getGenerativeModel({ model: "gemini-pro" });

const predict = async (trip: ITrip, profile: IProfile) => {
  const promptText = formatSafetyPrompt(trip, profile);
  const result = await model.generateContent(promptText);
  const response = await result.response;
  return response.text();
};

const formatSafetyPrompt = (trip: ITrip, profile: IProfile) => {
  return `
      Provide safety recommendations for this trip, creating a maximum of 4 sections of information such as crime areas, accommodation, transportation, based on the following information:

      Trip Details:
      Origin: ${trip.origin}
      Destination: ${trip.destination}
      Start Date: ${trip.startDate}
      End Date: ${trip.endDate}
      Transportation: ${trip.transportation}
      Hotel: ${trip.hotel}
      Travel Style: ${trip.travelStyle}
      Places to Visit: ${trip.placesToVisit}
      Ladies Only Metro: ${trip.ladiesOnlyMetro}
      Ladies Only Taxi: ${trip.ladiesOnlyTaxi}
      Loud Noise Sensitive: ${trip.loudNoiseSensitive}
      Crowd Fear: ${trip.crowdFear}
      No Isolated Places: ${trip.noIsolatedPlaces}
      Low Crime: ${trip.lowCrime}
      Public Transport Only: ${trip.publicTransportOnly}

      User Profile to take into account:
      Age: ${profile.age}
      Gender: ${profile.gender}
      Ethnicity: ${profile.ethnicity}
      Has Disability: ${profile.disability}
      Is traveling with Children: ${profile.travelingWithChildren}
      Preferred Mode of Transport: ${profile.preferredModeOfTransport}
      Using Data for mobile: ${profile.dataUsage}
    `;
};

const chat = async (
  trip: ITrip,
  profile: IProfile,
  messages: IMessage[],
  newMessage: IMessage
) => {
  const contextMessage = {
    role: "user",
    parts: [
      {
        text: `Trip Details:
  Origin: ${trip.origin}
  Destination: ${trip.destination}
  Start Date: ${trip.startDate}
  End Date: ${trip.endDate}
  Transportation: ${trip.transportation}
  Hotel: ${trip.hotel}
  Travel Style: ${trip.travelStyle}
  User Preferences:
  - Ladies Only Metro: ${trip.ladiesOnlyMetro}
  - Ladies Only Taxi: ${trip.ladiesOnlyTaxi}
  - Loud Noise Sensitive: ${trip.loudNoiseSensitive}
  - Crowd Fear: ${trip.crowdFear}
  - No Isolated Places: ${trip.noIsolatedPlaces}
  - Low Crime: ${trip.lowCrime}
  - Public Transport Only: ${trip.publicTransportOnly}

  User Profile:
  Age: ${profile.age}
  Gender: ${profile.gender}
  Ethnicity: ${profile.ethnicity}
  Has Disability: ${profile.disability}
  Is traveling with Children: ${profile.travelingWithChildren}
  Preferred Mode of Transport: ${profile.preferredModeOfTransport}
  Using Data for mobile: ${profile.dataUsage}
`,
      },
    ],
  };
  const chatHistory = [
    contextMessage,
    ...messages.map((msg) => ({
      role: "user",
      parts: [{ text: msg.message }],
    })),
  ];
  const chat = model.startChat({
    history: chatHistory,
    generationConfig: { maxOutputTokens: 400 },
  });
  const result = await chat.sendMessage(newMessage.message);
  const response = await result.response;
  return await response.text();
};

export { predict, chat };
