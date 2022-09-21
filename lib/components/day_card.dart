import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DayCard extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  final Function() onTap;

  const DayCard({
    Key? key,
    required this.day,
    required this.date,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 55,
        height: 70,
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border:
              isSelected ? null : Border.all(color: Colors.black12, width: 1),
          color: Color(isSelected ? 0xFF3F8798 : 0xFFFFFFFF),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              day,
              style: TextStyle(
                color:
                    isSelected ? Colors.white : Colors.black.withOpacity(0.7),
                fontSize: 12.0,
              ),
            ),
            Text(
              date,
              style: GoogleFonts.poppins(
                color:
                    isSelected ? Colors.white : Colors.black.withOpacity(0.7),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
