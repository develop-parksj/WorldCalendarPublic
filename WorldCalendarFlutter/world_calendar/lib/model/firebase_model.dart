import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class FirebaseModel {
  static final FirebaseModel _model = FirebaseModel();
  static FirebaseModel get instance => _model;

  get recordError => FirebaseCrashlytics.instance.recordError;

  FirebaseModel();

  Future<void> initialize() async {
    await Firebase.initializeApp();
  }
}