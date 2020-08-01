import 'package:cloud_firestore/cloud_firestore.dart';

class Database{

getUserByEmail(String email) async {
    return await Firestore.instance
        .collection("register")
        .where("email", isEqualTo: email)
        .getDocuments();
}
}