import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc128_lab/models/routine.dart';

//FOR HOME ROUTINE 

const String routineid = "user1";

class DBroutineService{
  final _firestore = FirebaseFirestore.instance;
  late final  CollectionReference _collection_ref;

  final DateTime now = DateTime.now().toLocal();

  DBroutineService(){
    _collection_ref = _firestore.collection('users').doc(routineid).collection('routines').withConverter<Routine>(
      fromFirestore: (snapshots, _) => Routine.fromJson(
        snapshots.data()!,
        ), 
        toFirestore: (routine,_) => routine.toJson());
  }

  Stream<QuerySnapshot> getRoutine(){
    return _collection_ref.snapshots();
  }
}