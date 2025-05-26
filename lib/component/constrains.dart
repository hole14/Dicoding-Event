import 'package:flutter/material.dart';

const primaryColor = Color(0xFF6189AE);
const secondColor = Color(0xFFDEEFFF);

const kTitleUpcoming = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold
);

const kDecorationText = InputDecoration(
  hintText: 'Event...',
  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
  prefixIcon: Icon(Icons.search),
  border: OutlineInputBorder(
    borderRadius:BorderRadius.all(
      Radius.circular(20.0),
    ),
    borderSide: BorderSide(
      color: primaryColor,
      width: 2.0,
    ),
  )
);