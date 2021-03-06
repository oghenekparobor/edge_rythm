import 'package:edge_rythm/business_logic/services/providers/producer.dart';
import 'package:edge_rythm/views/ui/streaming/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../business_logic/services/providers/nav_provider.dart';
import '../util/gradient_button.dart';
import 'home.dart';

enum EdgeRythm { streaming, producers, events }

class WhatDoYouWantScreen extends StatefulWidget {
  static const route = '/whatdoyouwant';
  WhatDoYouWantScreen({Key key}) : super(key: key);

  @override
  _WhatDoYouWantScreenState createState() => _WhatDoYouWantScreenState();
}

class _WhatDoYouWantScreenState extends State<WhatDoYouWantScreen> {
  EdgeRythm _edgeRythm = EdgeRythm.producers;

  void nextPage(BuildContext context) {
    var nav = Provider.of<NavProvider>(context, listen: false);
    switch (_edgeRythm) {
      case EdgeRythm.producers:
        nav.topBar = 0;
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomeScreen.route, (route) => false);
        break;

      case EdgeRythm.events:
        nav.topBar = 1;
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomeScreen.route, (route) => false);
        break;

      case EdgeRythm.streaming:
        Navigator.of(context).pushNamed(StreamingMusicScree.route);
        break;
    }
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Future.wait([
        Provider.of<ProducersProvider>(context, listen: false)
            .fetchCategories(context),
        Provider.of<ProducersProvider>(context, listen: false)
            .fetchProducers(context),
      ]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 15),
          Text(
            'What do you want to do?',
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          Text(
            'Lets get you started.',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              setState(() {
                _edgeRythm = EdgeRythm.producers;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _edgeRythm == EdgeRythm.producers
                      ? Theme.of(context).accentColor
                      : Colors.grey.shade700,
                  width: 1,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                leading: Icon(Icons.music_note),
                title: Text(
                  'Book studio session',
                  style: Theme.of(context).textTheme.headline5,
                ),
                subtitle: Text(
                  'Browse through expert music producers and get started',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Radio(
                  activeColor: Theme.of(context).accentColor,
                  value: EdgeRythm.producers,
                  groupValue: _edgeRythm,
                  onChanged: (EdgeRythm e) {
                    setState(() {
                      _edgeRythm = e;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              setState(() {
                _edgeRythm = EdgeRythm.events;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _edgeRythm == EdgeRythm.events
                      ? Theme.of(context).accentColor
                      : Colors.grey.shade700,
                  width: 1,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                leading: Icon(Icons.music_note),
                title: Text(
                  'Buy event ticket',
                  style: Theme.of(context).textTheme.headline5,
                ),
                subtitle: Text(
                  'Browse through upcoming events and book your tickets.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Radio(
                  activeColor: Theme.of(context).accentColor,
                  value: EdgeRythm.events,
                  groupValue: _edgeRythm,
                  onChanged: (EdgeRythm e) {
                    setState(() {
                      _edgeRythm = e;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              setState(() {
                _edgeRythm = EdgeRythm.streaming;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _edgeRythm == EdgeRythm.streaming
                      ? Theme.of(context).accentColor
                      : Colors.grey.shade700,
                  width: 1,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 15),
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: ListTile(
                leading: Icon(Icons.music_note),
                title: Text(
                  'Music streaming',
                  style: Theme.of(context).textTheme.headline5,
                ),
                subtitle: Text(
                  'Browse through popular and trending musics.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Radio(
                  activeColor: Theme.of(context).accentColor,
                  value: EdgeRythm.streaming,
                  groupValue: _edgeRythm,
                  onChanged: (EdgeRythm e) {
                    setState(() {
                      _edgeRythm = e;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GradientRaisedButton(
              child: Text(
                'Continue',
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: () => nextPage(context),
            ),
          )
        ],
      ),
    );
  }
}
