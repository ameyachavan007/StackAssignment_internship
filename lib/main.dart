import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:demo/constants.dart';
import 'package:demo/glass_container.dart';
import 'package:demo/knob_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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
  final double _minimum = 14;
  final double _maximum = 28;

  late KnobController _controller;
  late double _knobValue;

  void valueChangedListener(double value) {
    if (mounted) {
      setState(() {
        _knobValue = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _knobValue = _minimum;
    _controller = KnobController(
      initial: _knobValue,
      minimum: _minimum,
      maximum: _maximum,
      startAngle: 0,
      endAngle: 180,
    );
    _controller.addOnValueChangedListener(valueChangedListener);
  }

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
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      isDismissible: false,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20.0),
                                      )),
                                      context: context,
                                      builder: (context) {
                                        return buildSheet(
                                            isTempOn, _controller);
                                      });
                                },
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
                                                  fontWeight: FontWeight.normal,
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Statistics",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Month",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      GlassContainer(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 20, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Electricity Usage",
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
                                      color:
                                          isTVOn ? Colors.black : Colors.white,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0,
                                      left: 20.0,
                                      right: 20.0,
                                      bottom: 40.0),
                                  child: Center(
                                    child: Text(
                                      "Chart",
                                      style: TextStyle(
                                          fontSize: 32, color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          start: 0.3,
                          end: 0.8)
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

Widget buildSheet(bool val, KnobController _controller) {
  return DraggableScrollableSheet(
      initialChildSize: 0.90,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (_, controller) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: ListView(
              controller: controller,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Living Room",
                          style: TextStyle(
                              fontSize: 24,
                              color: kBlack,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Home Temperature",
                          style: TextStyle(
                              fontSize: 18,
                              color: kGrey,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    FlutterSwitch(
                        activeColor: Color.fromRGBO(225, 155, 117, 1),
                        value: val,
                        onToggle: (value) {
                          setState(() {
                            val = value;
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Knob(
                      controller: _controller,
                      width: 200,
                      height: 200,
                      style: KnobStyle(
                        labelStyle: TextStyle(
                          color: kBlack,
                          fontSize: 18,
                        ),
                        tickOffset: 5,
                        labelOffset: 10,
                        minorTicksPerInterval: 5,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current temp",
                          style: TextStyle(
                            fontSize: 18,
                            color: kGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.caretUp,
                              color: kGrey.withOpacity(0.8),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: RichText(
                                text: TextSpan(
                                  text: "24",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                      color: kBlack),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "°C",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: kBlack),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Current humidity",
                          style: TextStyle(
                            fontSize: 18,
                            color: kGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.caretDown,
                              color: kGrey.withOpacity(0.8),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: RichText(
                                text: TextSpan(
                                  text: "54",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                      color: kBlack),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "%",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: kBlack),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Cards(
                      text: "Heating",
                      temp: "24",
                      color: kOrange,
                    ),
                    Cards(
                      text: "Cooling",
                      temp: "18",
                      color: Colors.green,
                    ),
                    Cards(
                      text: "Airwave",
                      temp: "20",
                      color: kLightGrey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: kLightGrey,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: RichText(
                              text: TextSpan(
                                text: "Fan\n",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0,
                                    color: kBlack),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Off",
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: kBlack),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FaIcon(FontAwesomeIcons.fan, color: kGrey),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: kLightGrey,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: RichText(
                              text: TextSpan(
                                text: "Cooler\n",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0,
                                    color: kBlack),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Off",
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: kBlack),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FaIcon(FontAwesomeIcons.snowflake,
                                color: kGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
      });
}

class Cards extends StatelessWidget {
  final String text;
  final Color color;
  final String temp;
  const Cards({
    Key? key,
    required this.text,
    required this.color,
    required this.temp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kLightGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text + "\t\t",
                  style: TextStyle(
                    fontSize: 12,
                    color: kBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.solidCircle,
                  color: color,
                  size: 5,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: RichText(
              text: TextSpan(
                text: temp,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 24.0, color: kBlack),
                children: <TextSpan>[
                  TextSpan(
                    text: "°C",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: kBlack),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
