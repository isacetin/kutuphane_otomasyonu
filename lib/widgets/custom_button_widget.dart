import 'package:flutter/material.dart';

class MyCostumButton extends StatelessWidget {
  final VoidCallback voidCallback;
  final Color color1;
  final Color color2;
  final String text;
  final IconData iconData;

  const MyCostumButton({
    Key? key,
    required this.voidCallback,
    required this.color1,
    required this.color2,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.only(left: 15),
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: LinearGradient(
            colors: [color1, color2],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              iconData,
              color: Colors.white,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(),
          ],
        ),
      ),
      onTap: voidCallback,
    );
  }
}
