import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExplainData extends StatefulWidget {
  @override
  State<ExplainData> createState() => _ExplainDataState();
}

class _ExplainDataState extends State<ExplainData> {
  String name = 'No Value';
  String name2 = 'No Value';
  String name3 = 'No Value';
  String name4 = 'No Value';
  String name5 = 'No Value';

  @override
  void initState() {
    super.initState();
    _loadValue();
  }

  // Load value from SharedPreferences
  Future<void> _loadValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'No Value';
      name2 = prefs.getString('fatherName') ?? 'No Value';
      name3 = prefs.getString('sirName') ?? 'No Value';
      name4 = prefs.getString('standerd') ?? 'No Value';
      name5 = prefs.getString('admitionYear') ?? 'No Value';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ExplainData',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name!,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black)),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name2!,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black)),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name3!,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black)),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name4!,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black)),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name5!,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
