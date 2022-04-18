import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simpedarku/models/error.dart';
import 'package:simpedarku/services/apiResponse.dart';
import 'package:simpedarku/services/apiService.dart';

import '../models/reports.dart';

class ReportView extends StatefulWidget {
  const ReportView({Key? key, required this.type}) : super(key: key);

  final String type;
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  bool _isLoading = false;

  XFile? photo;

  @override
  void initState() {
    super.initState();
  }

  _submitReport() async {
    Report data = Report(
      type: widget.type,
      description: _descriptionController.text,
      location: _locationController.text,
      title: _titleController.text,
      image: photo
    );
    setState(() {
      _isLoading = true;
    });
    final ApiResponse apiResponse = await ApiService.createReport(data);
    setState(() {
      _isLoading = false;
    });
    if (apiResponse.status == "error") {
      ErrorResponse errorResponse = ErrorResponse.fromMap(apiResponse.data);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(errorResponse.errors.join('\n')),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[600],
          title: Text('Report'),
        ),
        body: ((){
          if(_isLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return Container(
              margin: EdgeInsets.all(10),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      child: Image.asset("assets/images/logo.png")
                  ),
                  Center(
                    child: ((){
                      switch(widget.type){
                        case 'POLISI':
                          return SvgPicture.asset('assets/icons/police.svg', width: 100);
                        case 'RUMAH SAKIT':
                          return SvgPicture.asset('assets/icons/doctor.svg', width: 100);
                        case 'PEMADAM KEBAKARAN':
                          return SvgPicture.asset("assets/icons/fireman.svg", width: 100);
                      }
                    }()),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        label: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                            "Judul Laporan",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        hoverColor: Colors.grey[300],
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        label: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Text(
                            "Lokasi Kejadian",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 120,
                      child: SingleChildScrollView(
                        child: TextField(
                          minLines: 4,
                          maxLines: null,
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            label: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[300],
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const Text(
                                "Deskripsi Kejadian",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey[300],
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      )
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        primary: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () async {
                        _imagePicker
                            .pickImage(source: ImageSource.camera)
                            .then((image) {
                          setState(() {
                            photo = image;
                          });
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.camera_alt, color: Colors.grey[600]),
                          const SizedBox(width: 10),
                          Text(
                            "Ambil Gambar",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        primary: Colors.red[600],
                      ),
                      child: const Text(
                        "Laporkan!",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      onPressed: () => _submitReport(),
                    ),
                  ),
                ],
              ),
            );
          }
        }())
    );
  }
}
