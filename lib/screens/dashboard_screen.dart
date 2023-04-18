import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/screens/report2.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'add_report.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //setting the expansion function for the navigation rail
  bool isExpanded = false;
  List<DocumentSnapshot> _reports = [];

  // DateTime dateAdded = DocumentSnapshot!.data()['dateAdded'].toDate();

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  Future<void> _fetchReports() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('reports').get();
    setState(() {
      _reports = querySnapshot.docs;
    });
  }

  List<charts.Series<Map<String, dynamic>, DateTime>> _createSeries() {
    List<Map<String, dynamic>> data = _reports
        .map((report) => {
              'date': (report['reported_by'] as Timestamp).toDate(),
              'numReports': report['description']
            })
        .toList();

    return [
      charts.Series<Map<String, dynamic>, DateTime>(
        id: 'Reports',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (data, _) => data['date'],
        measureFn: (data, _) => data['numReports'],
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          //Let's start by adding the Navigation Rail
          NavigationRail(
              // leading: Icon(Icons.airplane_ticket),
              useIndicator: true,
              extended: isExpanded,
              backgroundColor: Colors.deepPurple.shade400,
              unselectedIconTheme:
                  const IconThemeData(color: Colors.white, opacity: 1),
              unselectedLabelTextStyle: const TextStyle(
                color: Colors.white,
              ),
              selectedIconTheme:
                  IconThemeData(color: Colors.deepPurple.shade900),
              destinations: [
                NavigationRailDestination(
                  icon: IconButton(
                    tooltip: 'Home',
                    icon: const Icon(Icons.home),
                    onPressed: () {},
                  ),
                  label: const Text("Home"),
                ),
                NavigationRailDestination(
                    icon: IconButton(
                      tooltip: 'View Reports',
                      icon: const Icon(Icons.bookmarks),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirestoreTablePage()));
                      },
                    ),
                    label: const Text('Reports')),
                NavigationRailDestination(
                    icon: IconButton(
                      tooltip: 'Report Abuse',
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddReport()));
                      },
                    ),
                    label: const Text('Add report')),
                NavigationRailDestination(
                  icon: IconButton(
                    tooltip: 'View Users',
                      icon: const Icon(Icons.people),
                      onPressed: () {
                        //  Navigator.push(context, MaterialPageRoute(builder: (context) => const MapPage()));
                      }),
                  label: const Text("Users"),
                ),
                NavigationRailDestination(
                  icon: IconButton(
                    tooltip: 'Logout',
                    icon: const Icon(Icons.logout),
                    onPressed: () {},
                  ),
                  label: const Text("Logout"),
                ),
              ],
              selectedIndex: 0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //let's add the navigation menu for this project
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            //let's trigger the navigation expansion
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          icon: const Icon(Icons.menu),
                        ),
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://faces-img.xcdn.link/image-lorem-face-3430.jpg"),
                          radius: 26.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    //Now let's start with the dashboard main rapports
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: Card(
                            color: Colors.pinkAccent,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.article,
                                        size: 26.0,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "Today's Reports",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  const Text(
                                    "34",
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Card(
                            color: Colors.grey,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.comment,
                                        size: 26.0,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "Month Reports",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  const Text(
                                    "123",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Card(
                            color: Colors.cyan,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.analytics,
                                        size: 26.0,
                                        color: Color.fromARGB(255, 9, 158, 9),
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        "Total Reports",
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          color: Color.fromARGB(255, 7, 255, 61),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  const Text(
                                    "398",
                                    style: TextStyle(
                                      fontSize: 36,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    DataTable(
                      columns: const <DataColumn>[
                        DataColumn(label: Text('Description',
                        style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 12, 175, 26)),
                        )),
                        DataColumn(label: Text('Reported By',
                        style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 16, 206, 32)),
                        )),
                      ],
                      rows: _reports
                          .map((report) => DataRow(cells: <DataCell>[
                                DataCell(
                                    Text(report['description']!.toString())),
                                DataCell(
                                    Text(report['reported_by']!.toString())),
                              ]))
                          .toList(),
                    ),

                    // SizedBox(
                    //   height: 300,
                    //   child: charts.TimeSeriesChart(
                    //     _createSeries(),
                    //     animate: true,
                    //     dateTimeFactory: const charts.LocalDateTimeFactory(),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
