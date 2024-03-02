import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomePage extends StatelessWidget {
  CollectionReference candidateReference =
      FirebaseFirestore.instance.collection("partidosPolíticos");
  Future<void> exportPDF() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return [
              pw.Text(
                "HOLA",
                style: pw.TextStyle(color: PdfColors.black),
              ),
              pw.Text(
                "HOLA",
                style: pw.TextStyle(color: PdfColors.black),
              ),
              pw.Text(
                "HOLA",
                style: pw.TextStyle(color: PdfColors.black),
              ),
              pw.Text(
                "HOLA",
                style: pw.TextStyle(color: PdfColors.black),
              ),
              pw.Text(
                "HOLA",
                style: pw.TextStyle(color: PdfColors.black),
              ),
              pw.Text(
                "HOLA",
                style: pw.TextStyle(color: PdfColors.black),
              ),
            ];
          }),
    );

    Uint8List bytes = await pdf.save();

    print(bytes);
    Directory directory = await getApplicationCacheDirectory();
    String fileName = "${directory.path}/report.pdf";
    print(fileName);
    File pdfFile = File(fileName);
    await pdfFile.writeAsBytes(bytes, flush: true);

    OpenFile.open(fileName);
  }

  @override
  Widget build(BuildContext context) {
    candidateReference.get().then((value) {
      QuerySnapshot candidateCollection = value;
      List<QueryDocumentSnapshot> docs = candidateCollection.docs;
      print(docs.length);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Export",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: exportPDF,
              child: Text("TO PDF"),
            )
          ],
        ),
      ),
    );
  }
}
