import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quadycons/domain/blocs/auth/auth_bloc.dart';

class MenuButton extends StatelessWidget {

  const MenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final userName = state is OnAuthenticated && state.user != null
            ? state.user!.name
            : 'Usuario';

        return PopupMenuButton<String>(
          icon: Icon(Icons.menu),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          onSelected: (String value) {
            switch (value) {
              case 'escanear':
                context.go('/id-code-scan');
                break;
              case 'sincronizar':
                context.go('/synchronize');
                break;
              case 'resumen':
                context.go('/summary');
                break;
              case 'cerrar_sesion':
                context.read<AuthBloc>().add(LogoutEvent());
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<String>(
              enabled: false,
              child: Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 20,
                    color: Colors.black54
                  ),
                  SizedBox(width: 12),
                  Text(
                    userName,
                    style: TextStyle(
                      color: Colors.black54
                    )
                  ),
                ]
              )
            ),
            PopupMenuDivider(),
            PopupMenuItem<String>(
              value: 'escanear',
              child: Row(
                children: [
                  Icon(Icons.qr_code_scanner, size: 20),
                  SizedBox(width: 12),
                  Text('Escanear'),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'sincronizar',
              child: Row(
                children: [
                  Icon(Icons.sync, size: 20),
                  SizedBox(width: 12),
                  Text('Sincronizar'),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'resumen',
              child: Row(
                children: [
                  Icon(Icons.today, size: 20),
                  SizedBox(width: 12),
                  Text('Resumen de hoy'),
                ],
              ),
            ),
            PopupMenuDivider(),
            PopupMenuItem<String>(
              value: 'cerrar_sesion',
              child: Row(
                children: [
                  Icon(Icons.logout, size: 20, color: Colors.red),
                  SizedBox(width: 12),
                  Text(
                    'Cerrar sesión',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
