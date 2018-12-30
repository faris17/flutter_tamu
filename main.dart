import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_wedding/myData.dart';

void main() => runApp(new MaterialApp(home: new ShowDataPage()));

class ShowDataPage extends StatefulWidget {

  @override
  _ShowDataPageState createState() => _ShowDataPageState();

}

class _ShowDataPageState extends State<ShowDataPage> {

  List<myData> allData = [];



  @override

  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('tamu').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for (var key in keys) {
        myData d = new myData(
          data[key]['nama'],
        );
        allData.add(d);
      }
      setState(() {
        print('Length : ${allData.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Firebase Data'),
      ),

      body: new Container(
          decoration: BoxDecoration(
            image:
            DecorationImage(image: AssetImage('images/background.jpg'), fit: BoxFit.cover),
          ),
          child: allData.length == 0
              ? new Text(' No Data is Available')
              : new ListView.builder(
            itemCount: allData.length,
            itemBuilder: (_, index) {
              return UI(
                allData[index].nama,
              );
            },
          )),
    );
  }



  Widget UI(String nama) {

    return new Card(

      elevation: 10.0,

      child: new Container(

        padding: new EdgeInsets.all(20.0),

        child: new Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

            new Text('Name : $nama',style: Theme.of(context).textTheme.title,),



          ],

        ),

      ),

    );

  }

}