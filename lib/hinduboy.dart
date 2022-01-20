import 'dart:convert';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:naamkaran/model.dart';
import 'package:naamkaran/model1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expandable_text/expandable_text.dart'; //package for expanding text
import 'package:clipboard/clipboard.dart';

class HinduBoy extends StatefulWidget {
  final String categoryid;
  final String genderId;

  const HinduBoy({
    Key? key,
    required this.categoryid,
    required this.genderId,
  }) : super(key: key);

  @override
  _HinduBoyState createState() => _HinduBoyState();
}

class _HinduBoyState extends State<HinduBoy> {
  List<Example> casteCategory = [];
  List<Religion> names = [];
  var favourite = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryApiCall();
    hinduApiCall();
  }

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemCount: names.length,
    //   itemBuilder: (_, index) {
    //     return Padding(
    //       padding: const EdgeInsets.fromLTRB(15, 2, 150, 2),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             names[index].name!,
    //             // maxLines: ,
    //             // overflow: TextOverflow.fade,
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 25,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),

    //           SizedBox(
    //             height: 10,
    //           ),

    //           ExpandableText(
    //             names[index].meaning!,
    //             expandText: "Show more",
    //             collapseText: "Show less",
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontSize: 20,
    //             ),
    //           ),

    // Padding(
    //   padding: const EdgeInsets.only(
    //     left: 20,
    //   ),
    //   child: ExpandableText(
    //     expandte
    //   ),
    //   // child: Text(
    //   //   names[index].meaning!,
    //   //   style: TextStyle(
    //   //     color: Colors.white,
    //   //     fontSize: 20,
    //   //   ),
    //   // ),
    // ),

    //           SizedBox(height: 20),
    //         ],
    //       ),
    //     );
    //   },
    // );
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage("assets/background6.jpg"), fit: BoxFit.fill),
          ),
        ),
        ListView.builder(
          itemCount: names.length,
          itemBuilder: (_, index) {
            return Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        names[index].name!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 200,
                          alignment: Alignment.centerLeft,
                          child: ExpandableText(
                            names[index].meaning!,
                            expandText: "Show more",
                            collapseText: "Show less",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        // Icon(Icons.favorite,color: Colors.red,),
                        SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                          onTap: () async {
                            List<String> temp =
                                []; // creating a variable name temp
                            temp.add(
                                "${names[index].name.toString()}"); // adding name into temp
                            SharedPreferences preferences =
                                await SharedPreferences
                                    .getInstance(); //object call
                            favourite =
                                temp; // saving temp value in favourite array
                            print("${favourite}"); // printing value in favorite
                            preferences.setStringList(
                                "favName", temp); //key and value
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Successfully added")));
                          },
                          // child: Image.asset(
                          //   "assets/favourite.png",
                          //   // height: names[index].isFav ? 10 : 30,
                          //   // width: names[index].isFav ? 10 : 30,
                          //   height: 30,
                          //   width: 30,
                          //   // color:
                          //   //     names[index].isFav ? Colors.red : Colors.white,
                          //   icon

                          //   // color: Colors.amber,
                          // ),

                          child: Icon(
                            Icons.favorite,
                            size: 40,
                            color:
                                names[index].isFav ? Colors.red : Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                          // height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            FlutterClipboard.copy(names[index].name!);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Copied successfully")));
                          },
                          child: Icon(
                            Icons.copy,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(width: 20),
                        Icon(
                          Icons.share,
                          color: Colors.white,
                          size: 30,
                        ),
                        // Image.asset(
                        //   "assets/favourite.png",
                        //   height: 30,
                        //   width: 30,
                        //   // color: Colors.amber,
                        // ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  categoryApiCall() {
    http
        .get(Uri.parse(
            "http://mapi.trycatchtech.com/v1/naamkaran/category_list"))
        .then((resp) {
      print("Api call done ${resp.body}");
      var jsonResp = jsonDecode(resp.body);
      // var userResp = Example.fromJson(jsonResp);
      for (var item in jsonResp) {
        casteCategory.add(Example.fromJson(item));
      }
      print(casteCategory);
    });
  }

  hinduApiCall() {
    http
        .get(Uri.parse(
            "https://mapi.trycatchtech.com/v1/naamkaran/post_list_by_cat_and_gender?category_id=${widget.categoryid}&gender=${widget.genderId}"))
        .then((value) async {
      print("Name api called ${value.body}");
      var jsonResp1 = jsonDecode(value.body);
      SharedPreferences preferences = await SharedPreferences.getInstance();

      List<String> favArr = preferences.getStringList("favName") == null
          ? []
          : preferences.getStringList("favName")!;
      print("FAVVVV $favArr");
      for (var item in jsonResp1) {
        Religion r = Religion.fromJson(item);
        if (favArr.contains(r.name)) {
          r.isFav = true;
        }

        names.add(r);
      }
      print("names of ${names[0]}");
      setState(() {
        print(
          "hello",
        );
      });
    });
  }
}
