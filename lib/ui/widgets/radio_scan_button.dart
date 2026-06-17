import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadycons/core/app_dimens.dart';
import 'package:quadycons/domain/blocs/projects/projects_bloc.dart';
import 'package:quadycons/domain/entities/register_type.dart';
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
    final blocState = context.read<CodeScanBloc>().state as Registrating;
    final isSelected = blocState.registerType == registerType;
    return ElevatedButton(
      onPressed: (){
        final chosenProject = (context.read<ProjectsBloc>().state as ProjectsLoaded).chosenProject;
        if(chosenProject != null) {
          context.read<CodeScanBloc>().add(
            SetRegisterType(registerType, chosenProject)
          );
        }
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
          Icon(
            icon,
            size: AppDimens.styleByScreen(context)?.fontSize
          ),
          SizedBox(width: 4),
          Text(
            text,
            style: AppDimens.styleByScreen(context)?.copyWith(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black
            )
          )
        ]
      )
    );
  }
}
