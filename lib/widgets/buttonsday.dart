import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laserhouse_calendar/data/globaldatas.dart' as globals;
import 'package:laserhouse_calendar/styles/buttonstyle.dart';

class ButtonsDay extends StatefulWidget {
  const ButtonsDay({super.key, required this.day, required this.month, required this.year, required this.processingDay});
  final int day;
  final int month;
  final int year;
  final int processingDay;

  @override
  State<ButtonsDay> createState() => _ButtonsDayState();
}

class _ButtonsDayState extends State<ButtonsDay> {
  int daysInMonth(int year, int month) {
    DateTime firstDayOfNextMonth = DateTime(year, month + 1, 1);
    DateTime lastDayOfThisMonth = firstDayOfNextMonth.subtract(const Duration(days: 1));
    return lastDayOfThisMonth.day;
  }

  String findDayOfWeek(int year, int month, int day) {
    // Create a DateTime object for the specified date
    DateTime date = DateTime(year, month, day);

    // Format the date to return the full name of the day of the week
    return DateFormat.EEEE('fr').format(date);
  }

  void setVacances1() {
    setState(() {
      globals.backTitleColor = Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.day > daysInMonth(widget.year, widget.month)) {
      return const Text('');
    }

    return ElevatedButton(
        style: customButtonStyle(2023, 1, 1),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: globals.backTitleColor,
                title: Center(
                  child: Text(
                    DateFormat.yMMMMEEEEd('fr').format(DateTime(widget.year, widget.month, widget.day)),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),

                //PopupContent
                content: Container(
                  height: 200,
                  width: 300,
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
                                setVacances1();
                              },
                              child: const Text(
                                'Début',
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const ElevatedButton(
                              onPressed: null,
                              child: Text(
                                'Fin',
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const ElevatedButton(
                              onPressed: null,
                              child: Text(
                                'Supprimer',
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 40),
                        //Vacances 2
                        const Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              '2ème Vacances',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: null,
                              child: Text(
                                'Début',
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: null,
                              child: Text(
                                'Fin',
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: null,
                              child: Text(
                                'Supprimer',
                                style: TextStyle(color: Colors.black, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //Fin Popup

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              findDayOfWeek(widget.year, widget.month, widget.day),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 4),
            Text('${widget.day}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            Text(
              '=> ${globals.buttonScore[widget.processingDay].toString()}',
              style: const TextStyle(color: Colors.purple),
            ),
          ],
        ));
  }
}
