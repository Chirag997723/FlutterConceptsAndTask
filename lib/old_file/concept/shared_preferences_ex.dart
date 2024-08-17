import 'package:flutter/material.dart';
import 'package:flutter_practice_app/old_file/concept/explain_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesEx extends StatefulWidget {
  @override
  State<SharedPreferencesEx> createState() => _SharedPreferencesExState();
}

class _SharedPreferencesExState extends State<SharedPreferencesEx> {
  final name = TextEditingController();
  final fatherName = TextEditingController();
  final sirName = TextEditingController();
  final standerd = TextEditingController();
  final admitionYear = TextEditingController();

  // Save value to SharedPreferences
  Future<void> _saveValue(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SharedPrefer',
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
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a name',
                  contentPadding: EdgeInsets.all(8)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: fatherName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a father name',
                  contentPadding: EdgeInsets.all(8)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: sirName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a sirname',
                  contentPadding: EdgeInsets.all(8)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: standerd,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a standerd',
                  contentPadding: EdgeInsets.all(8)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: admitionYear,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a admition year',
                  contentPadding: EdgeInsets.all(8)),
            ),
          ),
          Center(
            child: ElevatedButton.icon(
                onPressed: () {
                  if (name.text.toString().isEmpty) {
                    Fluttertoast.showToast(msg: 'name Empty');
                  } else if (fatherName.text.toString().isEmpty) {
                    Fluttertoast.showToast(msg: 'father name Empty');
                  } else if (sirName.text.toString().isEmpty) {
                    Fluttertoast.showToast(msg: 'sirname Empty');
                  } else if (standerd.text.toString().isEmpty) {
                    Fluttertoast.showToast(msg: 'standerd Empty');
                  } else if (admitionYear.text.toString().isEmpty) {
                    Fluttertoast.showToast(msg: 'admition year Empty');
                  } else {
                    _saveValue('name', name.text.toString());
                    _saveValue('fatherName', fatherName.text.toString());
                    _saveValue('sirName', sirName.text.toString());
                    _saveValue('standerd', standerd.text.toString());
                    _saveValue('admitionYear', admitionYear.text.toString());

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExplainData(),
                        ));
                  }
                },
                icon: Icon(Icons.save),
                label: Text("Save Data")),
          )
        ],
      ),
    );
  }
}
