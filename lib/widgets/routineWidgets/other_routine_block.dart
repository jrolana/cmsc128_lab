import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc128_lab/widgets/routineWidgets/routine_home_routine_block.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cmsc128_lab/utils/firestore_utils.dart';

class OtherRoutines extends StatefulWidget {
  const OtherRoutines({super.key});

  @override
  State<OtherRoutines> createState() => _OtherRoutines();
}

class _OtherRoutines extends State<OtherRoutines> {
  String userID = FirestoreUtils.uid;
  late Stream<QuerySnapshot> routine_stream;

  @override
  void initState() {
    super.initState();
    routine_stream = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('routines')
        .where('routineType', isEqualTo: 'otherroutines')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        alignment: FractionalOffset.center,
        decoration: myBoxDecoration(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder(
            stream: routine_stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Connection error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading ...');
              }

              var docs = snapshot.data!.docs;

              return ListView.builder(
                  padding: EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.cases_sharp,
                          size: 30,
                          color: const Color.fromARGB(255, 25, 36, 108)),
                      title: Text(docs[index]['name'],
                          style: GoogleFonts.lexendDeca(
                              textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ))),
                      subtitle: Text(
                          '${DateFormat.jm().format(docs[index]['startTime'].toDate())} - ${DateFormat.jm().format(docs[index]['endTime'].toDate())}'),
                    );
                  });
            }),
      ),
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
    color: Color.fromARGB(255, 254, 254, 254),
    borderRadius: BorderRadius.circular(20.0),
  );
}
