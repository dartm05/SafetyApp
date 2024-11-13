import {IDashboardCard} from "../domain/models/dashboard/dashboard-card";
export const formatSafetyRecommendations = (message) => {
  const formattedSections: IDashboardCard[] = [];
  let encodedData = message.replace(/\*\*|\*/g, "");
  encodedData = encodedData.replace(/```/g, "");

  const decoded = JSON.parse(encodedData);

  decoded.forEach((section) => {
    const title = section.title;
    const body = section.description;
    const card: IDashboardCard = {
      title,
      description: body,
    };
    formattedSections.push(card);
  });
  return formattedSections;
};
