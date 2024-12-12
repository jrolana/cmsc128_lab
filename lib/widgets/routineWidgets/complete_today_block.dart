import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:cmsc128_lab/utils/firestore_utils.dart';

class CompleteTodayBlock extends StatefulWidget {
  const CompleteTodayBlock({super.key});

  @override
  State<CompleteTodayBlock> createState() => _CompleteTodayBlock();
}

class _CompleteTodayBlock extends State<CompleteTodayBlock> {
  String userID = FirestoreUtils.uid;
  late Stream<QuerySnapshot> routine_stream;

  @override
  void initState() {
    super.initState();
    routine_stream = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('routines')
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
                return Column(children: [
                  CircularProgressIndicator(),
                  Text("Loading")
                  ],
                );
              }

              var docs = snapshot.data!.docs;

              return ListView.builder(
                  padding: EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(IconlyBold.bag_2,
                          size: 30,
                          color: const Color.fromARGB(255, 25, 36, 108)),
                      title: Text(docs[index]['name'],
                          style: GoogleFonts.lexendDeca(
                              textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ))),
                      subtitle: Text(docs[index]['daysOfWeek'].toString()),
                          //'${DateFormat.jm().format(docs[index]['startTime'].toDate())} - ${DateFormat.jm().format(docs[index]['endTime'].toDate())}'),
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
