import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomLabel extends StatelessWidget {
  const BottomLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24.0,
      right: 18.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'Campus',
            style: GoogleFonts.museoModerno(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: const Color(0xFF3F8798)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              'Life',
              style: GoogleFonts.museoModerno(
                fontSize: 16.0,
                color: const Color(0xFF68E1FD),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
