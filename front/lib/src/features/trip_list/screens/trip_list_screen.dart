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
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: width > 800
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                width > 800
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Trips",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Your upcoming trips!',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    : Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 24, bottom: 20),
                              child: Text(
                                "Trips",
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Text(
                                'Your upcoming trips!',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(width: width > 800 ? 20 : 0),
                SvgPicture.asset(
                  'assets/img/plane.svg',
                  height: 80,
                  width: width / 3,
                  placeholderBuilder: (context) =>
                      const CircularProgressIndicator(),
                ),
                const SizedBox(height: 20),
              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: width > 800
                  ? const EdgeInsets.only(right: 60)
                  : const EdgeInsets.only(right: 34),
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton.filled(
                  onPressed: () {
                    context.go('/trip_detail');
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
            ),
            width > 800 ? const SizedBox.shrink() : const SizedBox(height: 60),
            Expanded(
              child: FutureBuilder<List<Trip>?>(
                future: futureTripsList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Column(
                      mainAxisAlignment: width > 800
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        SvgPicture.asset(
                          'assets/img/no_trips.svg',
                          height: width > 800 ? 300 : 200,
                          placeholderBuilder: (context) =>
                              const CircularProgressIndicator(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Oops! No trips found!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
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
