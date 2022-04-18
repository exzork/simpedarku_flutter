import 'dart:developer';
import 'dart:ui';
import 'dart:io' show Platform, exit;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localstorage/localstorage.dart';
import 'package:simpedarku/components/profile.dart';
import 'package:simpedarku/components/report.dart';
import 'package:simpedarku/services/apiService.dart';
import 'package:collection/collection.dart';

import '../models/reports.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final LocalStorage storage = LocalStorage('simpedarku');
  List<Report> _reports = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  _loadReports() async {
    setState(() {
      _isLoading = true;
    });
    final reports = await ApiService.getReports();
    setState(() {
      _reports = reports;
      _isLoading = false;
    });
  }

  _logout() async {
    await storage.ready.then((_) => storage.setItem("token", null));

    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
      Orientation orientation = MediaQuery.of(context).orientation;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[600],
          title: const Text('Simpedarku'),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileView(),
                  ),
                );
              }
            ),
            IconButton(
                onPressed: () async => await _logout(),
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: Image.asset("assets/images/logo.png"),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[600],
                          minimumSize: const Size(100, 150),
                          maximumSize: const Size(100, double.infinity),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReportView(type:"POLISI"),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: SvgPicture.asset(
                                  'assets/icons/police.svg',
                                ),
                              ),
                              const Text(
                                'KANTOR POLISI',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[600],
                          minimumSize: const Size(100, 150),
                          maximumSize: const Size(100, double.infinity),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReportView(type:"RUMAH SAKIT"),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: SvgPicture.asset(
                                  'assets/icons/doctor.svg',
                                ),
                              ),
                              const Text(
                                'RUMAH SAKIT',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red[600],
                          minimumSize: const Size(100, 150),
                          maximumSize: const Size(100, double.infinity),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReportView(type:"PEMADAM KEBAKARAN"),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: SvgPicture.asset(
                                  'assets/icons/fireman.svg',
                                ),
                              ),
                              const Text(
                                'PEMADAM KEBAKARAN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                flex: 0,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: ()=>_loadReports(),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        children: [
                          Expanded(
                              child : SingleChildScrollView(
                                child: _isLoading ? const Center(
                                  child: CircularProgressIndicator(),
                                ) :
                                ReportsTable(reports: _reports),
                              )
                          )
                        ],
                      )
                  ),
                ),
                flex: 2,
              )
            ],
          ),
        ),
      );
  }
}

class ReportsTable extends StatelessWidget {
  final List<Report> reports;

  const ReportsTable({Key? key, required this.reports}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
      },
      border: TableBorder.symmetric(
          outside: const BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
          inside: BorderSide.none
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.red[600],
          ),
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text("Nama Laporan",
                  style: TextStyle(color: Colors.white)),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child:
                  const Text("Status", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
        ...reports.mapIndexed((i, e) {
          return TableRow(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                color: i % 2 == 0 ? Colors.grey[200] : Colors.grey[300],
                child: Text(e.title ?? '',
                    style: const TextStyle(color: Colors.black)),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: i % 2 == 0 ? Colors.grey[200] : Colors.grey[300],
                child: Text(e.status ?? 'UNKNOWN',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              )
            ],
          );
        }).toList()
      ],
    );
  }
}
