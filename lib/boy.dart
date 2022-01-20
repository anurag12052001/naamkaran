import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:naamkaran/hinduboy.dart';
import 'package:http/http.dart' as http;
import 'package:naamkaran/homepage.dart';
import 'package:naamkaran/model.dart';
import 'package:naamkaran/model1.dart';

import 'favorite.dart';

class BoyScreen extends StatefulWidget {
  const BoyScreen({Key? key, required this.genderId}) : super(key: key);
  final String genderId;

  @override
  _BoyScreenState createState() => _BoyScreenState();
}

// Color PrimaryColor = Color(0xff109618);

class _BoyScreenState extends State<BoyScreen> {
  List<Example> casteCategory = [];
  List<Religion> names = [];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    categoryApiCall();
    print(
      "abcdef",
    );
    // MuslimBoy();
    muslimApiCall();
  }

  @override
  Widget build(BuildContext context) {
    var appHeight = (MediaQuery.of(context).padding.top +
        kToolbarHeight +
        kTextTabBarHeight);
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            "assets/background6.jpg",
            // fit: BoxFit.fill,
          ),
        ),
        DefaultTabController(
          length: 3, // hindu, muslim, christian 3 rhenge
          initialIndex: 0, // starting 0 index se hoga hindu se hoga
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              // backgroundColor: PrimaryColor,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: BackButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
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
                    if (widget.genderId == "1") ...[
                      Image.asset(
                        'assets/boy1.png',
                        width: 50,
                        height: 40,
                      )
                    ] else if (widget.genderId == "2") ...[
                      Image.asset(
                        'assets/girl1.png',
                        width: 50,
                        height: 40,
                      )
                    ],
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
                        onPressed: () {
                          showSearch(
                            context: context,
                            delegate: CustomSearchDelegate(names),
                          );
                        },
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
                // isScrollable: true,  // to make tabbar scrollable
                indicatorColor: Colors.blue,
                indicatorWeight: 5,
                //   onTap: (index) {     // to set different colors for tabbar
                //     setState(() {
                //       switch (index) {
                //         case 0:
                //           PrimaryColor = Color(0xffff5722);
                //           break;
                //         case 1:
                //           PrimaryColor = Color(0xff3f51b5);
                //           break;
                //         case 2:
                //           PrimaryColor = Color(0xffe91e63);
                //           break;
                //         default:
                //       }
                //     });
                //   },
              ),
            ),
            // extendBodyBehindAppBar: true,
            // body: SafeArea(
            //   child: Container(
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage("assets/background2.jpg"),
            //           fit: BoxFit.fill),
            //     ),
            //   ),
            // ),

            body: Stack(children: [
              TabBarView(children: [
                HinduBoy(
                  categoryid: "3",
                  genderId: widget.genderId,
                  // height: appHeight,
                ),
                HinduBoy(
                  categoryid: "8",
                  genderId: widget.genderId,
                  // height: appHeight,
                ),
                HinduBoy(
                  categoryid: "10",
                  genderId: widget.genderId,
                  // height: appHeight,
                ),
              ]),
              if (names.isEmpty) ...[
                Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                )
              ]
            ]),
          ),
        )
      ],
    );
  }

  // MuslimBoy() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       image: DecorationImage(
  //           image: AssetImage("assets/background3.jpg"), fit: BoxFit.fill),
  //     ),
  //   );
  // }

  muslimApiCall() {
    http
        .get(Uri.parse(
            "https://mapi.trycatchtech.com/v1/naamkaran/post_list_by_cat_and_gender?category_id=8&gender=1"))
        .then((value1) {
      print("muslim api call ${value1.body}");
      var jsonResp2 = jsonDecode(value1.body);
      for (var item in jsonResp2) {
        names.add(Religion.fromJson(item));
      }
      print("names of ${names[0]}");
      setState(() {
        // print("muslim names printed");
      });
    });
  }

  // ChristianBoy() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       image: DecorationImage(
  //           image: AssetImage("assets/background5.jpg"), fit: BoxFit.fill),
  //     ),
  //   );
  // }

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
    print('outside  api');
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<Religion> searchName;
  CustomSearchDelegate(this.searchName);
  @override
  List<Widget>? buildActions(BuildContext context) {
    // what kind of actions we gonna perform in the search bar
    return [
      IconButton(
          onPressed: () {
            query =
                ""; // it will clear everything written when we'll press clear button
          },
          icon: Icon(
            Icons.clear, // clear button on the right side of the search bar
            color: Colors.red,
          )),
    ];
    // throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // here we will provide leading icon
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // it is used for searching

    List<Religion> searchQuery = [];
    for (var item in searchName) {
      if (item.name!.toLowerCase().contains(query.toLowerCase())) {
        searchQuery.add(item);
      }
    }
    return Stack(
      children: [
        Container(
          color: Colors.amber,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: ListView.builder(
              itemCount: searchQuery.length,
              itemBuilder: (context, indexNo) {
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              searchQuery[indexNo].name.toString(),
                              style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ), // text only accept string thats why we used tostring. now it will show all the names
                            SizedBox(height: 5),
                            SizedBox(
                              width: 200,
                              child: Text(
                                searchQuery[indexNo].meaning.toString(),
                                maxLines: 2,
                                overflow: TextOverflow
                                    .ellipsis, // specifies how overflowed content that is not displayed should be signaled to the user
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                );
              },
            )),
      ],
    );

    // throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // it will show suggestions when someone comes for search
    List<Religion> searchQuery = [];
    for (var item in searchName) {
      if (item.name!.toLowerCase().contains(query.toLowerCase())) {
        searchQuery.add(item);
      }
      if (searchQuery.isEmpty) {
        return Center(
          child: Text("No data found"),
        );
      } else {
        return Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/background2.jpg",
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: ListView.builder(
                  itemCount: searchQuery.length,
                  itemBuilder: (context, indexNo) {
                    return Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  searchQuery[indexNo].name.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    searchQuery[indexNo].meaning.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  }),
            ),
          ],
        );
      }
    }
    throw UnimplementedError();
  }
}
