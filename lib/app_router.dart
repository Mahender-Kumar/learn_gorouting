// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_gorouting/app_scaffold.dart';
import 'package:learn_gorouting/cms/cms.dart';
import 'package:learn_gorouting/cms/cms1.dart';
import 'package:learn_gorouting/cms/cms2.dart';
import 'package:learn_gorouting/cms/cms3.dart';
import 'package:learn_gorouting/dashboard.dart';
import 'package:learn_gorouting/scaffold_with_tabbar.dart';
import 'package:learn_gorouting/sms/add_sms.dart';
import 'package:learn_gorouting/sms/sms.dart';
import 'package:learn_gorouting/sms/sms1.dart';
import 'package:learn_gorouting/sms/sms2.dart';
import 'package:learn_gorouting/sms/sms3.dart';
import 'package:learn_gorouting/sst/sst.dart';
import 'package:learn_gorouting/test2.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey2 = GlobalKey<NavigatorState>();
final _shellNavigatorKey3 = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter._();
  static final instance = AppRouter._();

  late final router = GoRouter(
    // refreshListenable: GoRouterRefreshStream(_auth.authStateChanges()),
    initialLocation: '/cms/a',
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
      StatefulShellRoute(
          navigatorContainerBuilder: (context, navigationShell, children) {
            return AppScaffold(
              navigationShell: navigationShell,
              key: _shellNavigatorKey3,
              // currentPath: state.uri.path,
              // body: child,
              // mobileNavs: 3,
              children: children,
            );
            ScaffoldWithNestedNavigation2(
              navigationShell: navigationShell,
              children: children,
            );
          },
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state, navigationShell) {
            // the UI shell
            return navigationShell;
            ScaffoldWithNestedNavigation(navigationShell: navigationShell);
          },
          branches: [
            // first branch (A)
            StatefulShellBranch(
              navigatorKey: _shellNavigatorKey,
              routes: [
                // top route inside branch
                GoRoute(
                  path: '/cms/a',
                  builder: (BuildContext context, GoRouterState state) {
                    return RootScreen(
                        label: 'A', detailsPath: '/cms/a/details');
                  },
                  // pageBuilder: (context, state) => const NoTransitionPage(
                  //   child: RootScreen(label: 'A', detailsPath: '/a/details'),
                  // ),
                  routes: [
                    // child route
                    GoRoute(
                      path: 'details',
                      builder: (context, state) =>
                          const DetailsScreen(label: 'A'),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _shellNavigatorKey2,
              routes: [
                StatefulShellRoute(
                  builder: (BuildContext context, GoRouterState state,
                      StatefulNavigationShell navigationShell) {
                    // Just like with the top level StatefulShellRoute, no
                    // customization is done in the builder function.
                    return navigationShell;
                  },
                  navigatorContainerBuilder: (BuildContext context,
                      StatefulNavigationShell navigationShell,
                      List<Widget> children) {
                    // Returning a customized container for the branch
                    // Navigators (i.e. the `List<Widget> children` argument).
                    //
                    // See TabbedRootScreen for more details on how the children
                    // are managed (in a TabBarView).
                    return
                        //  ScaffoldWithNestedNavigation(
                        //   navigationShell: navigationShell,

                        // )
                        TabbedRootScreen(
                      navigationShell: navigationShell,
                      // key: tabbedRootScreenKey,
                      children: children,
                    );
                    // NOTE: To use a PageView version of TabbedRootScreen,
                    // replace TabbedRootScreen above with PagedRootScreen.
                  },
                  // This bottom tab uses a nested shell, wrapping sub routes in a
                  // top TabBar.
                  branches: <StatefulShellBranch>[
                    StatefulShellBranch(
                        // navigatorKey: _tabB1NavigatorKey,
                        routes: <GoRoute>[
                          GoRoute(
                            path: '/cms/b1',
                            builder:
                                (BuildContext context, GoRouterState state) =>
                                    const SMS1(),
                            // routes: <RouteBase>[
                            //   GoRoute(
                            //     path: 'details',
                            //     builder: (BuildContext context,
                            //             GoRouterState state) =>
                            //         const DetailsScreen(
                            //       label: 'B1',
                            //       withScaffold: false,
                            //     ),
                            //   ),
                            // ],
                          ),
                        ]),
                    StatefulShellBranch(
                        // navigatorKey: _tabB1NavigatorKey,
                        routes: <GoRoute>[
                          GoRoute(
                            path: '/cms/b2',
                            builder:
                                (BuildContext context, GoRouterState state) =>
                                    const SMS1(),
                            // routes: <RouteBase>[
                            //   GoRoute(
                            //     path: 'details',
                            //     builder: (BuildContext context,
                            //             GoRouterState state) =>
                            //         const DetailsScreen(
                            //       label: 'B1',
                            //       withScaffold: false,
                            //     ),
                            //   ),
                            // ],
                          ),
                        ]),
                    StatefulShellBranch(
                        // navigatorKey: _tabB1NavigatorKey,
                        routes: <GoRoute>[
                          GoRoute(
                            path: '/cms/b3',
                            builder:
                                (BuildContext context, GoRouterState state) =>
                                    const SMS3(detailsPath: '/cms/b3/details'),
                            routes: <RouteBase>[
                              GoRoute(
                                path: 'details',
                                builder: (BuildContext context,
                                        GoRouterState state) =>
                                    const AddSMS(
                                        // label: 'B3',
                                        // withScaffold: false,
                                        ),
                              ),
                            ],
                          ),
                        ]),
                    // StatefulShellBranch(
                    //     // navigatorKey: _tabB2NavigatorKey,
                    //     // To enable preloading for all nested branches, set
                    //     // `preload` to `true` (`false` is default).
                    //     // preload: true,
                    //     routes: <GoRoute>[
                    //       GoRoute(
                    //         path: '/b2',
                    //         builder:
                    //             (BuildContext context, GoRouterState state) =>
                    //                 const TabScreen(
                    //                     label: 'B2',
                    //                     detailsPath: '/b2/details'),
                    //         routes: <RouteBase>[
                    //           GoRoute(
                    //             path: 'details',
                    //             builder: (BuildContext context,
                    //                     GoRouterState state) =>
                    //                 const DetailsScreen(
                    //               label: 'B2',
                    //               withScaffold: false,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],),
                  ],
                ),
                // Shopping Cart
                GoRoute(
                  path: '/b',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: RootScreen(label: 'B', detailsPath: '/b/details'),
                  ),
                  routes: [
                    GoRoute(
                      path: 'details',
                      builder: (context, state) =>
                          const DetailsScreen(label: 'B'),
                    ),
                  ],
                ),
              ],
            ),
          ]),

      // StatefulShellRoute(
      //     navigatorContainerBuilder: (context, navigationShell, children) {
      //       return AppScaffold(
      //         navigationShell: navigationShell,
      //         key: _shellNavigatorKey3,
      //         currentPath: state.uri.path,
      //         body: child,
      //         mobileNavs: 3,
      //         children: children,
      //       );
      //       ScaffoldWithNestedNavigation2(
      //         navigationShell: navigationShell,
      //         children: children,
      //       );
      //     },
      //     parentNavigatorKey: _rootNavigatorKey,
      //     builder: (context, state, navigationShell) {
      //       // the UI shell
      //       return navigationShell;
      //       ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      //     },
      //     branches: [
      //       // first branch (A)
      //       StatefulShellBranch(
      //         navigatorKey: _shellNavigatorKey,
      //         routes: [
      //           // top route inside branch
      //           GoRoute(
      //             path: '/cms/a',
      //             builder: (BuildContext context, GoRouterState state) {
      //               return RootScreen(
      //                   label: 'A', detailsPath: '/cms/a/details');
      //             },
      //             // pageBuilder: (context, state) => const NoTransitionPage(
      //             //   child: RootScreen(label: 'A', detailsPath: '/a/details'),
      //             // ),
      //             routes: [
      //               // child route
      //               GoRoute(
      //                 path: 'details',
      //                 builder: (context, state) =>
      //                     const DetailsScreen(label: 'A'),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //       StatefulShellBranch(
      //         navigatorKey: _shellNavigatorKey2,
      //         routes: [
      //           // Shopping Cart
      //           GoRoute(
      //             path: '/b',
      //             pageBuilder: (context, state) => const NoTransitionPage(
      //               child: RootScreen(label: 'B', detailsPath: '/b/details'),
      //             ),
      //             routes: [
      //               GoRoute(
      //                 path: 'details',
      //                 builder: (context, state) =>
      //                     const DetailsScreen(label: 'B'),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ]),

      // ShellRoute(
      //   navigatorKey: _shellNavigatorKey,
      //   builder: (BuildContext context, GoRouterState state, Widget child) {
      //     return AppScaffold(
      //       // selectedIndex: index == -1 ? 0 s: index,
      //       currentPath: state.uri.path,
      //       body: child,
      //       mobileNavs: 3,
      //       // navList: navList,
      //     );
      //   },
      //   routes: [
      //     GoRoute(
      //       parentNavigatorKey: _shellNavigatorKey,
      //       path: '/',
      //       builder: (BuildContext context, GoRouterState state) {
      //         return const Dashboard();
      //       },
      //     ),
      //     GoRoute(
      //         parentNavigatorKey: _shellNavigatorKey,
      //         path: '/sms',

      //         // builder: (BuildContext context, GoRouterState state) {
      //         //   return SMS();
      //         // },
      //         redirect: (context, state) {
      //           // print('toproute: ${state.topRoute}');
      //           // print('Matched Location: ${state.matchedLocation}');
      //           // print('Extra: ${state.extra}');
      //           // print('Error: ${state.error}');
      //           // print('Full Path: ${state.fullPath}');
      //           // print('Name: ${state.name}');
      //           // print('Page Key: ${state.pageKey}');
      //           // print('Path: ${state.path}');
      //           // print('Path Parameters: ${state.pathParameters}');

      //           // print('URI: ${state.uri}');

      //           // print(state.namedLocation('sms'));
      //           // final goingToLogin = state.matchedLocation.startsWith('/sms1');

      //           if (state.fullPath == '/sms/sms1') {
      //             // print('SMS1');
      //             return '/sms/sms1';
      //           } else if (state.fullPath == '/sms/sms2') {
      //             // print('SMS2');

      //             return '/sms/sms2';
      //           } else if (state.fullPath == '/sms/sms3') {
      //             // print('SMS3');
      //             return '/sms/sms3';
      //           } else if (state.uri.path == '/sms/sms1/add_sms') {
      //             // print('Add SMS');
      //             return '/sms/sms1/add_sms';
      //           } else {
      //             return '/sms/sms1';
      //             // return null;
      //           }
      //           // '/sms/sms2';
      //         },
      //         routes: [
      //           ShellRoute(
      //             navigatorKey: _shellNavigatorKey2,
      //             builder: (BuildContext context, GoRouterState state,
      //                 Widget child) {
      //               // print(' state.uri.path,');
      //               // print(
      //               //   state.uri.path,
      //               // );
      //               return SMS(
      //                 currentPath: state.uri.path,
      //               );
      //             },
      //             routes: [
      //               GoRoute(
      //                   parentNavigatorKey: _shellNavigatorKey2,
      //                   path: '/sms1',
      //                   builder: (BuildContext context, GoRouterState state) {
      //                     print('asd');
      //                     return const SMS1();
      //                   },
      //                   redirect: (context, state) {
      //                     print('toproute: ${state.topRoute}');
      //                     print('Matched Location: ${state.matchedLocation}');
      //                     print('Extra: ${state.extra}');
      //                     print('Error: ${state.error}');
      //                     print('Full Path: ${state.fullPath}');
      //                     print('Name: ${state.name}');
      //                     print('Page Key: ${state.pageKey}');
      //                     print('Path: ${state.path}');
      //                     print('Path Parameters: ${state.pathParameters}');

      //                     print('URI: ${state.uri}');
      //                     // final goingToLogin = state.matchedLocation.startsWith('/sms1');
      //                     if (state.uri.path == '/sms/sms1/add_sms') {
      //                       return '/sms/sms1/add_sms';
      //                     }
      //                     // return null;
      //                     // '/sms/sms2';
      //                   },
      //                   routes: [
      //                     GoRoute(
      //                       parentNavigatorKey: _shellNavigatorKey2,
      //                       path: '/add_sms',
      //                       builder:
      //                           (BuildContext context, GoRouterState state) {
      //                         print('Add SMS');
      //                         return const AddSMS();
      //                       },
      //                     ),
      //                   ]),
      //               GoRoute(
      //                 parentNavigatorKey: _shellNavigatorKey2,
      //                 path: '/sms3',
      //                 builder: (BuildContext context, GoRouterState state) {
      //                   return const SMS3();
      //                 },
      //               ),
      //               GoRoute(
      //                 parentNavigatorKey: _shellNavigatorKey2,
      //                 path: '/sms2',
      //                 builder: (BuildContext context, GoRouterState state) {
      //                   return const SMS2();
      //                 },
      //               ),
      //             ],
      //           ),
      //         ]),
      //     GoRoute(
      //         parentNavigatorKey: _shellNavigatorKey,
      //         path: '/cms',
      //         // builder: (BuildContext context, GoRouterState state) {
      //         //   return SMS1();
      //         // },
      //         redirect: (context, state) {
      //           // final goingToLogin = state.matchedLocation.startsWith('/sms1');
      //           // if (state.matchedLocation.startsWith('/cms1')) {
      //           //   return '/cms/cms1';
      //           // }
      //           // if (state.matchedLocation.startsWith('/cms2')) {
      //           //   return '/cms/cms2';
      //           // }
      //           // if (state.matchedLocation.startsWith('/cms3')) {
      //           //   return '/cms/cms3';
      //           // }

      //           if (state.fullPath == '/cms/cms1') {
      //             // print('SMS1');
      //             return '/cms/cms1';
      //           } else if (state.fullPath == '/cms/cms2') {
      //             // print('SMS2');

      //             return '/sms/sms2';
      //           } else if (state.fullPath == '/cms/cms3') {
      //             // print('SMS3');
      //             return '/cms/cms3';
      //           } else if (state.uri.path == '/sms/sms1/add_sms') {
      //             // print('Add SMS');
      //             return '/sms/sms1/add_sms';
      //           } else {
      //             return '/cms/cms1';
      //             // return null;
      //           }

      //           return null;
      //           // '/sms/sms2';
      //         },
      //         routes: [
      //           ShellRoute(
      //             navigatorKey: _shellNavigatorKey2,
      //             builder: (BuildContext context, GoRouterState state,
      //                 Widget child) {
      //               return CMS(
      //                 currentPath: state.uri.path,
      //               );
      //             },
      //             routes: [
      //               GoRoute(
      //                 parentNavigatorKey: _shellNavigatorKey2,
      //                 path: '/cms1',
      //                 builder: (BuildContext context, GoRouterState state) {
      //                   return const CMS1();
      //                 },
      //               ),
      //               GoRoute(
      //                 parentNavigatorKey: _shellNavigatorKey2,
      //                 path: '/cms3',
      //                 builder: (BuildContext context, GoRouterState state) {
      //                   return const CMS3();
      //                 },
      //               ),
      //               GoRoute(
      //                 parentNavigatorKey: _shellNavigatorKey2,
      //                 path: '/cms2',
      //                 builder: (BuildContext context, GoRouterState state) {
      //                   return const CMS2();
      //                 },
      //               ),
      //             ],
      //           ),
      //         ]),
      //     // GoRoute(
      //     //   parentNavigatorKey: _shellNavigatorKey,
      //     //   path: '/cms',
      //     //   builder: (BuildContext context, GoRouterState state) {
      //     //     return const CMS();
      //     //   },
      //     // ),
      //     GoRoute(
      //       parentNavigatorKey: _shellNavigatorKey,
      //       path: '/sst',
      //       builder: (BuildContext context, GoRouterState state) {
      //         return const SST();
      //       },
      //       routes: [
      //         GoRoute(
      //           parentNavigatorKey: _shellNavigatorKey,
      //           path: '/add_sms',
      //           name: 'add_sms',
      //           builder: (BuildContext context, GoRouterState state) {
      //             print('Add SMS');
      //             return const AddSMS();
      //           },
      //         ),
      //       ],
      //     ),
      //     // GoRoute(
      //     //   parentNavigatorKey: _shellNavigatorKey,
      //     //   path: '/assets_add',
      //     //   builder: (BuildContext context, GoRouterState state) {
      //     //     return AssetsAdd();
      //     //   },
      //     // ),
      //     // GoRoute(
      //     //   parentNavigatorKey: _shellNavigatorKey,
      //     //   path: '/per-39-coe/darya',
      //     //   builder: (BuildContext context, GoRouterState state) {
      //     //     return Per39ContractOfEmploymentDarya(
      //     //       doc: state.extra as Map<String, dynamic>,
      //     //     );
      //     //   },
      //     // ),
      //     // GoRoute(
      //     //   parentNavigatorKey: _shellNavigatorKey,
      //     //   path: '/cms/messaging/compose-mail',
      //     //   builder: (BuildContext context, GoRouterState state) {
      //     //     return CreateMessage();
      //     //   },
      //     // ),
      //     // GoRoute(
      //     //   parentNavigatorKey: _shellNavigatorKey,
      //     //   path: '/cms/messaging',
      //     //   builder: (BuildContext context, GoRouterState state) {
      //     //     return Messaging();
      //     //   },
      //     // ),
      //   ],
      // ),
    ],
  );
}
