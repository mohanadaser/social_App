import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String email, password, username, userimage, uid;
  final List followers;
  final List following;

  UserModel(this.followers, this.following, this.email, this.password,
      this.username, this.userimage, this.uid);

  Map<String, dynamic> convrtToMap() {
    //====using to post to firebase
    return {
      'followers': followers,
      'following': following,
      'email': email,
      'password': password,
      'username': username,
      'userimage': userimage,
      'uid': uid
    };
  }

  static convertToSnapToModel(DocumentSnapshot snap) {
    // using to get data as model from firebase
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        snapshot['followers'],
        snapshot['following'],
        snapshot['email'],
        snapshot['password'],
        snapshot['username'],
        snapshot['userimage'],
        snapshot['uid']);
  }
}
