import 'package:flutter/material.dart';
import 'package:random_visuals/views/cointoss_view.dart';
import 'package:random_visuals/views/diceroll_view.dart';
import 'package:random_visuals/views/infinite_scroll.dart';

class TempPage extends StatelessWidget {
  const TempPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CointossView()));
                },
                child: Text('TossPage')),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DicerollView()));
                },
                child: Text('DicePage')),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => InfscrollPage()));
                },
                child: Text('Infinite Scrool')),
          ],
        ),
      ),
    );
  }
}
