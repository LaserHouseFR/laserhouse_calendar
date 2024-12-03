library globals;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String titre = 'Calendrier LaserHouse';
String currentDateInString = DateFormat.yMMMMEEEEd('fr').format(DateTime.now());
String currentYearInString = DateFormat.y('fr').format(DateTime.now());
String nextYearInString = (int.parse(DateFormat.y('fr').format(DateTime.now())) + 1).toString();

bool isMaillot = false;
bool isJambes = true;
Color backTitleColor = const Color.fromARGB(255, 75, 103, 171);

DateTime startOfYear = DateTime(DateTime.now().year, 1, 1);
int currentDaySinceBeginOfYear = DateTime.now().difference(startOfYear).inDays;
int processingDay = 0;

List<String> monthNames = [
  'Janvier',
  'Février',
  'Mars',
  'Avril',
  'Mai',
  'Juin',
  'Juillet',
  'Août',
  'Septembre',
  'Octobre',
  'Novembre',
  'Décembre',
  'Janvier',
  'Février',
  'Mars',
  'Avril',
  'Mai',
  'Juin',
  'Juillet',
  'Août',
  'Septembre',
  'Octobre',
  'Novembre',
  'Décembre'
];

int score = 0;
var espacementSeancesMaillot = [7, 7, 9, 9, 11];
var espacementSeancesJambes = [9, 9, 11, 11, 13];
var optimalSpace = [9, 9, 11, 11, 13];

List<int> buttonScore = List.filled(750, 100);

//Status : null, Seance1, Seance2, Seance3, Seance4, Seance5, Seance6
//Status : Sun1, Sun2, NoExposure1, NoExposure2
//Status : BeforeActualDate, ClosedDay, AcutalDay
List<String> buttonStatus = List.filled(750, 'null');
int dayBeginSun1 = 0;
int dayEndSun1 = 0;
int dayBeginSun2 = 0;
int dayEndSun2 = 0;
int seance1 = 0;
int seance2 = 0;
int seance3 = 0;
int seance4 = 0;
int seance5 = 0;
int seance6 = 0;

String dateSeance1 = '---. -- ---. ----';
String dateSeance2 = '---. -- ---. ----';
String dateSeance3 = '---. -- ---. ----';
String dateSeance4 = '---. -- ---. ----';
String dateSeance5 = '---. -- ---. ----';
String dateSeance6 = '---. -- ---. ----';

bool isCalculating = false;
String startStopButtonText = 'Start';

bool isSooner = false;

int fixSeance1 = 0;
int fixSeance2 = 0;
int fixSeance3 = 0;
int fixSeance4 = 0;
int fixSeance5 = 0;
int fixSeance6 = 0;
