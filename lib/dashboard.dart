import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<Covid> fetchData() async {
  final response = await http
      .get("https://corona.lmao.ninja/v2/countries/india?yesterday=false");
  if (response.statusCode == 200) {
    return Covid.fromJson(json.decode(response.body));
  } else {
    throw Exception('failed to load data');
  }
}

class Covid {
  final int deaths;
  final int cases;
  final int recovered;
  final int active;
  final int updated;

  Covid({this.deaths, this.cases, this.recovered, this.active, this.updated});

  factory Covid.fromJson(Map<String, dynamic> json) {
    return Covid(
        cases: json['cases'],
        deaths: json['deaths'],
        recovered: json['recovered'],
        active: json['active'],
        updated: json['updated']);
  }
}

class DashBoard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<DashBoard> {
  Future<Covid> futureCovid;
  @override
  void initState() {
    futureCovid = fetchData();
    super.initState();
  }

  String _dateTimeFormart(int timeinMileSeconds) {
    var date = DateTime.fromMillisecondsSinceEpoch(timeinMileSeconds);
    var fomatDate = DateFormat("dd-MM-yyyy hh:mm:ss").format(date);
    return fomatDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder<Covid>(
        future: futureCovid,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/covid19.jpg'),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Cases :",
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.amber),
                          ),
                          Text(
                            snapshot.data.cases.toString(),
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Deaths :",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.deepOrange),
                          ),
                          Text(
                            snapshot.data.deaths.toString(),
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Recovered:",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.deepOrange),
                          ),
                          Text(
                            snapshot.data.recovered.toString(),
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Active :",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.deepOrange),
                          ),
                          Text(
                            snapshot.data.active.toString(),
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.black12,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Designed by Senthilkumar \nLast update :${_dateTimeFormart(snapshot.data.updated)}",
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.amber),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {}
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
