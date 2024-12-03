import 'package:flutter/material.dart';
import 'package:laserhouse_calendar/data/globaldatas.dart' as globals;
import 'package:intl/intl.dart';

String findDateFromSeance(int dateSeance) {
  dateSeance = 124;
  DateTime newDate = globals.startOfYear.add(Duration(days: dateSeance - 1));
  String newDateInString = DateFormat.yMMMEd('fr').format(newDate);
  return newDateInString;
}

int daysInMonth(int year, int month) {
  if (month > 12) {
    month -= 12;
    year++;
  }
  // Vérifier si l'année est bissextile
  bool isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  List<int> daysPerMonth = [31, (isLeapYear ? 29 : 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  return daysPerMonth[month - 1];
}

String findDayOfWeek(int year, int month, int day) {
  if (month > 12) {
    month -= 12;
    year++;
  }
  DateTime date = DateTime(year, month, day);
  return DateFormat.EEEE('fr').format(date);
}

ButtonStyle customButtonStyle(int day, int month, int year) {
  if (month > 12) {
    month -= 12;
    year++;
  }
  globals.processingDay = DateTime(year, month, day).difference(globals.startOfYear).inDays + 1;
  //print(DateTime(2025, 02, 7).difference(globals.startOfYear).inDays + 1);

  //check closed day
  if (findDayOfWeek(year, month, day) == 'dimanche' || findDayOfWeek(year, month, day) == 'lundi') {
    if (globals.buttonStatus[globals.processingDay] == 'null') {
      globals.buttonStatus[globals.processingDay] = 'ClosedDay';
    }
    globals.buttonScore[globals.processingDay] = 0;
  }

  //Check Day before actual date
  if (globals.processingDay < globals.currentDaySinceBeginOfYear) {
    globals.buttonStatus[globals.processingDay] = 'BeforeActualDate';
    globals.buttonScore[globals.processingDay] = 0;
  }

  //check current day
  if (globals.processingDay == globals.currentDaySinceBeginOfYear) {
    globals.buttonStatus[globals.processingDay] = 'CurrentDay';
    globals.buttonScore[globals.processingDay] = 0;
  }

  //Style//
  //Style Day before current date
  if (globals.buttonStatus[globals.processingDay] == 'BeforeActualDate') {
    return ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 12),
        backgroundColor: const Color.fromARGB(255, 142, 138, 138),
        minimumSize: const Size(140, 30),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ));
  }

//Style Closed Days
  if (globals.buttonStatus[globals.processingDay] == 'ClosedDay') {
    return ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 12),
        backgroundColor: const Color.fromARGB(255, 202, 202, 202),
        minimumSize: const Size(140, 30),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ));
  }

  //Style Current Day
  else if (globals.buttonStatus[globals.processingDay] == 'CurrentDay') {
    return ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 12),
        backgroundColor: Colors.blueAccent,
        minimumSize: const Size(140, 30),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ));
  }

  //Style Sun1 Day
  else if (globals.buttonStatus[globals.processingDay] == 'Sun1') {
    return ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 12),
        backgroundColor: Colors.yellow,
        minimumSize: const Size(140, 30),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ));
  }

  //Style Sun2 Day
  else if (globals.buttonStatus[globals.processingDay] == 'Sun2') {
    return ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 12),
        backgroundColor: const Color.fromARGB(255, 214, 196, 35),
        minimumSize: const Size(140, 30),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ));
  }

  //Style FixSeances Day
  else if (globals.buttonStatus[globals.processingDay] == 'FixSeance1' ||
      globals.buttonStatus[globals.processingDay] == 'FixSeance2' ||
      globals.buttonStatus[globals.processingDay] == 'FixSeance3' ||
      globals.buttonStatus[globals.processingDay] == 'FixSeance4' ||
      globals.buttonStatus[globals.processingDay] == 'FixSeance5' ||
      globals.buttonStatus[globals.processingDay] == 'FixSeance6') {
    return ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 12),
        backgroundColor: const Color.fromARGB(255, 35, 214, 166),
        minimumSize: const Size(140, 30),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ));
  }

  //Exclure si Fixseances < seances
  else if ((globals.buttonStatus[globals.processingDay] == 'Seance2' && globals.seance2 > globals.fixSeance3 && globals.fixSeance3 != 0) ||
      (globals.buttonStatus[globals.processingDay] == 'Seance2' && globals.seance2 > globals.fixSeance4 && globals.fixSeance4 != 0) ||
      (globals.buttonStatus[globals.processingDay] == 'Seance2' && globals.seance2 > globals.fixSeance5 && globals.fixSeance5 != 0)) {
    return ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 12),
        minimumSize: const Size(140, 30),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ));
  } else if ((globals.buttonStatus[globals.processingDay] == 'Seance3' && globals.seance3 > globals.fixSeance4 && globals.fixSeance4 != 0) ||
      (globals.buttonStatus[globals.processingDay] == 'Seance3' && globals.seance3 > globals.fixSeance5 && globals.fixSeance5 != 0)) {
    return ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 12),
        minimumSize: const Size(140, 30),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ));
  } else if ((globals.buttonStatus[globals.processingDay] == 'Seance4' && globals.seance4 > globals.fixSeance5 && globals.fixSeance5 != 0)) {
    return ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 12),
        minimumSize: const Size(140, 30),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ));
  }

  //Style Seances Day
  else if (globals.buttonStatus[globals.processingDay] == 'Seance1' ||
      globals.buttonStatus[globals.processingDay] == 'Seance2' ||
      globals.buttonStatus[globals.processingDay] == 'Seance3' ||
      globals.buttonStatus[globals.processingDay] == 'Seance4' ||
      globals.buttonStatus[globals.processingDay] == 'Seance5' ||
      globals.buttonStatus[globals.processingDay] == 'Seance6') {
    return ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 12),
        backgroundColor: Colors.green,
        minimumSize: const Size(140, 30),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ));
  }

  //Style NoExposure Day
  else if (globals.buttonStatus[globals.processingDay] == 'NoExposure1') {
    return ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 12),
        backgroundColor: Color.fromARGB(230 - globals.buttonScore[globals.processingDay] * 2, 255, 44, 37),
        minimumSize: const Size(140, 30),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ));
  } else if (globals.buttonStatus[globals.processingDay] == 'NoExposure2') {
    return ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 12),
        backgroundColor: Color.fromARGB(230 - globals.buttonScore[globals.processingDay] * 2, 255, 44, 37),
        minimumSize: const Size(140, 30),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ));
  }

  //Style Default Day
  return ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 12),
      minimumSize: const Size(140, 30),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ));
}

Icon customIcon(int day, int month, int year) {
  if (month > 12) {
    month -= 12;
    year++;
  }
  globals.processingDay = DateTime(year, month, day).difference(globals.startOfYear).inDays + 1;
  if (globals.buttonStatus[globals.processingDay] == 'Sun1' || globals.buttonStatus[globals.processingDay] == 'Sun2') {
    return const Icon(
      Icons.sunny,
      size: 14,
    );
  }
  if (globals.buttonStatus[globals.processingDay] == 'NoExposure1' || globals.buttonStatus[globals.processingDay] == 'NoExposure2') {
    return const Icon(
      Icons.brightness_2,
      size: 14,
    );
  }
  if ((globals.buttonStatus[globals.processingDay] == 'Seance2' && globals.seance2 > globals.fixSeance3 && globals.fixSeance3 != 0) ||
      (globals.buttonStatus[globals.processingDay] == 'Seance2' && globals.seance2 > globals.fixSeance4 && globals.fixSeance4 != 0) ||
      (globals.buttonStatus[globals.processingDay] == 'Seance2' && globals.seance2 > globals.fixSeance5 && globals.fixSeance5 != 0)) {
    return const Icon(
      Icons.done_outline_rounded,
      size: 5,
    );
  }
  if ((globals.buttonStatus[globals.processingDay] == 'Seance3' && globals.seance3 > globals.fixSeance4 && globals.fixSeance4 != 0) ||
      (globals.buttonStatus[globals.processingDay] == 'Seance3' && globals.seance3 > globals.fixSeance5 && globals.fixSeance5 != 0)) {
    return const Icon(
      Icons.done_outline_rounded,
      size: 5,
    );
  }
  if ((globals.buttonStatus[globals.processingDay] == 'Seance4' && globals.seance4 > globals.fixSeance5 && globals.fixSeance5 != 0)) {
    return const Icon(
      Icons.done_outline_rounded,
      size: 5,
    );
  }
  if (globals.buttonStatus[globals.processingDay] == 'Seance1' || globals.buttonStatus[globals.processingDay] == 'FixSeance1') {
    return const Icon(
      Icons.looks_one_rounded,
      size: 20,
    );
  }
  if (globals.buttonStatus[globals.processingDay] == 'Seance2' || globals.buttonStatus[globals.processingDay] == 'FixSeance2') {
    return const Icon(
      Icons.looks_two_rounded,
      size: 20,
    );
  }
  if (globals.buttonStatus[globals.processingDay] == 'Seance3' || globals.buttonStatus[globals.processingDay] == 'FixSeance3') {
    return const Icon(
      Icons.looks_3_rounded,
      size: 20,
    );
  }
  if (globals.buttonStatus[globals.processingDay] == 'Seance4' || globals.buttonStatus[globals.processingDay] == 'FixSeance4') {
    return const Icon(
      Icons.looks_4_rounded,
      size: 20,
    );
  }
  if (globals.buttonStatus[globals.processingDay] == 'Seance5' || globals.buttonStatus[globals.processingDay] == 'FixSeance5') {
    return const Icon(
      Icons.looks_5_rounded,
      size: 20,
    );
  }
  if (globals.buttonStatus[globals.processingDay] == 'Seance6' || globals.buttonStatus[globals.processingDay] == 'FixSeance6') {
    return const Icon(
      Icons.looks_6_rounded,
      size: 20,
    );
  }
  if (globals.buttonStatus[globals.processingDay] == 'ClosedDay') {
    return const Icon(
      Icons.cancel_outlined,
      size: 14,
    );
  }
  if (globals.buttonStatus[globals.processingDay] == 'BeforeActualDate') {
    return const Icon(
      Icons.cancel_outlined,
      size: 14,
    );
  }
  return const Icon(
    Icons.done_outline_rounded,
    size: 5,
  );
}
