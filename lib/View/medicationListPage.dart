import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'medicationPage.dart';

const String apiUrl = 'http://ocuelardev-env.2newgtdtdd.us-west-2.elasticbeanstalk.com/php_api/api/web/index.php/v1';

class MedicationList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: loadMedications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("Error");
            }

            return new ListView(
              // tip: The problem here is that type inference fails in an unexpected way.
              // The solution is to provide a type argument to the map method.
              // https://stackoverflow.com/questions/49603021/type-listdynamic-is-not-a-subtype-of-type-listwidget
              children: snapshot.data.medications.map<Widget>((med) => new Medication(
                med.medicationShortName,
                med.medicationBrandName,
                med.eye,
                med.frequencyId,
                med.takenFreq,
                med.betrcapId
              )).toList(),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class MedicationData {
  final String userMedicationId;
  final String medicationId;
  final String dosage;
  final String eye;
  final String frequencyId;
  final String freqSchedule;
  final String notes;
  final String isActive;
  final String activeStartDate;
  final String activeEndDate;
  final String creationDate;
  final String createdBy;
  final String lastUpdateDate;
  final String lastUpdateBy;
  final String userId;
  final String medicationShortName;
  final String medicationBrandName;
  final String medicationGenericName;
  final String totalFreq;
  final List<String> takenFreq;
  final String betrcapId;

  MedicationData({
    this.userMedicationId,
    this.medicationId,
    this.dosage,
    this.eye,
    this.frequencyId,
    this.freqSchedule,
    this.notes,
    this.isActive,
    this.activeStartDate,
    this.activeEndDate,
    this.creationDate,
    this.createdBy,
    this.lastUpdateDate,
    this.lastUpdateBy,
    this.userId,
    this.medicationShortName,
    this.medicationBrandName,
    this.medicationGenericName,
    this.totalFreq,
    this.takenFreq,
    this.betrcapId,
  });

  factory MedicationData.fromJson(Map<String, dynamic> json) {
    return new MedicationData(
      userMedicationId: json['user_medication_id'],
      medicationId: json['medication_id'],
      dosage: json['dosage'],
      eye: json['eye'],
      frequencyId: json['frequency_id'],
      freqSchedule: json['freq_schedule'],
      notes: json['notes'],
      isActive: json['is_active'],
      activeStartDate: json['active_start_date'],
      activeEndDate: json['active_end_date'],
      creationDate: json['creation_date'],
      createdBy: json['created_by'],
      lastUpdateDate: json['last_update_date'],
      lastUpdateBy: json['last_update_by'],
      userId: json['user_id'],
      medicationShortName: json['medication_short_name'],
      medicationBrandName: json['medication_brand_name'],
      medicationGenericName: json['medication_generic_name'],
      totalFreq: json['total_freq'],
      takenFreq: json['taken_freq'].split(','),
      betrcapId: json['betrcapid'],
    );
  }
}
class MedicationListData {
  final List<MedicationData> medications;

  MedicationListData({
    this.medications,
  });

  factory MedicationListData.fromJson(List<dynamic> parsedJson) {
    List<MedicationData> medications = new List<MedicationData>();
    medications = parsedJson.map((i)=> MedicationData.fromJson(i)).toList();

    return new MedicationListData(
      medications: medications,
    );
  }
}

Future<String> _loadMedicationListData() async {
  final response = await http.get('$apiUrl/prescription/presplist/59');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return response.body;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load medication list');
  }
}

Future loadMedications() async {
  String jsonMedicatinos = await _loadMedicationListData();
  final jsonResponse = json.decode(jsonMedicatinos);
  MedicationListData medicationListData = MedicationListData.fromJson(jsonResponse);
  return medicationListData;
}