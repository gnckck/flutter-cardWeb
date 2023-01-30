import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const CardWeb());
}

class CardWeb extends StatelessWidget {
  const CardWeb({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '과제 1',
      home: CardPage(),
    );
  }
}

class CardPage extends StatefulWidget {
  const CardPage({super.key});


  @override
  State<CardPage> createState() => _CardPageState();
}


class _CardPageState extends State<CardPage> {


  final numList = [];
  final cNums = Random();

  @override
  void initState() {
      for (int i = 0; i < 10; i++){
        numList.add(cNums.nextInt(50));
     }
    super.initState();
   }
  

  @override
  Widget build(BuildContext context ) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Random Card',
          style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: numList.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              title: Text(
                numList[index].toString(),
              ),

              onTap: () {
               setState(() {
                 numList[index]++;
               });
              }
            ),
          );
        }
        ),
    );
  }
}



