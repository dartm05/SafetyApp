import { IDashboardCard } from "./dashboard-card";

export interface IDashboard {
    id?: string;
    userId: string;
    title: string;
    description: string;
    timestamp?: string;
    cards: IDashboardCard[];
    }