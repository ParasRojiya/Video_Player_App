import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../global/global.dart';
import '../modals/modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Videos> videoList = [];

  jsonData() async {
    String jsonData =
        await rootBundle.loadString('assets/jsonData/jsonData.json');

    List categoryList = jsonDecode(jsonData);

    setState(() {
      videoList = categoryList.map((e) => Videos.fromJSON(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    jsonData();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Player"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.white70,
      body: Container(
        margin: const EdgeInsets.only(top: 12),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: videoList.length,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                Global.categoryVideos = videoList[i];
                Navigator.of(context)
                    .pushNamed('video_page', arguments: videoList[i]);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 220,
                    width: 350,
                    margin: const EdgeInsets.only(top: 12),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                      ),
                      image: DecorationImage(
                        image: AssetImage("${videoList[i].image}"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    alignment: const Alignment(-0.9, 0),
                    child: Text(
                      "${videoList[i].category}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
