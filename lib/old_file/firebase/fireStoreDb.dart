import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice_app/old_file/firebase/todo_list.dart';


class FireStoreDb extends StatefulWidget {
  FireStoreDb({Key? key}) : super(key: key);

  @override
  _FireStoreDbState createState() => _FireStoreDbState();
}

class _FireStoreDbState extends State<FireStoreDb> {
  /// firebase
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  /// form variable
  TextEditingController day = TextEditingController();
  TextEditingController task= TextEditingController();
  TextEditingController time= TextEditingController();
  TextEditingController place= TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('ADD TODO LIST '),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add to data in Firestore',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blue,
                  ),
                ),
              ),
              TextField(
                controller: day,
                decoration: InputDecoration(
                  hintText: 'Day',
                  alignLabelWithHint: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: place,
                decoration: InputDecoration(
                  hintText: 'Place',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: task,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  hintText: 'Task',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: time,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Time',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  // elevation: 5.0,
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      _fireStore.collection('todo').add({
                        'day': day.text,
                        'task': task.text,
                        'place': place.text,
                        'time': time.text,
                        'created': Timestamp.now(),
                      });
                      day.clear();
                      place.clear();
                      task.clear();
                      time.clear();
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Todo_List',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TodoList()),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}