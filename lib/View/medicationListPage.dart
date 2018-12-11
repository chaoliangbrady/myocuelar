import 'package:flutter/material.dart';
import 'medicationPage.dart';

class MedicationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: [
        new Medication('alphagan', 'Alphagan P', 'B', 2, ['2', '0'], 'OcuelarSmartCap04D1'),
        new Medication('azopt', 'Azopt', 'L', 3, ['0', '2', '0'], ''),
      ],
    );
  }
}