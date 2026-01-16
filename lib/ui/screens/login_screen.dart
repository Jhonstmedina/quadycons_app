import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quadycons/domain/blocs/auth/auth_bloc.dart';
import 'package:quadycons/ui/widgets/auth_input.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController userName;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    userName = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    userName.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if(state is OnAuthenticated) {
                context.go('/permissions');
              } else if (state is OnLogin && state.errorMessage != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage!),
                    backgroundColor: Colors.red
                  )
                );
              }
            },
            builder: (context, state) {
              if (state is OnLogin) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24
                      )
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Inicio de sesión único habilitado',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16
                      )
                    ),
                    SizedBox(height: 16),
                    AuthInput(
                      label: 'Usuario',
                      controller: userName,
                      obscureText: false,
                      errorMessage: state.emailMessage
                    ),
                    SizedBox(height: 16),
                    AuthInput(
                      label: 'Contraseña',
                      controller: password,
                      obscureText: true,
                      errorMessage: state.passwordMessage
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: state.loading ? null : () {
                        BlocProvider.of<AuthBloc>(context).add(
                          LoginEvent(
                            userName.text,
                            password.text
                          )
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[700],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.login),
                          SizedBox(width: 8),
                          Text('Ingresar')
                        ]
                      )
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Proyecto asignado',
                          style: TextStyle(color: Colors.grey)
                        ),
                        Chip(
                          label: Text('Torre Norte'),
                          backgroundColor: Color(0xFFF5F3FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          )
                        )
                      ]
                    )
                  ]
                );
              } else {
                return Center(
                  child: CircularProgressIndicator()
                );
              }
            }
          )
        )
      )
    );
  }
}