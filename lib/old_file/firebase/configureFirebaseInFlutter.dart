
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._();

  factory FirebaseService() => _instance;

  FirebaseService._();

  Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  DatabaseReference get databaseRef => FirebaseDatabase.instance.ref();
}


class DataService {
  final DatabaseReference _dbRef = FirebaseService().databaseRef.child('items');
  
  Future<void> createItem(String name, String description) async {
    final newItemRef = _dbRef.push();
    await newItemRef.set({
      'name': name,
      'description': description,
      
    });

  }
  

   void getData() {
    DatabaseReference ref = FirebaseDatabase.instance.ref('items');
    ref.onValue.listen((DatabaseEvent event) {
      var temp = event.snapshot.value;
      print(temp);
    });
  }

  Future<void> updateItem(String itemId, String newName, String newDescription) async {
    final itemRef = _dbRef.child(itemId);
    await itemRef.update({
      'name': newName,
      'description': newDescription,
      
    });
  }

  Future<void> deleteItem(String itemId) async {
    final itemRef = _dbRef.child(itemId);
    await itemRef.remove();
  }
}


