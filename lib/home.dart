import 'package:Thirukural/Player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'lessons.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController ctrl = TextEditingController();
  bool temp = false;
  var tempWidget =
      IconButton(onPressed: () => print('empty'), icon: Icon(Icons.search));
  Future<void> navigateroute(numb, context) async {
    int realnum = int.parse(numb);
    if (realnum >= 1 && realnum < 1330) {
      if (realnum <= 380) {
        print("started searching in case - 1");
        Firestore.instance
            .collection("araththuppaal")
            .where("index", isEqualTo: realnum ~/ 10)
            .getDocuments()
            .then((onValue) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Player(
                        snapshot: onValue.documents[0],
                        number: (realnum % 10) == 0 ? 9 : realnum % 10 - 1,
                      )));
          print(onValue.documents[0]);
        });
      } else if (realnum <= 1080) {
        realnum -= 380;
        print("realnum : $realnum");
        print("started searching in case - 2");
        Firestore.instance
            .collection("porutpaal")
            .where("index", isEqualTo: realnum ~/ 10)
            .getDocuments()
            .then((onValue) {
          print("isEqualto ${(realnum / 10)}");
          print(onValue.documents[0].data);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Player(
                        snapshot: onValue.documents[0],
                        number: (realnum % 10) == 0 ? 9 : realnum % 10 - 1,
                      )));
        });
      } else {
        realnum -= 1080;
        print("started searching in case - 3");
        Firestore.instance
            .collection("kaamaththuppaal")
            .where("index", isEqualTo: realnum ~/ 10)
            .getDocuments()
            .then((onValue) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Player(
                        snapshot: onValue.documents[0],
                        number: (realnum % 10) == 0 ? 9 : (realnum % 10) - 1,
                      )));
          print(onValue.documents[0]);
        });
      }
      print(realnum);
    } else {
      FocusScope.of(context).requestFocus(new FocusNode());
      Toast.show("Enter a valid number", context, duration: 3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/background.jpg"))),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 50),
                child: Text("Thirukural Quotes",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
              ),
              Container(
                  margin:
                      EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 10),
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/about.png"),
                  )),
                  child: Container(
                    margin: EdgeInsets.only(left: 30, right: 20),
                    child: TextFormField(
                      controller: ctrl,
                      // onChanged: (data) {
                      //   setState(() {
                      //     print("set state called");
                      //     if (data.isNotEmpty) {
                      //       tempWidget = IconButton(
                      //           onPressed: () {
                      //             // (!temp)
                      //             //     ? setState(() {
                      //             //         tempWidget = IconButton(
                      //             //           icon: Icon(Icons.donut_large),
                      //             //           onPressed: () => print("clcked"),
                      //             //         );
                      //             //         temp = true;
                      //             //       })
                      //             //     : print("");
                      //             navigateroute(data, context);
                      //             // setState(() {
                      //             //   temp=true;
                      //             // });
                      //           },
                      //           icon: Icon(
                      //             Icons.arrow_right,
                      //             size: 40,
                      //           ));
                      //     } else {
                      //       tempWidget = IconButton(
                      //           onPressed: () =>
                      //               Toast.show("Enter a number", context),
                      //           icon: Icon(Icons.search));
                      //     }
                      //   });
                      // },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Enter a Number ",
                          suffixIcon: Container(
                              child: (!temp)
                                  ? IconButton(
                                      onPressed: () {
                                        if (ctrl.text.isNotEmpty) {
                                          setState(() {
                                            temp = true;
                                          });
                                          navigateroute(ctrl.text, context);
                                          setState(() {
                                            ctrl.clear();
                                            temp = false;
                                          });
                                        } else {
                                          FocusScope.of(context)
                                              .requestFocus(new FocusNode());
                                          Toast.show(
                                              "Enter valid number", context,
                                              duration: 3);
                                        }
                                      },
                                      icon: Icon(Icons.arrow_right),
                                    )
                                  : Container())),
                    ),
                  )),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: 270,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/thalapatra.png"))),
                  ),
                  Container(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.yellowAccent,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Lessons("araththuppaal")));
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text("Araththuppaal",
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: 270,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/thalapatra.png"))),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.yellowAccent,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Lessons("porutpaal")));
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text("Porutpaal",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: 270,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/thalapatra.png"))),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.yellowAccent,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Lessons("kaamaththuppaal")));
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Text("Kaamaththuppaal",
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
