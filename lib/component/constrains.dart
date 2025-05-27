import 'package:flutter/material.dart';

const primaryColor = Color(0xFF6189AE);
const secondColor = Color(0xFFDEEFFF);

const kTitleUpcoming = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold
);

class kDetailEvent extends StatelessWidget {
  final String title;
  final TextAlign textAlign;
  kDetailEvent({required this.title, required this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 12),
      textAlign: textAlign,
    );
  }
}


class DecorationSearch  extends StatelessWidget{
  final VoidCallback onPressed;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;

  DecorationSearch({required this.onPressed, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Event...',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: Icon(Icons.search),
        suffixIcon: IconButton(onPressed: onPressed, icon: const Icon(Icons.clear)),
        border: OutlineInputBorder(
          borderRadius:BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: primaryColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}