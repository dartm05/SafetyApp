import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:safety_app/src/features/dashboard/widgets/dashboard_card.dart';

import '../providers/dashboard_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    Provider.of<DashboardProvider>(context).initializeDashboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.sizeOf(context).width);
    final provider = Provider.of<DashboardProvider>(context);
    final dashboard = provider.dashboard;
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
                                dashboard?.title ?? '',
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
                                dashboard?.title ?? '',
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
            if (dashboard != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width,
                    child: LayoutBuilder(builder: (context, constraints) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          bool isWide = constraints.maxWidth > 600;
                          return isWide
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  controller: ScrollController(),
                                  scrollDirection: Axis.vertical,
                                  itemCount:
                                      (dashboard.cards.length / 2).ceil(),
                                  itemBuilder: (context, rowIndex) {
                                    int start = rowIndex * 2;
                                    int end =
                                        (start + 2 > dashboard.cards.length)
                                            ? dashboard.cards.length
                                            : start + 2;

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children:
                                          List.generate(end - start, (index) {
                                        return Container(
                                          margin: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2) -
                                                48,
                                            child: Column(
                                              children: [
                                                Text(
                                                  dashboard.cards[index].title,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                DashboardCardWidget(
                                                    card: dashboard
                                                        .cards[start + index]),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                )
                              : ListView.builder(
                                  controller: ScrollController(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: dashboard.cards.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Text(
                                            dashboard.cards[index].title,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        DashboardCardWidget(
                                          card: dashboard.cards[index],
                                        ),
                                      ],
                                    );
                                  },
                                );
                        },
                      );
                    }),
                  ),
                ],
              )
            else if (dashboard == null && provider.isLoading)
              const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
