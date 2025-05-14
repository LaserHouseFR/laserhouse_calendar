import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:laserhouse_calendar/data/globaldatas.dart' as globals;
import 'package:laserhouse_calendar/styles/buttonstyle.dart';
import 'package:intl/intl.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const <Locale>[
        Locale('fr', 'FR'),
      ],
      title: 'Calendrier MonCentreLaser',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: globals.backTitleColor),
        useMaterial3: true,
      ),
      home: MyHomePage(title: globals.titre),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Functions

  //Find date depending of seances
  String findDateFromSeance(int dateSeance) {
    DateTime newDate = globals.startOfYear.add(Duration(days: dateSeance));
    String newDateInString = DateFormat.yMMMEd('fr').format(newDate);
    return newDateInString;
  }

  //Set FixSeances
  void setFixSeance(int seance, int nbSeance) {
    resetSeances();
    setNoExposure1();
    setNoExposure2();

    //check if exist already
    for (int i = 0; i < 750; i++) {
      if (globals.buttonStatus[i] == 'FixSeance$nbSeance') {
        setState(() {
          globals.buttonStatus[i] = 'null';
          globals.buttonScore[i] = 100;
        });
        if (nbSeance == 1) globals.fixSeance1 = 0;
        if (nbSeance == 2) globals.fixSeance2 = 0;
        if (nbSeance == 3) globals.fixSeance3 = 0;
        if (nbSeance == 4) globals.fixSeance4 = 0;
        if (nbSeance == 5) globals.fixSeance5 = 0;
        if (nbSeance == 6) globals.fixSeance6 = 0;
      }
    }

    globals.buttonStatus[seance] = 'FixSeance$nbSeance';
    setState(() {
      if (nbSeance == 1) {
        globals.fixSeance1 = seance;
        globals.seance1 = globals.fixSeance1;
        globals.dateSeance1 = findDateFromSeance(globals.seance1);
      }
      if (nbSeance == 2) {
        globals.fixSeance2 = seance;
        globals.seance2 = globals.fixSeance2;
        globals.dateSeance2 = findDateFromSeance(globals.seance2);
      }
      if (nbSeance == 3) {
        globals.fixSeance3 = seance;
        globals.seance3 = globals.fixSeance3;
        globals.dateSeance3 = findDateFromSeance(globals.seance3);
      }
      if (nbSeance == 4) {
        globals.fixSeance4 = seance;
        globals.seance4 = globals.fixSeance4;
        globals.dateSeance4 = findDateFromSeance(globals.seance4);
      }
      if (nbSeance == 5) {
        globals.fixSeance5 = seance;
        globals.seance5 = globals.fixSeance5;
        globals.dateSeance5 = findDateFromSeance(globals.seance5);
      }
      if (nbSeance == 6) {
        globals.fixSeance6 = seance;
        globals.seance6 = globals.fixSeance6;
        globals.dateSeance6 = findDateFromSeance(globals.seance6);
      }
    });
  }

  //Reset FixSeances
  void resetFixSeances() {
    resetSeances();
    setNoExposure1();
    setNoExposure2();

    setState(() {
      for (int i = 0; i < 750; i++) {
        if (globals.buttonStatus[i] == 'FixSeance1' ||
            globals.buttonStatus[i] == 'FixSeance2' ||
            globals.buttonStatus[i] == 'FixSeance3' ||
            globals.buttonStatus[i] == 'FixSeance4' ||
            globals.buttonStatus[i] == 'FixSeance5' ||
            globals.buttonStatus[i] == 'FixSeance6') {
          globals.buttonStatus[i] = 'null';
          globals.buttonScore[i] = 100;
        }
      }
      globals.fixSeance1 = 0;
      globals.fixSeance2 = 0;
      globals.fixSeance3 = 0;
      globals.fixSeance4 = 0;
      globals.fixSeance5 = 0;
      globals.fixSeance6 = 0;
    });
  }

  //Find popup date
  String popupDate(int year, int month, int day) {
    if (month > 12) {
      month -= 12;
      year++;
    }
    String popupDateInString = DateFormat.yMMMMEEEEd('fr_FR').format(DateTime(year, month, day));
    return popupDateInString;
  }

  //Espacement actuel entre séances
  Widget setSpaceBetweenSesssion(int seance1, int seance2, int intervalSeance) {
    double space = (seance2 - seance1) / 7;
    Color spaceColor = Colors.white;
    if (globals.isMaillot) {
      if (space > globals.espacementSeancesMaillot[intervalSeance - 1] + 1 || space < globals.espacementSeancesMaillot[intervalSeance - 1] - 1) {
        spaceColor = const Color.fromARGB(255, 126, 28, 28);
      }
    }
    if (globals.isJambes) {
      if (space > globals.espacementSeancesJambes[intervalSeance - 1] + 1 || space < globals.espacementSeancesJambes[intervalSeance - 1] - 1) {
        spaceColor = const Color.fromARGB(255, 126, 28, 28);
      }
    }
    return Text(
      ('${space.toStringAsFixed(1)} / ${globals.optimalSpace[intervalSeance - 1]}'),
      style: TextStyle(color: spaceColor, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  //Reset Seances
  void resetSeances() {
    setState(() {
      for (int i = 0; i < 750; i++) {
        if (globals.buttonStatus[i] == 'Seance1' ||
            globals.buttonStatus[i] == 'Seance2' ||
            globals.buttonStatus[i] == 'Seance3' ||
            globals.buttonStatus[i] == 'Seance4' ||
            globals.buttonStatus[i] == 'Seance5' ||
            globals.buttonStatus[i] == 'Seance6') {
          globals.buttonStatus[i] = 'null';
          globals.buttonScore[i] = 100;
        }
      }
      globals.seance1 = 0;
      globals.seance2 = 0;
      globals.seance3 = 0;
      globals.seance4 = 0;
      globals.seance5 = 0;
      globals.seance6 = 0;
    });
  }

  //Calculation
  void myCalculation() {
    resetSeances();
    setNoExposure1();
    setNoExposure2();

    globals.isCalculating = true;

    List<String> previousButtonStatus = List<String>.from(globals.buttonStatus);
    List<int> previousButtonScore = List<int>.from(globals.buttonScore);
    int maxSum = 0;
    int totalScore = 0;
    int score1 = 0;
    int score2 = 0;
    int score3 = 0;
    int score4 = 0;
    int score5 = 0;
    int currentSum = 0;
    int debutCalculation = 1;

    int space1 = globals.optimalSpace[0] * 7;
    int space2 = globals.optimalSpace[1] * 7;
    int space3 = globals.optimalSpace[2] * 7;
    int space4 = globals.optimalSpace[3] * 7;
    //int space5 = globals.optimalSpace[4] * 7;

    int seance1 = 0;
    int seance2 = 0;
    int seance3 = 0;
    int seance4 = 0;
    int seance5 = 0;
    int seance6 = 0;

    //start calculation after the current day
    for (int i = 0; i <= globals.currentDaySinceBeginOfYear; i++) {
      globals.buttonScore[i] = 0;
    }
    for (int i = 0; i < 750; i++) {
      if (globals.buttonScore[i] > 0) {
        debutCalculation = i;
        break;
      }
    }

    //find seances with seance1 with max 4 month
    int scoreToExit = 100;

    //set FixSeance1
    int debitI = debutCalculation;
    int finI = debutCalculation + 120;
    if (globals.fixSeance1 != 0) {
      debitI = globals.fixSeance1;
      finI = globals.fixSeance1;
    }
    for (int i = debitI; i <= finI; i++) {
      if (totalScore >= scoreToExit) {
        break;
      }
      if (globals.buttonScore[i] == 0) continue;

      score1 = globals.buttonScore[i];
      //if sooner substract nb day from current day
      if (globals.isSooner) {
        score1 -= ((i - debutCalculation) * 1.5).toInt();
      }

      //set FixSeance2
      int debitJ = i + space1 - 14;
      int finJ = i + space1 + 14;
      if (globals.fixSeance2 != 0) {
        debitJ = globals.fixSeance2;
        finJ = globals.fixSeance2;
      }
      for (int j = debitJ; j <= finJ; j++) {
        if (totalScore >= scoreToExit) {
          break;
        }
        if (globals.buttonScore[j] == 0) continue;
        score2 = globals.buttonScore[j];
        if (j - i > space1) {
          score2 -= (j - i) - space1;
        }
        if (j - i < space1) {
          score2 -= space1 - (j - i);
        }

        //set FixSeance3
        int debitK = j + space2 - 14;
        int finK = j + space2 + 14;
        if (globals.fixSeance3 != 0) {
          debitK = globals.fixSeance3;
          finK = globals.fixSeance3;
        }
        for (int k = debitK; k <= finK; k++) {
          if (totalScore >= scoreToExit) {
            break;
          }
          if (globals.buttonScore[k] == 0) continue;
          score3 = globals.buttonScore[k];
          if (k - j > space2) {
            score3 -= (k - j) - space2;
          }
          if (k - j < space2) {
            score3 -= space2 - (k - j);
          }

          //set FixSeance4
          int debitL = k + space3 - 14;
          int finL = k + space3 + 14;
          if (globals.fixSeance4 != 0) {
            debitL = globals.fixSeance4;
            finL = globals.fixSeance4;
          }
          for (int l = debitL; l <= finL; l++) {
            if (totalScore >= scoreToExit) {
              break;
            }
            if (globals.buttonScore[l] == 0) continue;
            score4 = globals.buttonScore[l];
            if (l - k > space3) {
              score4 -= (l - k) - space3;
            }
            if (l - k < space3) {
              score4 -= space3 - (l - k);
            }

            //set FixSeance5
            int debitM = l + space4 - 14;
            int finM = l + space4 + 14;
            if (globals.fixSeance5 != 0) {
              debitM = globals.fixSeance5;
              finM = globals.fixSeance5;
            }
            for (int m = debitM; m <= finM; m++) {
              if (totalScore >= scoreToExit) {
                break;
              }
              if (globals.buttonScore[m] == 0) continue;
              score5 = globals.buttonScore[m];
              if (m - l > space4) {
                score5 -= (m - l) - space4;
              }
              if (m - l < space4) {
                score5 -= space4 - (m - l);
              }

              currentSum = score1 + score2 + score3 + score4 + score5;

              if (currentSum > maxSum) {
                maxSum = currentSum;
                //reset Seances
                for (int i = 0; i < 750; i++) {
                  if (globals.buttonStatus[i] == 'Seance1' ||
                      globals.buttonStatus[i] == 'Seance2' ||
                      globals.buttonStatus[i] == 'Seance3' ||
                      globals.buttonStatus[i] == 'Seance4' ||
                      globals.buttonStatus[i] == 'Seance5' ||
                      globals.buttonStatus[i] == 'Seance6') {
                    globals.buttonStatus[i] = previousButtonStatus[i];
                    globals.buttonScore[i] = previousButtonScore[i];
                  }
                }
                if (globals.fixSeance1 != 0) {
                  globals.buttonStatus[i] = 'FixSeance1';
                } else {
                  globals.buttonStatus[i] = 'Seance1';
                }
                if (globals.fixSeance2 != 0) {
                  globals.buttonStatus[j] = 'FixSeance2';
                } else {
                  globals.buttonStatus[j] = 'Seance2';
                }
                if (globals.fixSeance3 != 0) {
                  globals.buttonStatus[k] = 'FixSeance3';
                } else {
                  globals.buttonStatus[k] = 'Seance3';
                }
                if (globals.fixSeance4 != 0) {
                  globals.buttonStatus[l] = 'FixSeance4';
                } else {
                  globals.buttonStatus[l] = 'Seance4';
                }
                if (globals.fixSeance5 != 0) {
                  globals.buttonStatus[m] = 'FixSeance5';
                } else {
                  globals.buttonStatus[m] = 'Seance5';
                }

                totalScore = maxSum ~/ 5;
                seance1 = i;
                seance2 = j;
                seance3 = k;
                seance4 = l;
                seance5 = m;

                //set FixSeance6
                if (globals.fixSeance6 != 0) {
                  globals.buttonStatus[globals.fixSeance6] = 'FixSeance6';
                  seance6 = globals.fixSeance6;
                } else {
                  globals.buttonStatus[m + globals.optimalSpace[4] * 7] = 'Seance6';
                  seance6 = m + globals.optimalSpace[4] * 7;
                }
              }
            }
          }
        }
      }
    }

    //End of calculation
    setState(() {
      globals.startStopButtonText = 'Start';
      globals.seance1 = seance1;
      globals.seance2 = seance2;
      globals.seance3 = seance3;
      globals.seance4 = seance4;
      globals.seance5 = seance5;
      globals.seance6 = seance6;

      globals.score = totalScore;

      globals.dateSeance1 = findDateFromSeance(globals.seance1);
      globals.dateSeance2 = findDateFromSeance(globals.seance2);
      globals.dateSeance3 = findDateFromSeance(globals.seance3);
      globals.dateSeance4 = findDateFromSeance(globals.seance4);
      globals.dateSeance5 = findDateFromSeance(globals.seance5);
      globals.dateSeance6 = findDateFromSeance(globals.seance6);
    });
  }

  //Gestion Vacances
  //Set NoExposure
  void setNoExposure1() {
    if (globals.dayBeginSun1 != 0 && globals.dayEndSun1 != 0) {
      //Reset NoExposure1
      for (int i = 0; i < 750; i++) {
        if (globals.buttonStatus[i] == 'NoExposure1') {
          setState(() {
            globals.buttonStatus[i] = 'null';
            globals.buttonScore[i] = 100;
          });
        }
      }

      int beginNoExposure = globals.dayEndSun1 + 1;
      int endNoExposure = globals.dayEndSun1 + 30;
      int noExposureDay = 0;
      for (int i = beginNoExposure; i <= endNoExposure; i++) {
        noExposureDay++;
        setState(() {
          if (globals.buttonStatus[i] != 'Sun2') {
            if (globals.buttonStatus[i] != 'NoExposure2') {
              globals.buttonStatus[i] = 'NoExposure1';
              globals.buttonScore[i] = noExposureDay * 3;
            }
            if (globals.buttonStatus[i] == 'NoExposure2' && globals.buttonScore[i] > noExposureDay * 3) {
              globals.buttonStatus[i] = 'NoExposure1';
              globals.buttonScore[i] = noExposureDay * 3;
            }
          }
        });

        setState(() {
          globals.buttonStatus[globals.dayBeginSun1 - 1] = 'NoExposure1';
          globals.buttonStatus[globals.dayBeginSun1 - 2] = 'NoExposure1';
          globals.buttonStatus[globals.dayBeginSun1 - 3] = 'NoExposure1';
          if (globals.buttonScore[globals.dayBeginSun1 - 1] > 0) globals.buttonScore[globals.dayBeginSun1 - 1] = 10;
          if (globals.buttonScore[globals.dayBeginSun1 - 2] > 0) globals.buttonScore[globals.dayBeginSun1 - 2] = 50;
          if (globals.buttonScore[globals.dayBeginSun1 - 3] > 0) globals.buttonScore[globals.dayBeginSun1 - 3] = 90;
        });
      }
    }
  }

  void setNoExposure2() {
    if (globals.dayBeginSun2 != 0 && globals.dayEndSun2 != 0) {
      //Reset NoExposure2
      for (int i = 0; i < 750; i++) {
        if (globals.buttonStatus[i] == 'NoExposure2') {
          setState(() {
            globals.buttonStatus[i] = 'null';
            globals.buttonScore[i] = 100;
          });
        }
      }

      int beginNoExposure = globals.dayEndSun2 + 1;
      int endNoExposure = globals.dayEndSun2 + 30;
      int noExposureDay = 0;
      for (int i = beginNoExposure; i <= endNoExposure; i++) {
        noExposureDay++;
        setState(() {
          if (globals.buttonStatus[i] != 'Sun1') {
            if (globals.buttonStatus[i] != 'NoExposure1') {
              globals.buttonStatus[i] = 'NoExposure2';
              globals.buttonScore[i] = noExposureDay * 3;
            }
            if (globals.buttonStatus[i] == 'NoExposure1' && globals.buttonScore[i] > noExposureDay * 3) {
              globals.buttonStatus[i] = 'NoExposure2';
              globals.buttonScore[i] = noExposureDay * 3;
            }
          }
        });

        setState(() {
          globals.buttonStatus[globals.dayBeginSun2 - 1] = 'NoExposure2';
          globals.buttonStatus[globals.dayBeginSun2 - 2] = 'NoExposure2';
          globals.buttonStatus[globals.dayBeginSun2 - 3] = 'NoExposure2';
          if (globals.buttonScore[globals.dayBeginSun2 - 1] > 0) globals.buttonScore[globals.dayBeginSun2 - 1] = 10;
          if (globals.buttonScore[globals.dayBeginSun2 - 2] > 0) globals.buttonScore[globals.dayBeginSun2 - 2] = 50;
          if (globals.buttonScore[globals.dayBeginSun2 - 3] > 0) globals.buttonScore[globals.dayBeginSun2 - 3] = 90;
        });
      }
    }
  }

  //Vacances1
  void setBeginVacances1(int processingDay) {
    //reset Seances
    resetSeances();

    if (processingDay > globals.dayEndSun1 && globals.dayBeginSun1 != 0) {
      //Nothing to do
      return;
    }
    if (processingDay > globals.dayBeginSun2 && globals.dayBeginSun2 != 0) {
      //Nothing to do
      return;
    }
    if (processingDay > globals.dayEndSun2 && globals.dayEndSun2 != 0) {
      //Nothing to do
      return;
    }

    if (processingDay > globals.dayBeginSun1 && globals.dayBeginSun1 != 0) {
      //reset sun1
      for (int i = globals.dayBeginSun1; i <= processingDay; i++) {
        setState(() {
          globals.buttonStatus[i] = 'null';
          globals.buttonScore[i] = 100;
        });
      }
    }
    globals.dayBeginSun1 = processingDay;
    if (globals.dayEndSun1 == 0) {
      setState(() {
        globals.buttonStatus[processingDay] = 'Sun1';
        globals.buttonScore[processingDay] = 0;
      });
    } else {
      for (int i = globals.dayBeginSun1; i <= globals.dayEndSun1; i++) {
        setState(() {
          globals.buttonStatus[i] = 'Sun1';
          globals.buttonScore[i] = 0;
        });
      }
    }
    //Reset Exposure2
    if (globals.dayBeginSun2 != 0 && globals.dayEndSun2 != 0) {
      setNoExposure2();
    }
    setNoExposure1();
  }

  void setEndVacances1(int processingDay) {
    //reset Seances
    resetSeances();

    if (processingDay < globals.dayBeginSun1 && globals.dayEndSun1 != 0) {
      //Nothing to do
      return;
    }
    if (processingDay < globals.dayEndSun1) {
      //reset sun1
      for (int i = processingDay; i <= globals.dayEndSun1; i++) {
        setState(() {
          globals.buttonStatus[i] = 'null';
          globals.buttonScore[i] = 100;
        });
      }
    }
    globals.dayEndSun1 = processingDay;
    if (globals.dayBeginSun1 == 0) {
      setState(() {
        globals.buttonStatus[processingDay] = 'Sun1';
        globals.buttonScore[processingDay] = 0;
      });
    } else {
      for (int i = globals.dayBeginSun1; i <= globals.dayEndSun1; i++) {
        setState(() {
          globals.buttonStatus[i] = 'Sun1';
          globals.buttonScore[i] = 0;
        });
      }
    }

    //Reset Exposure2
    if (globals.dayBeginSun2 != 0 && globals.dayEndSun2 != 0) {
      setNoExposure2();
    }
    setNoExposure1();
  }

  void setResetVacances1() {
    //reset Seances
    resetSeances();

    //Reset NoExposure1
    for (int i = 0; i < 750; i++) {
      if (globals.buttonStatus[i] == 'NoExposure1') {
        setState(() {
          globals.buttonStatus[i] = 'null';
          globals.buttonScore[i] = 100;
        });
      }
    }

    //Reset Exposure2
    if (globals.dayBeginSun2 != 0 && globals.dayEndSun2 != 0) {
      setNoExposure2();
    }

    if (globals.dayBeginSun1 != 0 && globals.dayEndSun1 != 0) {
      for (int i = globals.dayBeginSun1; i <= globals.dayEndSun1; i++) {
        setState(() {
          globals.buttonStatus[i] = 'null';
          globals.buttonScore[i] = 100;
        });
      }
      globals.dayBeginSun1 = 0;
      globals.dayEndSun1 = 0;
      return;
    }
    if (globals.dayBeginSun1 != 0 && globals.dayEndSun1 == 0) {
      setState(() {
        globals.buttonStatus[globals.dayBeginSun1] = 'null';
        globals.buttonScore[globals.dayBeginSun1] = 100;
        globals.dayBeginSun1 = 0;
      });
    }
    if (globals.dayBeginSun1 == 0 && globals.dayEndSun1 != 0) {
      setState(() {
        globals.buttonStatus[globals.dayEndSun1] = 'null';
        globals.buttonScore[globals.dayEndSun1] = 100;
        globals.dayEndSun1 = 0;
      });
    }
  }

  //Vacances2
  void setBeginVacances2(int processingDay) {
    //reset Seances
    resetSeances();

    if (processingDay > globals.dayEndSun2 && globals.dayBeginSun2 != 0) {
      //Nothing to do
      return;
    }
    if (processingDay < globals.dayBeginSun1 && globals.dayBeginSun1 != 0) {
      //Nothing to do
      return;
    }
    if (processingDay < globals.dayEndSun1 && globals.dayEndSun1 != 0) {
      //Nothing to do
      return;
    }

    if (processingDay > globals.dayBeginSun2 && globals.dayBeginSun2 != 0) {
      //reset sun2
      for (int i = globals.dayBeginSun2; i <= processingDay; i++) {
        setState(() {
          globals.buttonStatus[i] = 'null';
          globals.buttonScore[i] = 100;
        });
      }
    }
    globals.dayBeginSun2 = processingDay;
    if (globals.dayEndSun2 == 0) {
      setState(() {
        globals.buttonStatus[processingDay] = 'Sun2';
        globals.buttonScore[processingDay] = 0;
      });
    } else {
      for (int i = globals.dayBeginSun2; i <= globals.dayEndSun2; i++) {
        setState(() {
          globals.buttonStatus[i] = 'Sun2';
          globals.buttonScore[i] = 0;
        });
      }
    }

    //Reset Exposure1
    if (globals.dayBeginSun1 != 0 && globals.dayEndSun1 != 0) {
      setNoExposure1();
    }
    setNoExposure2();
  }

  void setEndVacances2(int processingDay) {
    //reset Seances
    resetSeances();

    if (processingDay < globals.dayBeginSun2 && globals.dayEndSun2 != 0) {
      //Nothing to do
      return;
    }
    if (processingDay < globals.dayEndSun2) {
      //reset sun1
      for (int i = processingDay; i <= globals.dayEndSun2; i++) {
        setState(() {
          globals.buttonStatus[i] = 'null';
          globals.buttonScore[i] = 100;
        });
      }
    }
    globals.dayEndSun2 = processingDay;
    if (globals.dayBeginSun2 == 0) {
      setState(() {
        globals.buttonStatus[processingDay] = 'Sun2';
        globals.buttonScore[processingDay] = 0;
      });
    } else {
      for (int i = globals.dayBeginSun2; i <= globals.dayEndSun2; i++) {
        setState(() {
          globals.buttonStatus[i] = 'Sun2';
          globals.buttonScore[i] = 0;
        });
      }
    }

    //Reset Exposure1
    if (globals.dayBeginSun1 != 0 && globals.dayEndSun1 != 0) {
      setNoExposure1();
    }
    setNoExposure2();
  }

  void setResetVacances2() {
    //reset Seances
    resetSeances();

    //Reset NoExposure
    for (int i = 0; i < 750; i++) {
      if (globals.buttonStatus[i] == 'NoExposure2') {
        setState(() {
          globals.buttonStatus[i] = 'null';
          globals.buttonScore[i] = 100;
        });
      }
    }

    //Reset Exposure1
    if (globals.dayBeginSun1 != 0 && globals.dayEndSun1 != 0) {
      setNoExposure1();
    }

    if (globals.dayBeginSun2 != 0 && globals.dayEndSun2 != 0) {
      for (int i = globals.dayBeginSun2; i <= globals.dayEndSun2; i++) {
        setState(() {
          globals.buttonStatus[i] = 'null';
          globals.buttonScore[i] = 100;
        });
      }
      globals.dayBeginSun2 = 0;
      globals.dayEndSun2 = 0;
      return;
    }
    if (globals.dayBeginSun2 != 0 && globals.dayEndSun2 == 0) {
      setState(() {
        globals.buttonStatus[globals.dayBeginSun2] = 'null';
        globals.buttonScore[globals.dayBeginSun2] = 100;
        globals.dayBeginSun2 = 0;
      });
    }
    if (globals.dayBeginSun2 == 0 && globals.dayEndSun2 != 0) {
      setState(() {
        globals.buttonStatus[globals.dayEndSun2] = 'null';
        globals.buttonScore[globals.dayEndSun2] = 100;
        globals.dayEndSun2 = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: globals.backTitleColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                /*const Image(
                  image: AssetImage('assets/images/Logo.png'),
                  width: 35,
                ),
                const SizedBox(
                  width: 20,
                ), */
                Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            Text(globals.currentDateInString, style: const TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          //First Row (Radio,Seances, Dates, score)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Radios
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25, // Fixe la hauteur du Row à 50 pixels
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.5,
                          child: Switch(
                            value: globals.isMaillot,
                            activeColor: const Color.fromARGB(255, 40, 49, 92),
                            onChanged: (bool value) {
                              setState(() {
                                globals.isMaillot = value;
                                if (value) {
                                  globals.isJambes = false;
                                  globals.optimalSpace = List<int>.from(globals.espacementSeancesMaillot);
                                }
                              });
                            },
                          ),
                        ),
                        const Text('Maillot / Aisselles', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.5,
                          child: Switch(
                            value: globals.isJambes,
                            activeColor: const Color.fromARGB(255, 40, 49, 92),
                            onChanged: (bool value) {
                              setState(() {
                                globals.isJambes = value;
                                if (value) {
                                  globals.isMaillot = false;
                                  globals.optimalSpace = List<int>.from(globals.espacementSeancesJambes);
                                }
                              });
                            },
                          ),
                        ),
                        const Text('Jambes / Autres', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 0.5,
                          child: Switch(
                            value: globals.isSooner,
                            activeColor: const Color.fromARGB(255, 40, 49, 92),
                            onChanged: (bool value) {
                              setState(() {
                                globals.isSooner = value;
                              });
                            },
                          ),
                        ),
                        const Text('Le plus tôt possible', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),

              //Séances
              Row(children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    foregroundDecoration: BoxDecoration(border: Border.all(color: Colors.white)),
                    color: globals.backTitleColor,
                    child: Column(
                      children: [
                        const Text(
                          'Séance 1 -> Séance 2',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        setSpaceBetweenSesssion(globals.seance1, globals.seance2, 1),
                      ],
                    )),
                const SizedBox(
                  width: 30,
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    foregroundDecoration: BoxDecoration(border: Border.all(color: Colors.white)),
                    color: globals.backTitleColor,
                    child: Column(
                      children: [
                        const Text(
                          'Séance 2 -> Séance 3',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        setSpaceBetweenSesssion(globals.seance2, globals.seance3, 2),
                      ],
                    )),
                const SizedBox(
                  width: 30,
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    foregroundDecoration: BoxDecoration(border: Border.all(color: Colors.white)),
                    color: globals.backTitleColor,
                    child: Column(
                      children: [
                        const Text(
                          'Séance 3 -> Séance 4',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        setSpaceBetweenSesssion(globals.seance3, globals.seance4, 3),
                      ],
                    )),
                const SizedBox(
                  width: 30,
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    foregroundDecoration: BoxDecoration(border: Border.all(color: Colors.white)),
                    color: globals.backTitleColor,
                    child: Column(
                      children: [
                        const Text(
                          'Séance 4 -> Séance 5',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        setSpaceBetweenSesssion(globals.seance4, globals.seance5, 4),
                      ],
                    )),
                const SizedBox(
                  width: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  foregroundDecoration: BoxDecoration(border: Border.all(color: Colors.white)),
                  color: globals.backTitleColor,
                  child: Column(
                    children: [
                      const Text(
                        'Séance 5 -> Séance 6',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      setSpaceBetweenSesssion(globals.seance5, globals.seance6, 5),
                    ],
                  ),
                )
              ]),

              //Start Bouton
              Row(children: [
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: globals.backTitleColor,
                      ),
                      onPressed: () {
                        if (globals.startStopButtonText == 'Start') {
                          setState(() {
                            globals.startStopButtonText = '........';
                          });
                          Future.delayed(const Duration(milliseconds: 100), () {
                            myCalculation();
                          });
                        }
                      },
                      child: Text(
                        globals.startStopButtonText,
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ]),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Défilement horizontal
            child: SizedBox(
              width: 1900,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (var month = DateTime.now().month; month <= DateTime.now().month + 12; month++)
                          Column(
                            children: [
                              Container(
                                color: globals.backTitleColor,
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 130,
                                    minHeight: 30,
                                  ),
                                  child: Center(
                                    child: Text(
                                      globals.monthNames[month - 1],
                                      style: const TextStyle(color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                              for (var day = 1; day <= 31; day++)
                                Container(
                                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                  width: 130,
                                  child: day > daysInMonth(DateTime.now().year, month)
                                      ? const Text('')
                                      : ElevatedButton(
                                          style: customButtonStyle(day, month, DateTime.now().year),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  backgroundColor: globals.backTitleColor,
                                                  title: Center(
                                                    child: Text(
                                                      popupDate(DateTime.now().year, month, day),
                                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                                    ),
                                                  ),

                                                  //PopupContent
                                                  content: Container(
                                                    height: 200,
                                                    width: 600,
                                                    color: globals.backTitleColor,
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          //Vacances 1
                                                          Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              const Text(
                                                                '1ère Vacances',
                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  setBeginVacances1(DateTime(DateTime.now().year, month, day).difference(globals.startOfYear).inDays + 1);
                                                                  Navigator.of(context).pop();
                                                                },
                                                                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
                                                                child: const Text(
                                                                  'Début',
                                                                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  setEndVacances1(DateTime(DateTime.now().year, month, day).difference(globals.startOfYear).inDays + 1);
                                                                  Navigator.of(context).pop();
                                                                },
                                                                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
                                                                child: const Text(
                                                                  'Fin',
                                                                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  setResetVacances1();
                                                                  Navigator.of(context).pop();
                                                                },
                                                                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.yellow)),
                                                                child: const Text(
                                                                  'Supprimer',
                                                                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(width: 40),
                                                          //Vacances 2
                                                          Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              const Text(
                                                                '2ème Vacances',
                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  setBeginVacances2(DateTime(DateTime.now().year, month, day).difference(globals.startOfYear).inDays + 1);
                                                                  Navigator.of(context).pop();
                                                                },
                                                                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 214, 196, 35))),
                                                                child: const Text(
                                                                  'Début',
                                                                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  setEndVacances2(DateTime(DateTime.now().year, month, day).difference(globals.startOfYear).inDays + 1);
                                                                  Navigator.of(context).pop();
                                                                },
                                                                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 214, 196, 35))),
                                                                child: const Text(
                                                                  'Fin',
                                                                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  setResetVacances2();
                                                                  Navigator.of(context).pop();
                                                                },
                                                                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 214, 196, 35))),
                                                                child: const Text(
                                                                  'Supprimer',
                                                                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(width: 80),
                                                          //Fixe Séances
                                                          Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              const Text(
                                                                'Séances fixes',
                                                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      ElevatedButton(
                                                                        onPressed: () {
                                                                          setFixSeance(DateTime(DateTime.now().year, month, day).difference(globals.startOfYear).inDays + 1, 1);
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        style: ElevatedButton.styleFrom(minimumSize: const Size(60, 25), backgroundColor: const Color.fromARGB(255, 35, 214, 166)),
                                                                        child: const Text(
                                                                          'Séance 1',
                                                                          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 15,
                                                                      ),
                                                                      ElevatedButton(
                                                                        onPressed: () {
                                                                          setFixSeance(DateTime(DateTime.now().year, month, day).difference(globals.startOfYear).inDays + 1, 2);
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        style: ElevatedButton.styleFrom(minimumSize: const Size(60, 25), backgroundColor: const Color.fromARGB(255, 35, 214, 166)),
                                                                        child: const Text(
                                                                          'Séance 2',
                                                                          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 15,
                                                                      ),
                                                                      ElevatedButton(
                                                                        onPressed: () {
                                                                          setFixSeance(DateTime(DateTime.now().year, month, day).difference(globals.startOfYear).inDays + 1, 3);
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        style: ElevatedButton.styleFrom(minimumSize: const Size(60, 25), backgroundColor: const Color.fromARGB(255, 35, 214, 166)),
                                                                        child: const Text(
                                                                          'Séance 3',
                                                                          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(width: 20),
                                                                  Column(
                                                                    children: [
                                                                      ElevatedButton(
                                                                        onPressed: () {
                                                                          setFixSeance(DateTime(DateTime.now().year, month, day).difference(globals.startOfYear).inDays + 1, 4);
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        style: ElevatedButton.styleFrom(minimumSize: const Size(60, 25), backgroundColor: const Color.fromARGB(255, 35, 214, 166)),
                                                                        child: const Text(
                                                                          'Séance 4',
                                                                          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 15,
                                                                      ),
                                                                      ElevatedButton(
                                                                        onPressed: () {
                                                                          setFixSeance(DateTime(DateTime.now().year, month, day).difference(globals.startOfYear).inDays + 1, 5);
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        style: ElevatedButton.styleFrom(minimumSize: const Size(60, 25), backgroundColor: const Color.fromARGB(255, 35, 214, 166)),
                                                                        child: const Text(
                                                                          'Séance 5',
                                                                          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height: 15,
                                                                      ),
                                                                      ElevatedButton(
                                                                        onPressed: () {
                                                                          setFixSeance(DateTime(DateTime.now().year, month, day).difference(globals.startOfYear).inDays + 1, 6);
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        style: ElevatedButton.styleFrom(minimumSize: const Size(60, 25), backgroundColor: const Color.fromARGB(255, 35, 214, 166)),
                                                                        child: const Text(
                                                                          'Séance 6',
                                                                          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  resetFixSeances();
                                                                  Navigator.of(context).pop();
                                                                },
                                                                style: ElevatedButton.styleFrom(minimumSize: const Size(60, 25), backgroundColor: const Color.fromARGB(255, 35, 214, 166)),
                                                                child: const Text(
                                                                  'Supprimer',
                                                                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  //Action after click fermer
                                                  actions: [
                                                    ButtonBar(
                                                      alignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                                          child: const Text(
                                                            'Fermer',
                                                            style: TextStyle(color: Colors.black),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          //Calendar text Button
                                          child: Row(
                                            children: [
                                              Flexible(
                                                flex: 5,
                                                child: Center(
                                                  child: Text(
                                                    findDayOfWeek(DateTime.now().year, month, day),
                                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                              Flexible(flex: 2, child: Center(child: Text('$day', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black)))),
                                              Flexible(
                                                flex: 2,
                                                child: Center(
                                                  child: customIcon(day, month, DateTime.now().year),
                                                  /*Text(
                                              globals.buttonScore[globals.processingDay].toString(),
                                              style: const TextStyle(color: Color.fromARGB(255, 103, 15, 119), fontWeight: FontWeight.bold, fontSize: 10),
                                            ),*/
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                            ],
                          ),
                      ],
                    ),
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
