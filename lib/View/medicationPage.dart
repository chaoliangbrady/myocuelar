import 'package:flutter/material.dart';

class Medication extends StatelessWidget {
  const Medication(this.name, this.brand, this.eye, this.frequency, this.takenFreq, this.betrcapid);
  
  final String name;
  final String brand;
  final String eye;
  final int frequency;
  final List<String> takenFreq;
  final String betrcapid;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme
      .of(context)
      .textTheme;
    return new Column(
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: new IntrinsicHeight(
            child: new Row(
              children: <Widget>[
                _buildMedicationImage(betrcapid, name),
                _buildMedicationDetail(textTheme, brand, eye, frequency, takenFreq),
              ],
            ),
          ),
        ),
        new Divider(color: Colors.grey),
      ],
    );
  }
}

Widget _buildMedicationImage(String betrcapid, String name) {
  return new Container(
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
  );
}

Widget _buildMedicationDetail(TextTheme textTheme, brand, String eye, int frequency, List<String>takenFreq) {
  return new Expanded(
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
                  children: takenFreq.map((taken) => taken == '2'
                  ? new Image.asset('images/takemedic.png')
                  : new Image.asset('images/untake.png'))
                  .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
