import 'package:flutter/material.dart';

class ListviewBuilderEx extends StatelessWidget {
  static final entries = [
    'Fear',
    'Anger',
    'Disgust',
    'Sadness',
    'Happiness',
    'Joy',
    'Surprise',
    'Anxiety',
    'Love',
    'Pride',
    'Amusement',
    'Calmness',
    'Envy',
    'Excitement',
    'Gratitude',
    'Kindness',
    'Anticipation',
    'Interest',
  ];
  static final colorCodes = [
    600,
    500,
    100,
    200,
    300,
    400,
    700,
    800,
    900,
    600,
    500,
    100,
    200,
    300,
    400,
    700,
    800,
    900,
  ];

  static final iconList = [
    'assets/images/icon1.png',
    'assets/images/icon2.png',
    'assets/images/icon3.png',
    'assets/images/icon4.png',
    'assets/images/icon5.png',
    'assets/images/icon1.png',
    'assets/images/icon2.png',
    'assets/images/icon3.png',
    'assets/images/icon4.png',
    'assets/images/icon5.png',
    'assets/images/icon1.png',
    'assets/images/icon2.png',
    'assets/images/icon3.png',
    'assets/images/icon4.png',
    'assets/images/icon5.png',
    'assets/images/icon1.png',
    'assets/images/icon2.png',
    'assets/images/icon3.png',
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ListView Example',
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('onTap'),
              ));
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.black),
                color: Colors.amber[colorCodes[index]],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset('${iconList[index]}'),
                    ),
                  ),
                  Text(
                    '${entries[index]}',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Container()
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
