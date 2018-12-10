import 'package:flutter/material.dart';
import 'View/medicationListPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Ocuelar',
      theme: new ThemeData(
        primaryColor: Color(0xFF777777),
      ),
      home: new HomeScreen(),
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