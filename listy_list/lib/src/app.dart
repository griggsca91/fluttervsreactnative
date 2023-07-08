import 'package:flutter/material.dart';
import './construction/map_view.dart';
import './construction/detail_view.dart';
import 'dart:developer' as developer;

import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final _router = GoRouter(navigatorKey: _rootNavigatorKey, routes: [
  ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
                onPressed: () => {
                      if (context.canPop()) {context.pop()}
                    }),
            title: const Text('Maps Sample App'),
            elevation: 2,
          ),
          body: child,
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const ConstructionMap(),
        ),
        GoRoute(
            path: "/location", builder: (context, state) => const DetailView()),
      ])
]);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green[700],
        ),
        routerConfig: _router);
  }
}
