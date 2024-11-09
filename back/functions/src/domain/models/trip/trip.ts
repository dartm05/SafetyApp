export interface ITrip {
  id: string;
  name: string;
  startDate: string;
  endDate: string;
  origin: string;
  destination: string;
  transport: string;
  createdAt: Date;
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
