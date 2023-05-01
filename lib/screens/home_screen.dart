import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  int pomodoros = 0;
  late Timer timer;
  bool isPaused = true;

  void onTick(Timer timer) {
    setState(() {
      format(totalSeconds);
      if (!isPaused) {
        if (totalSeconds == 0) {
          setState(() {
            pomodoros += 1;
            isPaused = true;
            totalSeconds = twentyFiveMinutes;
          });
          timer.cancel();
        } else {
          totalSeconds--;
        }
      }
    });
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);

    setState(() {
      isPaused = false;
    });
  }

  void onPausePressed() {
    timer.cancel();

    setState(() {
      isPaused = true;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      isPaused = true;
      totalSeconds = twentyFiveMinutes;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: isPaused
                        ? const Icon(Icons.play_circle)
                        : const Icon(Icons.pause_circle_filled_rounded),
                    color: Theme.of(context).cardColor,
                    iconSize: 120,
                    onPressed: isPaused ? onStartPressed : onPausePressed,
                  ),
                  IconButton(
                    onPressed: onResetPressed,
                    icon: Transform.translate(
                      offset: const Offset(-3, 0),
                      child: Icon(
                        Icons.restore,
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                    iconSize: 60,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "pomodoros",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                        Text(
                          "$pomodoros",
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
