export interface IDashboard {
    id?: string;
    userId: string;
    title: string;
    description: string;
    timestamp?: string;
    cards: any[];
    }