import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {

  Future<Map<String, dynamic>> fetchUserById(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (!doc.exists) {
      throw Exception('User not found');
    }
    return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
  }

}