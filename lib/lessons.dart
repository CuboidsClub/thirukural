import 'package:Thirukural/player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Lessons extends StatefulWidget {
  final lession;
  Lessons(this.lession);
  @override
  _LessonsState createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(bottom: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  fit: BoxFit.fill, image: AssetImage("assets/note2.png"))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 100,
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection(widget.lession)
                      .orderBy("index")
                      .snapshots(),
                  builder: (context, snap) {
                    if (!snap.hasData)
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    else
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snap.data.documents.length,
                        itemBuilder: (context, index) {
                          print(snap.data.documents[0].documentID);
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.brown,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>Player(
                                          snapshot: snap.data.documents[index],
                                          number: 0,
                                        )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 50, left: 20),
                                width: MediaQuery.of(context).size.width,
                                height: 70,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.black87,
                                          border: Border.all(
                                              color: Colors.black12, width: 6),
                                          borderRadius:
                                              BorderRadius.circular(70)),
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.black54,
                                                  width: 2))),
                                      width: MediaQuery.of(context).size.width *
                                          .60,
                                      child: Text(
                                        "   ${snap.data.documents[index].data['name']}",
                                        style: TextStyle(fontSize: 18),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(Icons.keyboard_arrow_right,
                                        color: Colors.black87, size: 25)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                  },
                ),
              ),
              Container(
                  child: Text(
                widget.lession.toString().toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ))
            ],
          )),
    );
  }
}
