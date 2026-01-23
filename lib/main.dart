import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadycons/domain/blocs/auth/auth_bloc.dart';
import 'package:quadycons/domain/blocs/projects/projects_bloc.dart';
import 'package:quadycons/route.dart';
import 'package:quadycons/ui/utils/app_theme.dart';
import './injection_container.dart' as ic;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ic.init();

  final authBloc = ic.sl<AuthBloc>();
  authBloc.add(InitLoginEvent());
  final projectsBloc = ic.sl<ProjectsBloc>();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) => authBloc
      ),
      BlocProvider<ProjectsBloc>(
        create: (context) => projectsBloc
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}