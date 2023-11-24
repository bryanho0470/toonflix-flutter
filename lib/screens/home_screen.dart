import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twerntyFiveMinutes = 1500;
  int totalSeconds = twerntyFiveMinutes;
  int completeCycles = 0;
  int totalPomodoros = 3;
  bool isRunning = false;
  String restNotice = "";
  late Timer timer;
  int breakTimeRemaining = 0;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(
        () {
          totalPomodoros = totalPomodoros + 1;
          isRunning = false;
          totalSeconds = twerntyFiveMinutes;
          if (totalPomodoros % 4 == 0) {
            completeCycles++;
            totalSeconds = 300;
            onStartPressed();
            restNotice = "Now is a restime";
          }
        },
      );
      timer.cancel();
      if (totalPomodoros % 4 != 0) {
        onStartPressed();
      }
    } else {
      setState(
        () {
          totalSeconds = totalSeconds - 1;
        },
      );
    }
  }

  void onStartPressed() {
    setState(() {
      isRunning = true;
    });
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
  }

  void onPressedPaused() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      totalPomodoros = 0;
      completeCycles = 0;
      totalSeconds = twerntyFiveMinutes;
    });
  }

  String formatMin(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 4);
  }

  String formatSecond(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(5, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "POMOTIMER",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Text(
              restNotice,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      formatMin(totalSeconds),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displayLarge!.color,
                        fontSize: 90,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      ":",
                      style: TextStyle(
                        color: Theme.of(context).cardColor.withOpacity(0.5),
                        fontSize: 100,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                    ),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      formatSecond(totalSeconds),
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displayLarge!.color,
                        fontSize: 90,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              child: TimeMenu(
                onTimeSelected: (seconds) {
                  setState(() {
                    totalSeconds = seconds;
                  });
                },
              ),
            )),
            Flexible(
              flex: 2,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      color: Theme.of(context).cardColor,
                      iconSize: 90,
                      onPressed: isRunning ? onPressedPaused : onStartPressed,
                      icon: Icon(
                        isRunning
                            ? Icons.pause_circle_filled_outlined
                            : Icons.play_circle_filled_outlined,
                      ),
                    ),
                    IconButton(
                        color: Theme.of(context).cardColor,
                        iconSize: 90,
                        onPressed: onResetPressed,
                        icon: const Icon(Icons.refresh))
                  ]),
            ),
            const SizedBox(
              height: 100,
            ),
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$totalPomodoros /4",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const Text(
                          "ROUND",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$completeCycles /12",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const Text(
                          "GOAL",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeMenu extends StatefulWidget {
  const TimeMenu({super.key, required this.onTimeSelected});
  final Function(int) onTimeSelected;

  @override
  State<TimeMenu> createState() => _TimeMenuState();
}

class _TimeMenuState extends State<TimeMenu> {
  final List<int> timeSelection = [1, 20, 25, 30, 35];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: timeSelection.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            widget.onTimeSelected(
                timeSelection[index] * 60); // Convert minutes to seconds
          },
          child: Container(
            width: 80.0,
            height: 5.0,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).cardColor,
                width: 5,
              ),
            ),
            child: Center(
              child: Text(
                "${timeSelection[index]}",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
