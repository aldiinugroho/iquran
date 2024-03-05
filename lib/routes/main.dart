import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iquran/screen/detail/main.dart';
import 'package:iquran/screen/main/main.dart';
import 'package:iquran/screen/tafsir/main.dart';

final GoRouter mainRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreen();
      },
    ),
    GoRoute(
      path: '/detail',
      builder: (BuildContext context, GoRouterState state) {
        final dynamic data = state.extra!;
        String detailId = data['detailId'] ?? '';
        return DetailScreen(
          detailId: detailId,
        );
      },
    ),
    GoRoute(
      path: '/tafsir',
      builder: (BuildContext context, GoRouterState state) {
        final dynamic data = state.extra!;
        String tafsirId = data['tafsirId'] ?? '';
        String ayatId = data['ayatId'] ?? '';
        return TafsirScreen(
          ayatId: ayatId,
          tafsirId: tafsirId,
        );
      },
    ),
  ],
);
