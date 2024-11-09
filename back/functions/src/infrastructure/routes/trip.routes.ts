import express from 'express';
import { TripController, serviceInjection } from '../controllers/trip.controller';

const tripApp = express();

tripApp.get('/:userId/trips', (req, res, next) =>
  TripController.findAll(req, res, next, serviceInjection)
);

tripApp.get('/:userId/trips/:id', (req, res, next) =>
  TripController.findOne(req, res, next, serviceInjection)
);

tripApp.post('/:userId/trips', (req, res, next) =>
  TripController.create(req, res, next, serviceInjection)
);

tripApp.put('/:userId/trips/:id', (req, res, next) =>
  TripController.update(req, res, next, serviceInjection)
);

tripApp.delete('/:userId/trips/:id', (req, res, next) =>
  TripController.remove(req, res, next, serviceInjection)
);

export default tripApp;