import 'package:brow_crow/models/brow.dart';
import 'package:brow_crow/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  // a constructor of the class
  DatabaseServices({this.uid});

  // uid String
  final String uid;

  // collection reference
  final CollectionReference browCollection =
      Firestore.instance.collection('brow');

  // create a function to update the user data
  Future updateUserData({String sugars, String name, int strength}) async {
    return await browCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // list the brow list from sanpshot
  List<Brow> _browListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brow(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strength'] ?? 0,
      );
    }).toList();
  }

  // create a stream to get the latest data of the brows
  Stream<List<Brow>> get brows {
    return browCollection.snapshots().map(_browListFromSnapshot);
  }

  // list the user data from snapshot
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  // create a stream to get the latest data of the user data
  Stream<UserData> get userData {
    return browCollection.document(uid).snapshots().map(_userDataFromSnapShot);
  }
}
