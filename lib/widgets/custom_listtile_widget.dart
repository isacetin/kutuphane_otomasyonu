import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCustomListTile extends StatelessWidget {
  final String text1, text2;
  final IconData icon;

  const MyCustomListTile({Key? key, required this.text1, required this.text2, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        color: const Color(0xFFF2F3F7),
        child: ListTile(
          leading: Icon(icon),
          title: Row(
            children: [
              Text("$text1 : ",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
              Text(text2),
            ],
          ),
        ),
      ),
    );
  }
}
