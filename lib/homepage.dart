import 'package:flutter/material.dart';
import 'package:naamkaran/boy.dart';
import 'package:naamkaran/favorite.dart';
import 'package:naamkaran/girl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/start3.jpeg"), fit: BoxFit.fill)),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('click');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => BoyScreen(
                                  genderId: "1", // passing gender id here
                                )));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: AssetImage("assets/boy.png")),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("clicked");
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => BoyScreen(
                                  genderId: "2",
                                )));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: AssetImage("assets/girl.png")),
                        ),
                      ),
                    ),
                  ],
                ),
                // ElevatedButton(onPressed: () {}, child: Text("data")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 550, left: 140),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => FavoriteNames()));
              },
              child: Image.asset(
                "assets/fav1.png",
              ),
            ),
          ),
        ],
      )),
    );
  }
}
