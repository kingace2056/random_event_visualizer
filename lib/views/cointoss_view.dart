import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CointossView extends StatefulWidget {
  const CointossView({super.key});

  @override
  State<CointossView> createState() => CointossViewState();
}

class CointossViewState extends State<CointossView> {
  int noOfTosses = 100;
  List<int> cointosses = [];
  Map<int, int> freqMap = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emulateCointoss();
  }

  frequencyMap() {
    freqMap = {
      1: cointosses.where((element) => element == 0).length,
      2: cointosses.where((element) => element == 1).length,
    };
  }

  emulateCointoss() {
    // simulate 64 coin tosses and store the result in the cointosses list
    for (var i = 0; i < noOfTosses; i++) {
      Future.delayed(Duration(seconds: 1), () {
        cointosses.add(Random().nextInt(2));
        frequencyMap();
        setState(() {
          cointosses = cointosses;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                  //             color: cointosses[index] == 0
                  //                 ? Colors.red
                  //                 : Colors.white,
                  //           ),
                  //         )
                  //       : Text('No emulation yet')),
                  // ),
                  child: Wrap(
                      children: cointosses.isNotEmpty
                          ? cointosses
                              .map((e) => Container(
                                    height: MediaQuery.of(context).size.height /
                                        sqrt(cointosses.length),
                                    width: MediaQuery.of(context).size.height /
                                        sqrt(cointosses.length),
                                    decoration: BoxDecoration(
                                      color: e == 0 ? Colors.red : Colors.white,
                                    ),
                                  ))
                              .toList()
                          : [Text('No emulation yet')]),
                ),
                Column(
                  children: [
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
                    Text('Total Tosses: ${cointosses.length}'),
                    Text(
                        'Heads: ${cointosses.where((element) => element == 0).length}'),
                    Text(
                        'Tails: ${cointosses.where((element) => element == 1).length}'),

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
                    Text('Number of Tosses: $noOfTosses'),
                    ElevatedButton(
                      onPressed: () {
                        cointosses = [];
                        emulateCointoss();
                      },
                      child: Text('Emulate Cointoss'),
                    ),
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
