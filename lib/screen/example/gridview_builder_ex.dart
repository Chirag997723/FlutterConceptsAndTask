
import 'package:flutter/material.dart';
import 'package:flutter_practice_app/screen/example/listview_builder_ex.dart';

class GridviewBuilderEx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
      return Scaffold(
        appBar: AppBar(
        title: Text(
          'GridView Example',
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
        body: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          children: List.generate(ListviewBuilderEx.entries.length, (index) {
              return InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('onTap'),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.black),
                  color: Colors.amber[ListviewBuilderEx.colorCodes[index]],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset('${ListviewBuilderEx.iconList[index]}'),
                    ),
                    Text(
                      '${ListviewBuilderEx.entries[index]}',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Container()
                  ],
                ),
              ),
            ),
          );
            },),
        ),
      );
   
  }
  
}