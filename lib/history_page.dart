import 'dart:convert';
import 'dart:typed_data';
import 'functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:futuregenai/provider_engine.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  static const history_page = 'HistoryPage';
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}
class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(10),
        child: StreamBuilder<QuerySnapshot>(
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
                    return GestureDetector(
                      onLongPress: (){
                        saveImage(historyData);
                      },
                      child: Container(
                        height: 400,
                        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          image: DecorationImage(
                            image: MemoryImage(historyData),
                            fit: BoxFit.cover,
                          ),
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
        ),
      ),
    );
  }
}
