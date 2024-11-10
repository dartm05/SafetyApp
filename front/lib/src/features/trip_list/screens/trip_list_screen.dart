import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_app/src/features/trip_detail/providers/trip_form_provider.dart';
import 'package:safety_app/src/features/trip_list/widgets/trip_card.dart';

import '../../../data/models/trip.dart';
import '../providers/trip_list_provider.dart';

class TripListScreen extends StatefulWidget {
  const TripListScreen({super.key});

  @override
  State<TripListScreen> createState() => _TripListScreenState();
}

class _TripListScreenState extends State<TripListScreen> {
  late Future<List<Trip>?> futureTripsList = Future.value([]);

  @override
  void initState() {
    super.initState();
    final TripListProvider tripListProvider =
        Provider.of<TripListProvider>(context, listen: false);
    futureTripsList = tripListProvider.fetchTrips();
  }

  @override
  Widget build(BuildContext context) {
    final TripListProvider tripListProvider =
        Provider.of<TripListProvider>(context, listen: false);
    final TripFormProvider tripFormProvider =
        Provider.of<TripFormProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton.filled(
                onPressed: () {
                  context.go('/trip_detail');
                },
                icon: const Icon(Icons.add),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Trip>?>(
                future: futureTripsList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(34.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('No trips found'),
                            const SizedBox(height: 16),
                            SvgPicture.asset(
                              'assets/img/no_trips.svg',
                              height: 200,
                              placeholderBuilder: (context) =>
                                  const CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    final tripsList = snapshot.data!;
                    return ListView.builder(
                        itemCount: tripsList.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(tripsList[index].id.toString()),
                            onDismissed: (direction) {
                              final tripId = tripsList[index].id.toString();
                              setState(() {
                                tripsList.removeAt(index);
                              });

                              tripListProvider.deleteTrip(tripId).then((value) {
                                futureTripsList = tripListProvider.fetchTrips();
                              });
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: TripCard(
                                trip: tripsList[index],
                                onUpdate: () {
                                  tripFormProvider
                                      .setSelectedTrip(tripsList[index]);
                                  context.go('/trip_detail');
                                }),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
