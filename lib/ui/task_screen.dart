import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<TextEditingController> _controllers =
      List.generate(2, (index) => TextEditingController());
  List<String> _dataList = List.generate(2, (index) => '');

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addNewTextField() {
    setState(() {
      _controllers.add(TextEditingController());
      _dataList.add('');
    });
  }

  void _saveData() {
    for (int i = 0; i < _controllers.length; i++) {
      _dataList[i] = _controllers[i].text;
    }
    print(_dataList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextField ListView'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _controllers.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controllers[index],
                    decoration: InputDecoration(
                      labelText: 'Item ${index + 1}',
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _addNewTextField,
            child: Text('Add New Item'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _saveData,
                child: Text('Save Data'),
              ),
              ElevatedButton(
                onPressed: () => Get.to(OutputScreen(items: _dataList)),
                child: Text('Next Screen'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class OutputScreen extends StatefulWidget {
  List<String> items;
  OutputScreen({required this.items});

  @override
  State<OutputScreen> createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {
  List<List<String>> states = [];

  @override
  void initState() {
    print(widget.items);
    nameData(widget.items);
    super.initState();
  }

  void nameData(List<String> names) {
    for (var i = 0; i <names.length; i++) {
      String item = names.removeAt(names.length - 1);
      names.insert(0, item);
      states.add(List.from(names));
    }

    for (var state in states) {
      print(state);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(states);
    return ListView(
      children: List.generate(
        widget.items.length, // Number of horizontal lists
        (index) => Container(
          height: 120, // Height of each horizontal list
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.items.length,
            itemBuilder: (context, itemIndex) {
              return Container(
                width: 100, // Width of each item
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                color: Colors.primaries[itemIndex % Colors.primaries.length],
                child: Center(
                  child: Text(
                    states[index][itemIndex],
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

