import 'package:flutter/material.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/utils.dart';

class InterestsButton extends StatefulWidget {
  const InterestsButton({
    super.key,
    required this.interest,
  });

  final String interest;

  @override
  State<InterestsButton> createState() => _InterestsButtonState();
}

class _InterestsButtonState extends State<InterestsButton> {
  bool _isSelected = false;

  void _onTap() {
    _isSelected = !_isSelected;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(Sizes.size12),
        decoration: BoxDecoration(
            color: _isSelected
                ? Theme.of(context).primaryColor
                : isDarkMode(context)
                    ? Colors.grey.shade800
                    : Colors.white,
            border: Border.all(color: Colors.black.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(
              Sizes.size32,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                spreadRadius: 5,
              ),
            ],),
        child: Text(
          widget.interest,
          style: TextStyle(
              color: _isSelected
                  ? Colors.white
                  : isDarkMode(context)
                      ? Colors.grey.shade200
                      : Colors.black,
              fontWeight: FontWeight.w600,),
        ),
      ),
    );
  }
}
