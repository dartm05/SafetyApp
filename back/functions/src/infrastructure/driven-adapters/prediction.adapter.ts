// ignore_for_file: max-len
import {ITrip} from "../../domain/models/trip/trip";
import {IProfile} from "../../domain/models/profile/profile";
import {IMessage} from "../../domain/models/message/message";
import dotenv from "dotenv";
import {SchemaType, GoogleGenerativeAI} from "@google/generative-ai";

dotenv.config();

const genAI = new GoogleGenerativeAI(process.env.GOOGLE_API_KEY);
const model = genAI.getGenerativeModel({model: "gemini-pro"});

const predict = async (trip: ITrip, profile: IProfile) => {
  const schema = {
    description: "List of safety recommendations for the trip",
    type: SchemaType.ARRAY,
    items: {
      type: SchemaType.OBJECT,
      properties: {
        title: {
          type: SchemaType.STRING,
          description: "Title of the section of safety recommendation",
          nullable: false,
        },
        description: {
          type: SchemaType.STRING,
          description: "Safety recommendation",
          nullable: false,
        },
      },
      required: ["title", "description"],
    },
  };
  const model = genAI.getGenerativeModel({
    model: "gemini-1.5-pro",
    generationConfig: {
      responseMimeType: "application/json",
      responseSchema: schema,
    },
  });
  const promptText = formatSafetyPrompt(trip, profile);
  const result = await model.generateContent(promptText);
  const response = await result.response;
  return response.text();
};

const formatSafetyPrompt = (trip: ITrip, profile: IProfile) => {
  return `
     Please act as a personal travel planner and create a detailed itinerary for a trip from  ${trip.origin} to ${trip.destination}, covering  ${trip.startDate} to ${trip.endDate} days. The itinerary should be organized into four key sections that cater to the traveler’s preferences, safety needs, and the travel style mentioned. Keep in mind female safety and Include the following:

    Day-by-Day Itinerary: Outline a recommended daily schedule with key sights, activities, and dining options tailored to the travel style (e.g., luxury, adventure, cultural exploration) and specific interests listed.

    Transportation & Safety Preferences: Suggest safe transportation modes that match the traveler’s preferences (e.g., women-only options, public vs. private transport) and align with their comfort needs.

    Local Safety Alerts: Provide recent alerts on ongoing issues (e.g., crime trends, natural disasters, civil unrest) in the destination area, highlighting severity, specific affected areas, and precautions for travelers.

    General Safety Recommendations: Offer general safety tips tailored to the traveler’s profile, including best practices for solo travelers, emergency contacts, and situational safety guidance for tourist sites or crowded locations. Since the traveller is a female, especially highlight the city safety index and recommend female safety stops.

    Personalize the recommendations based on the traveler’s profile data provided below.

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
      parts: [{text: msg.message}],
    })),
  ];
  const chat = model.startChat({
    history: chatHistory,
    generationConfig: {maxOutputTokens: 400},
  });
  const result = await chat.sendMessage(newMessage.message);
  const response = await result.response;
  return await response.text();
};

export {predict, chat};
