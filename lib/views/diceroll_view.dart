import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DicerollView extends StatefulWidget {
  const DicerollView({super.key});

  @override
  State<DicerollView> createState() => DicerollViewState();
}

class DicerollViewState extends State<DicerollView> {
  int noOfTosses = 100;
  List<int> dice = [1, 2, 3, 4, 5, 6];
  List<int> cointosses = [];
  Map<int, int> freqMap = {};
  List<Color> shades = [
    const Color(0xFF000000),
    const Color.fromARGB(207, 0, 0, 0),
    const Color.fromARGB(152, 0, 0, 0),
    const Color.fromARGB(134, 0, 0, 0),
    const Color.fromARGB(69, 0, 0, 0),
    const Color.fromARGB(0, 0, 0, 0)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // generateShadesOfBlack();
    emulateCointoss();
  }

  emulateCointoss() {
    // simulate 64 coin tosses and store the result in the cointosses list
    for (var i = 0; i < noOfTosses; i++) {
      Future.delayed(const Duration(seconds: 1), () {
        cointosses.add(Random().nextInt(6));
        frequencyMap();
        setState(() {
          cointosses = cointosses;
        });
      });
    }
  }

  frequencyMap() {
    freqMap = {
      1: cointosses.where((element) => element == 0).length,
      2: cointosses.where((element) => element == 1).length,
      3: cointosses.where((element) => element == 2).length,
      4: cointosses.where((element) => element == 3).length,
      5: cointosses.where((element) => element == 4).length,
      6: cointosses.where((element) => element == 5).length,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.height,
                  // child: GridView.builder(
                  //   itemCount: cointosses.isNotEmpty ? cointosses.length : 1,
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  //       maxCrossAxisExtent: MediaQuery.of(context).size.width /
                  //           sqrt(cointosses.length).ceil() /
                  //           2,
                  //       crossAxisSpacing: 0,
                  //       mainAxisSpacing: 0,
                  //       childAspectRatio: 1.0),
                  //   itemBuilder: ((context, index) => cointosses.isNotEmpty
                  //       ? Container(
                  //           height: MediaQuery.of(context).size.width / 8 / 2.5,
                  //           decoration: BoxDecoration(
                  //             color: shades[cointosses[index]],
                  //           ),
                  //         )
                  //       : Text('No emulation yet')),
                  // ),
                  child: Wrap(
                      children: cointosses.isNotEmpty
                          ? cointosses
                              .map((e) => Container(
                                    height: MediaQuery.of(context).size.height /
                                        sqrt(noOfTosses),
                                    width: MediaQuery.of(context).size.height /
                                        sqrt(noOfTosses),
                                    decoration: BoxDecoration(
                                      color: shades[e],
                                    ),
                                  ))
                              .toList()
                          : [const Text('No emulation yet')]),
                ),
                Column(
                  children: [
                    // Text('Total Tosses: ${cointosses.length}'),
                    SizedBox(
                      height: 20,
                    ),
                    const Text('Dice ROll Distribution Graph'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: SfCartesianChart(
                        series: <CartesianSeries>[
                          ColumnSeries<int, int>(
                            dataSource: cointosses,
                            xValueMapper: (int index, _) => index,
                            yValueMapper: (int index, _) => freqMap[index + 1],
                          )
                        ],
                      ),
                    ),

                    Text('Dice Rolls: ${cointosses.length}'),
                    Text(
                        'Ones: ${cointosses.where((element) => element == 0).length}'),
                    Text(
                        'Twos: ${cointosses.where((element) => element == 1).length}'),
                    Text(
                        'Threes: ${cointosses.where((element) => element == 2).length}'),
                    Text(
                        'Fours: ${cointosses.where((element) => element == 3).length}'),
                    Text(
                        'Fives: ${cointosses.where((element) => element == 4).length}'),
                    Text(
                        'Sixes: ${cointosses.where((element) => element == 5).length}'),

                    // show a slider to set number of tosses and a button to emulate the tosses
                    Slider(
                      value: noOfTosses.toDouble(),
                      min: 1,
                      max: 10000,
                      onChanged: (value) {
                        setState(() {
                          noOfTosses = value.toInt();
                        });
                      },
                    ),
                    Text('Number of rolls: $noOfTosses'),
                    ElevatedButton(
                      onPressed: () {
                        cointosses = [];
                        emulateCointoss();
                      },
                      child: const Text('Emulate Dice ROlls'),
                    ),
                    Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const Text('Each color represents a dice roll'),
                            Column(
                              children: shades
                                  .map((e) => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 20,
                                            color: e == const Color(0x00000000)
                                                ? Colors.white
                                                : e,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          // map the index of color to dice roll ie from 1 to 6 based on the idnex
                                          Text((shades.indexOf(e) + 1)
                                              .toString())
                                        ],
                                      ))
                                  .toList(),
                            ),
                          ],
                        ))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
