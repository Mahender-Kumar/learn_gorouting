import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_gorouting/app_scaffold.dart';
import 'package:learn_gorouting/cms/cms.dart';
import 'package:learn_gorouting/dashboard.dart';
import 'package:learn_gorouting/sms/sms.dart';
import 'package:learn_gorouting/sms/sms1.dart';
import 'package:learn_gorouting/sms/sms2.dart';
import 'package:learn_gorouting/sms/sms3.dart';
import 'package:learn_gorouting/sst/sst.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey2 = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter._();
  static final instance = AppRouter._();

  late final router = GoRouter(
    // refreshListenable: GoRouterRefreshStream(_auth.authStateChanges()),
    initialLocation: '/',
    // redirect: (BuildContext context, GoRouterState state) {
    //   final loggedIn = true;
    //   // // .currentUser != null;
    //   // final goingToReset = state.matchedLocation.startsWith('/reset-password');
    //   // final goingToForgot =
    //   //     state.matchedLocation.startsWith('/forgot-password');

    //   final goingToLogin = state.matchedLocation.startsWith('/login');
    //   // if (state.matchedLocation.startsWith(':uid/seafarer_application')) {
    //   //   return ':uid/seafarer_application';
    //   // }
    //   // if (state.matchedLocation.startsWith('/registration')) {
    //   //   return '/registration';
    //   // }
    //   // if (!loggedIn && !goingToLogin && !goingToReset && !goingToForgot) {
    //   //   return '/login?from=${state.matchedLocation}';
    //   // }
    //   if (loggedIn && goingToLogin) return '/';

    //   return null;
    // },
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return AppScaffold(
            // selectedIndex: index == -1 ? 0 s: index,
            currentPath: state.uri.path,
            body: child,
            mobileNavs: 3,
            // navList: navList,
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const Dashboard();
            },
          ),
          GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: '/sms',
              // builder: (BuildContext context, GoRouterState state) {
              //   return SMS1();
              // },
              redirect: (context, state) {
                // final goingToLogin = state.matchedLocation.startsWith('/sms1');
                if (state.matchedLocation.startsWith('/sms1')) {
                  return '/sms/sms1';
                }
                if (state.matchedLocation.startsWith('/sms2')) {
                  return '/sms/sms2';
                }
                if (state.matchedLocation.startsWith('/sms3')) {
                  return '/sms/sms3';
                }

                return '/sms/sms2';
              },
              routes: [
                ShellRoute(
                  navigatorKey: _shellNavigatorKey2,
                  builder: (BuildContext context, GoRouterState state,
                      Widget child) {
                    return SMS();
                  },
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _shellNavigatorKey2,
                      path: '/sms1',
                      builder: (BuildContext context, GoRouterState state) {
                        return const SMS1();
                      },
                    ),
                    GoRoute(
                      parentNavigatorKey: _shellNavigatorKey2,
                      path: '/sms3',
                      builder: (BuildContext context, GoRouterState state) {
                        return const SMS3();
                      },
                    ),
                    GoRoute(
                      parentNavigatorKey: _shellNavigatorKey2,
                      path: '/sms2',
                      builder: (BuildContext context, GoRouterState state) {
                        return const SMS2();
                      },
                    ),
                  ],
                ),
              ]),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/cms',
            builder: (BuildContext context, GoRouterState state) {
              return const CMS();
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/vps',
            builder: (BuildContext context, GoRouterState state) {
              return const SST();
            },
          ),
          // GoRoute(
          //   parentNavigatorKey: _shellNavigatorKey,
          //   path: '/assets_add',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return AssetsAdd();
          //   },
          // ),
          // GoRoute(
          //   parentNavigatorKey: _shellNavigatorKey,
          //   path: '/per-39-coe/darya',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return Per39ContractOfEmploymentDarya(
          //       doc: state.extra as Map<String, dynamic>,
          //     );
          //   },
          // ),
          // GoRoute(
          //   parentNavigatorKey: _shellNavigatorKey,
          //   path: '/cms/messaging/compose-mail',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return CreateMessage();
          //   },
          // ),
          // GoRoute(
          //   parentNavigatorKey: _shellNavigatorKey,
          //   path: '/cms/messaging',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return Messaging();
          //   },
          // ),
        ],
      ),
      // GoRoute(
      //   parentNavigatorKey: _rootNavigatorKey,
      //   path: '/login',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return LoginScreen();
      //   },
      //   routes: [
      //     GoRoute(
      //       parentNavigatorKey: _rootNavigatorKey,
      //       path: ':phone/:verificationId',
      //       builder: (BuildContext context, GoRouterState state) {
      //         return VerifyScreen(
      //           phone: state.pathParameters['phone'],
      //           verificationId: state.pathParameters['verificationId'],
      //         );
      //       },
      //     ),
      //   ],
      // ),
      // GoRoute(
      //   parentNavigatorKey: _rootNavigatorKey,
      //   path: '/registration',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return RegistrationScreen();
      //   },
      // ),
      // GoRoute(
      //   parentNavigatorKey: _rootNavigatorKey,
      //   name: 'Console',
      //   path: '/',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return Console();
      //   },
      // ),
      // GoRoute(
      //   parentNavigatorKey: _rootNavigatorKey,
      //   path: '/reset-password/:uid/:key',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return ResetPassword(
      //       uid: state.pathParameters['uid'],
      //       resetKey: state.pathParameters['key'],
      //     );
      //   },
      // ),
      // GoRoute(
      //   parentNavigatorKey: _rootNavigatorKey,
      //   path: '/forgot-password',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return ForgotPassword();
      //   },
      // ),
      // GoRoute(
      //   parentNavigatorKey: _rootNavigatorKey,
      //   path: '/seafarer-application/:uid',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return SeaFarer(
      //       uid: state.pathParameters['uid'] ?? '',
      //       enable: true,
      //     );
      //   },
      // ),
    ],
  );
}
