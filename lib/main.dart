import 'dart:math';
import 'dart:ui';

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

final cNums = Random();

class _CardPageState extends State<CardPage> {
  final numList = [];

  @override
  void initState() {
    for (int i = 0; i < 10; i++) {
      numList.add(i);
      //   numList.add(cNums.nextInt(50));
    }
    super.initState();
  }

  dynamic beforeIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Card', style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          FloatingActionButton(
              onPressed: (() => setState(() {
                    numList.add(cNums.nextInt(50));
                  })),
              child: const Icon(Icons.add)),
          Expanded(
            child: DragTarget(
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                    // shrinkWrap: true,         => children이 많아져 화면이상으로 넘어가면 오버플로우가 발생
                    itemCount: numList.length,
                    itemBuilder: (context, index) {
                      final deviceWidth =
                          MediaQuery.of(context).size.width; // 현재 디바이스 넓이
                      final Widget showCard = SizedBox(
                        width: deviceWidth,
                        child: Card(
                          child: ListTile(
                              title: Text(
                                numList[index].toString(),
                              ),
                              //trailing을 사용하지 않고 title을 GestureDetector로 감싸서
                              //Icon을 넣어줘도 됨!
                              trailing: GestureDetector(
                                child: const Icon(
                                  Icons.delete,
                                ),
                                onTap: () {
                                  setState(() {
                                    numList.removeAt(index);
                                  });
                                },
                              ),
                              onTap: () {
                                setState(() {
                                  numList[index]++;
                                });
                              }),
                        ),
                      );

                      return Draggable<int>(
                        feedback: showCard,
                        data: index, // key, context,findRenderObject 검색해보기
                        child: DragTarget<int>(
                          builder: (context, candidateData, rejectedData) {
                            return showCard;
                          },
                          onMove: (details) {
                            beforeIndex ??= index;
                            if (beforeIndex != index) {
                              int temp = numList[beforeIndex];
                              numList.removeAt(beforeIndex);
                              numList.insert(index, temp);
                              beforeIndex = index;
                            }
                            setState(() {});

                            //   int movingIndex = details.data;

                            //   if (beforeIndex == null) {
                            //     numList.insert(index, numList[movingIndex]);
                            //     numList.removeAt(index);
                            //     movingIndex = index;
                            //   }

                            //   if (beforeIndex != index) {
                            //     beforeIndex = movingIndex;
                            //     numList.removeAt(movingIndex);
                            //     numList.insert(index, numList[beforeIndex]);

                            //     beforeIndex = index;
                            //   }
                          },
                          onAccept: (data) {
                            beforeIndex = null;
                            setState(() {});
                          },
                        ),
                      );
                    });
              },
              onAccept: (data) {
                beforeIndex = null;

                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Feedback
// cNums나 numList 변수이름 변경
// onPressed() 와 onTap()에서 어떤 상태로 바뀌는지 바로 알수있게

// Card 위치변경
// ReorderableListView.builder(
//                 // shrinkWrap: true,         => children이 많아져 화면이상으로 넘어가면 오버플로우가 발생
//                 onReorder: (oldIndex, newIndex) {
//                   setState(() {
//                     if (newIndex > oldIndex) {
//                       // 드래그했는지 확인
//                       newIndex -= 1; // 최신 항목으로 설정
//                     }
//                     final temp = numList[oldIndex];
//                     numList.removeAt(oldIndex);
//                     numList.insert(newIndex, temp); // 배치해야하는 곳에 newIndex 삽입
//                   });

//return Card(
//                  key: Key('$index'),
