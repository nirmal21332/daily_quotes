import 'package:daily_quoates/view/screens/home_screen.dart';
import 'package:daily_quoates/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

List<Widget> screens = [
  const HomeScreen(),
  ProfileScreen(),
];
int index = 0;

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 65.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade200,
              width: 1.w,
            ),
          ),
        ),
        child: Row(
          children: [
            _buildNavItem(0, Icons.format_quote_sharp, 'Quotes'),
            _buildNavItem(1, Icons.person, 'Profile'),
          ],
        ),
      ),
      body: screens[index],
    );
  }

  Widget _buildNavItem(int itemIndex, IconData icon, String label) {
    bool isSelected = index == itemIndex;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              index = itemIndex;
            });
          },
          splashColor: const Color(0xff4B39EF).withOpacity(0.1),
          highlightColor: const Color(0xff4B39EF).withOpacity(0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? const Color(0xff4B39EF) : Colors.grey,
              ),
              Text(
                isSelected ? label : '',
                style: GoogleFonts.epilogue(
                  color: isSelected ? const Color(0xff4B39EF) : Colors.grey,
                  fontSize: 12.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
