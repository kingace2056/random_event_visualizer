import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class DicerollView extends StatefulWidget {
  const DicerollView({super.key});

  @override
  State<DicerollView> createState() => DicerollViewState();
}

class DicerollViewState extends State<DicerollView> {
  int noOfTosses = 100;
  List<int> cointosses = [];
  List<Color> shades = [
    Color(0xFF000000),
    Color.fromARGB(207, 0, 0, 0),
    Color.fromARGB(152, 0, 0, 0),
    Color.fromARGB(134, 0, 0, 0),
    Color.fromARGB(69, 0, 0, 0),
    Color.fromARGB(0, 0, 0, 0)
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
      Future.delayed(Duration(seconds: 1), () {
        cointosses.add(Random().nextInt(6));
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width >
                          MediaQuery.of(context).size.height
                      ? MediaQuery.of(context).size.height
                      : MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: GridView.builder(
                    itemCount: cointosses.isNotEmpty ? cointosses.length : 1,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: MediaQuery.of(context).size.width /
                            sqrt(cointosses.length).ceil() /
                            2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        childAspectRatio: 1.0),
                    itemBuilder: ((context, index) => cointosses.isNotEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.width / 8 / 2.5,
                            decoration: BoxDecoration(
                              color: shades[cointosses[index]],
                            ),
                          )
                        : Text('No emulation yet')),
                  ),
                ),
                Column(
                  children: [
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
                    Text('Number of rolls: $noOfTosses'),
                    ElevatedButton(
                      onPressed: () {
                        cointosses = [];
                        emulateCointoss();
                      },
                      child: Text('Emulate Dice ROlls'),
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
