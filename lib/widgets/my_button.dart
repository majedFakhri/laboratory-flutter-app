import 'package:flutter/Material.dart';
import 'package:university_project/core/utils/media_query_values.dart';

import '../core/utils/app_constants.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
                color: AppColors.primaryColor, width: 2, strokeAlign: 5),
          ),
          backgroundColor: Colors.white,
          elevation: 0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontFamily: AppStrings.appFont,
              fontSize: context.height <= 600 ? 10 : 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
