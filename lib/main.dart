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
  DateTime today = DateTime.now();
  late Timer _timer;

  void startCountdown(DateTime end){
    today = DateTime.now();
    DateTime endDate = DateTime(end.day, end.month, end.year, 23, 59, 59);
    _counter = today.difference(endDate).inSeconds.toString();
     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        int countTemp = int.parse(_counter);
        countTemp--;
        countTemp = countTemp < 0 ? 0 : countTemp;
        _counter = countTemp.toString();
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

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

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
                startCountdown(pickedDate);
              }
            },
          ),
            const Text(
              'Hi',
            ),
            Text(
              '$_counter seconds remaining.',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
