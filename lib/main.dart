import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:demo/constants.dart';
import 'package:demo/glass_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:glassmorphism/glassmorphism.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Smart Home Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return 'Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  bool isPlaying = false;
  bool isTempOn = false;
  bool isPlugOn = false;
  bool isTVOn = false;

  // final audios = <Audio>[
  //   Audio(
  //     'audio/song_one.mp3',
  //     metas: Metas(
  //       id: 'Rock',
  //       title: 'Song One',
  //       artist: 'Artist one',
  //       album: 'One',
  //       image: MetasImage.network(
  //           'https://static.radio.fr/images/broadcasts/cb/ef/2075/c300.png'),
  //     ),
  //   ),
  //   Audio(
  //     'audio/song_two.mp3',
  //     metas: Metas(
  //       id: 'Metal',
  //       title: 'Song Two',
  //       artist: 'Artist Two',
  //       album: 'Two',
  //       image: MetasImage.network(
  //           'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
  //     ),
  //   ),
  // ];

  AssetsAudioPlayer player = AssetsAudioPlayer();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String greetingMes = greetingMessage();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/living_room.jpg"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 32, right: 24, left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: greetingMes + "\n",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                            color: kLightGrey),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Chris Copper",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    GlassContainer(
                      start: 0.3,
                      end: 0.8,
                      child: IconButton(
                        onPressed: () {},
                        icon: FaIcon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Text(
                        "Living Room",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GlassContainer(
                            child: Container(
                              decoration: BoxDecoration(
                                color: isTempOn
                                    ? Colors.white
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 20.0),
                                    child: Text(
                                      "Home",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isTempOn
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 20.0),
                                    child: Text(
                                      "Temperature",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: isTempOn
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "23\t",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24.0,
                                            color: isTempOn
                                                ? Colors.black
                                                : Colors.white),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "°C",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: isTempOn
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      bottom: 10,
                                    ),
                                    child: FlutterSwitch(
                                        activeColor:
                                            Color.fromRGBO(225, 155, 117, 1),
                                        value: isTempOn,
                                        onToggle: (value) {
                                          setState(() {
                                            isTempOn = value;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            // switchColour: isTempOn,
                            start: 0.3,
                            end: 0.8,
                          ),
                          GlassContainer(
                            child: Container(
                              decoration: BoxDecoration(
                                color: isPlugOn
                                    ? Colors.white
                                    : Colors.transparent,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 20, top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Plug Wall",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: isPlugOn
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 30.0),
                                        FaIcon(
                                          FontAwesomeIcons.angleRight,
                                          size: 14,
                                          color: isPlugOn
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10.0),
                                        child: Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.solidCircle,
                                              size: 10.0,
                                              color: isPlugOn
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              "MacBook Pro",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: isPlugOn
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10.0),
                                        child: Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.solidCircle,
                                              size: 10.0,
                                              color: isPlugOn
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              "HomePod",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: isPlugOn
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      top: 20,
                                      bottom: 10,
                                    ),
                                    child: FlutterSwitch(
                                        activeColor:
                                            Color.fromRGBO(225, 155, 117, 1),
                                        value: isPlugOn,
                                        onToggle: (value) {
                                          setState(() {
                                            isPlugOn = value;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            start: 0.3,
                            end: 0.8,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GlassContainer(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 10.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 40.0,
                                          width: 40.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "images/living_room.jpg"),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Song_name",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "Artist_name",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                            FontAwesomeIcons.stepBackward,
                                            color: Colors.white),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(FontAwesomeIcons.pause,
                                            color: Colors.white),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.stepForward,
                                          color: Colors.white,
                                        ),
                                        splashColor: kGrey,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              start: 0.3,
                              end: 0.8),
                          GlassContainer(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isTVOn
                                      ? Colors.white
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 20, top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Smart TV",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: isTVOn
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 30.0),
                                          FaIcon(
                                            FontAwesomeIcons.angleRight,
                                            size: 14,
                                            color: isTVOn
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Samsung UA55 4AC",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: isTVOn
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        top: 20,
                                        bottom: 10,
                                      ),
                                      child: FlutterSwitch(
                                          activeColor:
                                              Color.fromRGBO(225, 155, 117, 1),
                                          value: isTVOn,
                                          onToggle: (value) {
                                            setState(() {
                                              isTVOn = value;
                                            });
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              start: 0.3,
                              end: 0.8)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
