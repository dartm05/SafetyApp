export interface ITrip {
  id: string;
  name: string;
  startDate: string;
  endDate: string;
  origin: string;
  destination: string;
  transportation: string;
  createdAt: string;
  hotel: string;
  travelStyle: string;
  ladiesOnlyMetro: boolean;
  ladiesOnlyTaxi: boolean;
  loudNoiseSensitive: boolean;
  crowdFear: boolean;
  noIsolatedPlaces: boolean;
  lowCrime: boolean;
  publicTransportOnly: boolean;
  placesToVisit: string[];
}
