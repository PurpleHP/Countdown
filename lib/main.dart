import 'package:flutter/material.dart';
import 'dart:async';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mert',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 75, 6, 159)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Countdown Timer'),
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
  String _counter = "0";
  late Timer _timer;
  DateTime endDate = DateTime.now();
  void startCountdown(DateTime end){
    DateTime today = DateTime.now();
    int counterTemp = end.difference(today).inSeconds;
    if (counterTemp < 0) _counter = "0"; // Ensure counter is not negative

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        int counterTempCopy = counterTemp;
        int days = counterTempCopy ~/ 86400;
        counterTempCopy -= days * 86400;
        int hours = counterTempCopy~/ 3600;
        counterTempCopy -= hours * 3600;
        int minutes = counterTempCopy~/ 60;
        counterTempCopy -= minutes * 60;  
        counterTemp--;
        _counter = "$days days, $hours hours, $minutes minutes, $counterTempCopy seconds remaining.";
        if (counterTemp < 0) {
          counterTemp = 0;
          _counter = counterTemp.toString();
  
          timer.cancel(); // Stop the timer when reaching 0
        }
      });
    });
  }



  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.primary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
            child: const Text('Select Date to Countdown'),
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(0),
                lastDate: DateTime(3000),
              );

              if (pickedDate != null) {
                endDate = pickedDate;
                startCountdown(pickedDate);
              }
            },
          ),
            const Text(
              'HALLO :3',
            ),
            ElevatedButton(
              onPressed: () {
                _timer.cancel();
              },
              child: const Text('Stop Countdown'),
            ),
            ElevatedButton(
              onPressed: () {
                startCountdown(endDate);
              },
              child: const Text('Start Countdown'),
            ),
            Text(
              _counter,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
