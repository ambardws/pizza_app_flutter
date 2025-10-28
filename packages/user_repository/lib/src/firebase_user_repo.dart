import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/user.dart';
import 'package:user_repository/src/user_repo.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _fireBaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({
    FirebaseAuth? fireBaseAuth,
  }) : _fireBaseAuth = fireBaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<MyUser?> get user {
    return _fireBaseAuth.authStateChanges().flatMap((firebaseUser) async* {
      if (firebaseUser == null) {
        yield null;
      } else {
        yield await userCollection
            .doc(firebaseUser.uid)
            .get()
            .then((snapshot) => MyUser.fromEntity(MyUserEntity.fromDocument(snapshot.data()!)));
        }
    });
  }

  @override
  Future<void> logOut() async {
    await _fireBaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await userCollection.doc(myUser.userId).set(myUser.toEntity().toDocument());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _fireBaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _fireBaseAuth.createUserWithEmailAndPassword(email: myUser.email, password: password);

      myUser.userId = user.user!.uid;
      return myUser;
    } catch (e) {
      throw Exception(e);
    }
  }

  

}