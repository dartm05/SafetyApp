import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safety_app/src/data/models/dashboard.dart';
import 'package:safety_app/src/data/models/dashboard_card.dart';
import 'package:safety_app/src/features/dashboard/widgets/dashboard_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Dashboard dashboard = Dashboard(
    userId: '1',
    title: 'Your upcoming trip to London',
    description: 'This is the dashboard',
    cards: [
      DashboardCard(
        title: 'Trips',
        description:
            'Research and book accommodations in reputable and safe areas. Opt for well-lit and secure accommodations with good reviews. Inform someone of your itinerary and accommodation details.l-lit and secure accommodations with good reviews. Inform someone of your itinerary and accommodation details.l-lit and secure accommodations with good reviews. Inform someone of your itinerary and accommodation details.l-lit and secure accommodations with good reviews. Inform someone of your itinerary and accommodation details.l-lit and secure accommodations with good reviews. Inform someone of your itinerary and accommodation details.',
        icon: Icons.list,
      ),
      DashboardCard(
        title: 'Safety Chatbot',
        description:
            'Research and book accommodations in reputable and safe areas.safe areas. Opt for welsafe areas. Opt for welsafe areas. Opt for welsafe areas. Opt for welsafe areas. Opt for wel Opt for well-lit and secure accommodations with good reviews. Inform someone of your itinerary and accommodation details.',
      ),
      DashboardCard(
        title: 'Safety Chatbot',
        description:
            'Research and bookssss accommodations in reputable and safe areas. Opt for well-lit and secure accommodations with good reviews. Inform someone osafe areas. Opt for welsafe areas. Opt for welsafe areas. Opt for welsafe areas. Opt for welsafe areas. Opt for welsafe areas. Opt for welf your itinerary and accommodation details.',
      ),
      DashboardCard(
        title: 'Safety Chatbot4',
        description:
            'Research and book accommodations in reputable and safe areas. Opt for well-lit and secure accommodations with good reviews. Inform someone of your itinerary and accommodation detaisafe areas. Opt for welsafe areas. Opt for welsafe areas. Opt for welsafe areas. Opt for welsafe areas. Opt for wells.',
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.sizeOf(context).width);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: width > 800
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                width > 800
                    ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 34, bottom: 20),
                              child: Text(
                                "Dashboard",
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 34),
                              child: Text(
                                dashboard.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: Column(
                          crossAxisAlignment: width > 800
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 34, bottom: 20),
                              child: Text(
                                "Dashboard",
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 34),
                              child: Text(
                                dashboard.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(
                  width: 130,
                  child: SvgPicture.asset(
                    'assets/img/travel.svg',
                    height: 150,
                    placeholderBuilder: (context) =>
                        const CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: width > 800 ? 600 : width,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      controller: ScrollController(),
                      shrinkWrap: true,
                      itemCount: dashboard.cards.length,
                      itemBuilder: (context, index) {
                        return DashboardCardWidget(
                            card: dashboard.cards[index]);
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
