import 'package:flutter/material.dart';
import 'package:flutter_practice_app/old_file/firebase/configureFirebaseInFlutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class RealtimeDatabase extends StatelessWidget {
  TextEditingController name1 = TextEditingController();
  TextEditingController name2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RealtimeDatabase'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: name1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a name',
                    contentPadding: EdgeInsets.all(8)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: name2,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a age',
                    contentPadding: EdgeInsets.all(8)),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            ElevatedButton(
                onPressed: () {
                  DataService().createItem(name1.text, name2.text);
                  Fluttertoast.showToast(msg: 'new Data Add');
                  Navigator.pop(context);
                },
                child: Text('save data')),
                ElevatedButton(
                onPressed: () {
                  DataService().getData();
                },
                child: Text('read data')),
                ElevatedButton(
                onPressed: () {
                  DataService().updateItem('-O16bdKLAV5shletD4_i',name1.text, name2.text);
                  Fluttertoast.showToast(msg: 'edit Data');
                },
                child: Text('edit data')),
                ElevatedButton(
                onPressed: () {
                  DataService().deleteItem('-O16bdKLAV5shletD4_i');
                  Fluttertoast.showToast(msg: 'delete Data');
                },
                child: Text('delete data')),
                
          ],
        ),
      ),
    );
  }
}
