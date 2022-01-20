import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:naamkaran/favorite.dart';
import 'package:naamkaran/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:naamkaran/model.dart';
import 'package:naamkaran/model1.dart';

class GirlScreen extends StatefulWidget {
  const GirlScreen({Key? key}) : super(key: key);

  @override
  _GirlScreenState createState() => _GirlScreenState();
}

class _GirlScreenState extends State<GirlScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  List<Example> casteCategory = [];
  List<Religion> nameArr = [];

  @override
  void initState() {
    super.initState();

    hinduGirl();
    categoryApiCall();
    girlHinduApiCall();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: BackButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          title: Container(
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Naamkaran"),
                SizedBox(
                  width: 40,
                ),
                Image.asset(
                  "assets/girl1.png",
                  width: 50,
                ),
                SizedBox(
                  width: 13,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavoriteNames()));
                  },
                  child: Image.asset(
                    "assets/favourite.png",
                    height: 30,
                    width: 30,
                  ),
                ),
                SizedBox(
                  width: 13,
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 35,
                    )),
              ],
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Container(
                  child: Text(
                    "Hindu",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    "Muslim",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  child: Text(
                    "christian",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
            indicatorColor: Colors.blue,
            indicatorWeight: 5,
          ),
        ),
        extendBodyBehindAppBar: true,
        // body: TabBarView(children: [
        //   hinduGirl(),
        //   hinduGirl(),
        //   hinduGirl(),
        // ]),

        body: Stack(
          children: [
            Container(
              color: Colors.amber,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            ListView.builder(itemBuilder: (Context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      // top: 50,
                    ),
                    child: Container(
                      child: Text(
                        nameArr[index].name!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Container(
                      child: Text(nameArr[index].meaning!,
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ],
              );
            }),
            TabBarView(children: [
              hinduGirl(),
              hinduGirl(),
              hinduGirl(),
            ])
          ],
        ),
      ),
    );
  }

  hinduGirl() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background3.jpg"), fit: BoxFit.fill),
      ),
    );
  }

  girlHinduApiCall() {
    http
        .get(Uri.parse(
            "https://mapi.trycatchtech.com/v1/naamkaran/post_list_by_cat_and_gender?category_id=3&gender=2"))
        .then((data) {
      print("Name api called ${data.body}");
      var jsonResp1 = jsonDecode(data.body);
      for (var item in jsonResp1) {
        nameArr.add(Religion.fromJson(item));
      }
      print("names of ${nameArr[0]}");
      setState(() {
        print(
          "hello",
        );
      });
    });
  }

  categoryApiCall() {
    print('inside api');
    http
        .get(Uri.parse(
            "http://mapi.trycatchtech.com/v1/naamkaran/category_list"))
        .then((resp) {
      print('a');
      var jsonResp = jsonDecode(resp.body);
      // var userResp = Example.fromJson(jsonResp);
      for (var item in jsonResp) {
        casteCategory.add(Example.fromJson(item));
      }
      print(casteCategory[0]);
    });
    print('outside  apiii');
  }
}
