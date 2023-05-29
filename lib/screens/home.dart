import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_dashboard_app_tut/screens/add_report.dart';
import 'package:web_dashboard_app_tut/screens/report2.dart';

import 'dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var pageIndex;
  var selectedIndex;
  var name;
  var icon;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: const Color(0xFFf8f9fa),
          resizeToAvoidBottomInset: false,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _sideMenu(),
                _contentsPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _sideMenu() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 0.0,
        left: 0,
        right: 0,
        bottom: 0,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF175F1C),
              Color(0xFF000000),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            top: 10.0,
            right: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 50, top: 20),
                child: CircleAvatar(
                  radius: 48, // Image radius
                  backgroundImage: AssetImage('assets/Ruvu_River.jpg'),
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                itemCount:4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    name = 'Dashboard';
                    icon = Icons.dashboard_rounded;
                    // pageIndex = 1;
                  } else if (index == 1) {
                    name = 'View Reports';
                    icon = Icons.edit_calendar_rounded;
                    // pageIndex = 2;
                  }else if (index == 2) {
                    name = 'Report Problem';
                    icon = Icons.map_outlined;
                    // pageIndex = 2;
                  }  else if (index == 3) {
                    name = 'Logout';
                    icon = Icons.logout;
                    // pageIndex = 3;
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      mouseCursor: MouseCursor.uncontrolled,
                      onTap: () => {
                        setState(
                              () {
                            selectedIndex = index;
                            // pageIndex = index == null ? 0 : index + 1;
                            if (index == 0) {
                              pageIndex = 1;
                            } else if (index == 1) {
                              pageIndex = 2;
                            } else if (index == 2) {
                              pageIndex = 3;
                            } else if (index == 3) {
                              pageIndex = 4;
                            } else if (index == 4) {
                              pageIndex = 5;
                            }
                          },
                        ),
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? const Color(0xFF6c757d).withOpacity(0.5)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  icon,
                                  size: 25,
                                  color: Colors.white70,
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _contentsPage() {
    if (pageIndex == 1) {
      return const Expanded(
        child: DashboardScreen(
        ),
      );
    }else if (pageIndex == 2) {
      return Expanded(
        child: ReportScreen(),
      );
    }  else if (pageIndex == 3) {
      return const Expanded(
        child: AddReport(
        ),
      );
    } else if (pageIndex == 4) {
      return const Expanded(
        child: Dialog()
      );
    } else {
      return const Expanded(
        child: DashboardScreen(
        ),
      );
    }
  }


}