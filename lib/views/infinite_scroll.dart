import 'package:flutter/material.dart';

class InfscrollPage extends StatefulWidget {
  const InfscrollPage({Key? key}) : super(key: key);

  @override
  _InfscrollPageState createState() => _InfscrollPageState();
}

class _InfscrollPageState extends State<InfscrollPage> {
  late ScrollController _scrollController;
  List<int> numbers = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _generateNumbers();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double currentScrollOffset = _scrollController.offset;
    double fiftyPercentOfMaxExtent = maxScrollExtent * 0.5;

    if (currentScrollOffset >= fiftyPercentOfMaxExtent) {
      _generateNumbers();
    }

    if (currentScrollOffset >= maxScrollExtent) {
      _generateNumbers();
    }
  }

  void _generateNumbers() {
    setState(() {
      int start = numbers.isEmpty ? 0 : numbers.last + 1;
      for (int i = start; i < start + 70; i++) {
        numbers.add(i);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite Scroll'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: numbers.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.1)),
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text('Number: ${numbers[index]}'),
          );
        },
      ),
    );
  }
}
