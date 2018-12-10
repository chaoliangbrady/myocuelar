import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Ocuelar',
      theme: new ThemeData(
        // brightness: Brightness.dark,
        // primaryColorBrightness: Brightness.dark,
        primaryColor: Color(0xFF777777),
      ),
      home: new HomeScreen(),
      // debugShowCheckedModeBanner: false,
    );
  }
}

class Medication extends StatelessWidget {
  const Medication(this.name, this.brand, this.eye, this.frequency, this.takenFreq, this.betrcapid);
  
  final String name;
  final String brand;
  final String eye;
  final int frequency;
  final List<int> takenFreq;
  final String betrcapid;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
      .of(context)
      .textTheme;
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: new IntrinsicHeight(
        child: new Row(
          children: <Widget>[
            new Container(
              height: 100.0,
              width: 100.0,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: AssetImage(betrcapid == '' ? 'images/betagan.png' : 'images/$name.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                border: new Border.all(
                  color: betrcapid == '' ? Colors.orange : Color(0xFF00B5B8),
                  width: 3.0,
                )
              ),
              child: new Container(
                padding: betrcapid == '' ? EdgeInsets.all(10.0) : EdgeInsets.all(0.0),
                alignment: betrcapid == '' ? Alignment.center : Alignment(0.0, 1.6),
                child: new Text(
                  betrcapid == '' ? 'CLICK TO CONNECT' : 'CONNECTED',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: betrcapid == '' ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ),
            new Expanded(
              child: new Container(
                padding: EdgeInsets.only(left: 15.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(brand, style: textTheme.headline),
                    new Text(eye == 'B'
                      ? 'BOTH EYES'
                      : eye == 'L'
                      ? 'LEFT EYE'
                      : 'RIGHT EYE', style: textTheme.subhead.copyWith(fontWeight: FontWeight.bold)),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                          child: new Row(
                            children: <Widget>[
                              new Container(
                                padding: EdgeInsets.only(left: 10),
                                child: new Text(frequency.toString(), style: textTheme.headline.copyWith(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              new Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: new Column(
                                  children: <Widget>[
                                    new Text('PER', style: textTheme.subhead),
                                    new Text('DAY', style: textTheme.subhead),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        new Container(
                          child: new Row(
                            children: takenFreq.map((taken) => taken == 2
                            ? new Image.asset('images/takemedic.png')
                            : new Image.asset('images/untake.png'))
                            .toList(),
                            // children: <Widget>[
                            //   new Image.asset('images/takemedic.png'),
                            //   new Image.asset('images/untake.png'),
                            //   new Image.asset('images/untake.png'),
                            // ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ), 
          ],
        ),
      ),
    );
  }
}

class MedicationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: [
        new Medication('alphagan', 'Alphagan P', 'B', 2, [2, 0], 'OcuelarSmartCap04D1'),
        new Divider(color: Colors.grey),
        new Medication('azopt', 'Azopt', 'L', 3, [0, 2, 0], ''),
        new Divider(color: Colors.grey),
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Prescriptions'),
          // centerTitle: true,
          leading: Builder(
            builder: (BuildContext contexnt) {
              return IconButton(
              icon: const Icon(Icons.menu)
              , onPressed: () {},
              );
            },
          ),
        ),
        body: new MedicationList(),
    );
  }
}