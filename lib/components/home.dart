import 'dart:developer';
import 'dart:ui';
import 'dart:io' show Platform, exit;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localstorage/localstorage.dart';
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

  @override
  void initState() {
    super.initState();
    //_loadReports();
  }

  _loadReports() async {
    final reports = await ApiService.getReports();
    setState(() {
      _reports = reports;
    });
  }

  _logout() async {
    await storage.ready.
    then((_) => storage.setItem("token", null));

    if (Platform.isIOS) {
      exit(0);
    } else {
      SystemNavigator.pop();
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[600],
          title: const Text('Simpedarku'),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed:  ()async => await _loadReports(),
            ),
            IconButton(onPressed: ()async => await _logout(), icon: const Icon(Icons.logout))
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          constraints: const BoxConstraints.expand(),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/images/logo.png"),
                    Row(
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
                          onPressed: () {},
                          child: Container(
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
                                  'POLISI',
                                  style: TextStyle(
                                    fontSize: 12,
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
                          onPressed: () {},
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
                                    fontSize: 12,
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
                          onPressed: () {},
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
                  ],
                ),
                flex: 1,
              ),
              Flexible(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: ReportsTable(reports: _reports)),
                flex: 1,
              )
            ],
          ),
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
      border: TableBorder.symmetric(
          outside: const BorderSide(
            color: Colors.black,
            width: 0.5,
          ),
          inside: BorderSide.none),
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
                child: Text(e.status,
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
