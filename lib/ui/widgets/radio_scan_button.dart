import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadycons/data/entities/register_type.dart';
import 'package:quadycons/domain/blocs/code_scan/code_scan_bloc.dart';

class ScanRegistrationButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final RegisterType registerType;

  const ScanRegistrationButton({
    super.key, 
    required this.icon,
    required this.text,
    required this.registerType
  });

  @override
  Widget build(BuildContext context) {
    final blocState = BlocProvider.of<CodeScanBloc>(context).state as Registrating;
    final isSelected = blocState.registerType == registerType;
    return ElevatedButton(
      onPressed: (){
        BlocProvider.of<CodeScanBloc>(context).add(
          SetRegisterType(registerType)
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        foregroundColor: isSelected ? Colors.white : Colors.black,
        backgroundColor: isSelected ? Colors.blue : null,
        minimumSize: Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        )
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          SizedBox(width: 4),
          Text(text)
        ]
      )
    );
  }
}
