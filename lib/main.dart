import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_covid19/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: TextTheme(
            display1: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            headline: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            )),
      ),
      home: startScreen(),
    );
  }
}

class startScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/covid19.jpg'),
                      fit: BoxFit.cover)),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "COVID-19",
                        style: Theme.of(context).textTheme.display1,
                      ),
                      TextSpan(
                        text: "\n STAY HOME BE SAFE!",
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ])),
              ],
            ),
          ),
          FittedBox(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DashBoard();
                }));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.red),
                child: Row(
                  children: <Widget>[
                    Text("NEXT"),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
