import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class MyCustomCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback voidCallback;
  final Color color;
  final Color iconColor;

  const MyCustomCard({Key? key, required this.icon, required this.text, required this.voidCallback, required this.color, required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: Card(
          elevation: 2,
          color: color,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            padding: const EdgeInsets.only(left: 10, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Icon(icon, size: 30, color: iconColor),
                ),
                Flexible(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 2,
                  ),
                ),
                const Icon(EvaIcons.arrowheadRight, size: 16),
              ],
            ),
          ),
        ),
        onTap: voidCallback,
      ),
    );
  }
}