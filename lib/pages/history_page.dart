import 'dart:convert';
import 'dart:typed_data';
import 'package:futuregenai/appbars/appbar.dart';
import 'package:futuregenai/style/constants.dart';
import 'package:futuregenai/widgets/extracted_widgets.dart';
import 'package:futuregenai/widgets/reusable_widgets.dart';

import '../helpers/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futuregenai/helpers/provider_engine.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  static const history_page = 'HistoryPage';

  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(titleText: 'History',),
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.all(10),
        child: HistoryStreamBuilder(), // Use the extracted HistoryStreamBuilder widget
      ),
    );
  }
}


class HistoryStreamBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Provider.of<MainEngine>(context).streamFirestoreSnapshot,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No Data"));
        } else {
          var data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              try {
                Uint8List historyData = base64Decode(data[index]["prompts"]);
                return Container(
                  margin: EdgeInsets.all(10),
                  constraints: BoxConstraints(minWidth: 200, minHeight: 400),
                  child: GestureDetector(
                    onLongPress: () {
                      saveImage(historyData);
                    },
                    child: MainImageCard(
                      imagePath: MemoryImage(historyData),
                    ),
                  ),
                );
              } catch (e) {
                print('Error decoding image: $e');
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  color: Colors.grey[300],
                  child: Center(
                    child: Text('Error loading image'),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
