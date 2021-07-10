import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g60/screens/createworkoutsscreen/createworkoutscreen.dart';
import 'package:g60/screens/homescreen/homescreen.dart';
import 'package:g60/screens/savedworkoutsscreen/savedworkoutsscreen.dart';
import 'package:g60/screens/setupstudioscreen/setupstudioscreen.dart';
import 'package:g60/theme/app_theme.dart';
import 'package:g60/routes.dart';
import 'package:g60/views/home/home_view.dart';
import 'package:stacked_services/stacked_services.dart';

import 'screens/startworkoutscreen/startworkoutscreen.dart';


class G60App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// TODO - Allow other orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): ActivateIntent(),
      },
      child: MaterialApp(
        title: 'G60',
        navigatorKey: StackedService.navigatorKey,
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: buildRoutes(context),
      ),
    );
  }

  Map<String, WidgetBuilder> buildRoutes(BuildContext context) {
    return {
      Routes.homeScreen: (BuildContext context) => HomeView(),
      Routes.startWorkoutScreen: (BuildContext context) => StartWorkoutScreen(),
      Routes.savedWorkoutsScreen: (BuildContext context) => SavedWorkoutsScreen(),
      Routes.createWorkoutScreen: (BuildContext context) => CreateWorkoutScreen(),
      Routes.setupStudioScreen: (BuildContext context) => SetupStudioScreen(),
    };
  }
}

