import 'package:flutter/material.dart';
import 'package:naamkaran/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteNames extends StatefulWidget {
  const FavoriteNames({Key? key}) : super(key: key);

  @override
  _FavoriteNamesState createState() => _FavoriteNamesState();
}

class _FavoriteNamesState extends State<FavoriteNames> {
  List<String> data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Favorite"),
        elevation: 30,
        leading: BackButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: Container(
        color: Colors.teal,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Text(data[index]),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: data.length),
      ),
    );
  }

  sharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      data = pref.getStringList("favName")!;
    });
  }
}
