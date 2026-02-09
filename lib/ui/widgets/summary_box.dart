import 'package:flutter/material.dart';
import 'package:quadycons/core/app_colors.dart';
import 'package:quadycons/core/app_dimens.dart';

class SummaryBox extends StatelessWidget {
  final String label;
  final String value;

  const SummaryBox({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.containerBackground(context),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            )
          ),
          SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            style: TextStyle(
              color: Colors.black,
              fontSize: AppDimens.titleMediumStyle(context)?.fontSize,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis
            )
          )
        ]
      )
    );
  }
}
