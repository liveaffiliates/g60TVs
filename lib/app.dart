import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g60/theme/app_theme.dart';
import 'package:g60/routes.dart';
import 'package:g60/views/home/home_view.dart';


class App extends StatelessWidget {
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
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: HomeView(),
        routes: buildRoutes(context),
      ),
    );
  }

  Map<String, WidgetBuilder> buildRoutes(BuildContext context) {
    return {
      Routes.homeView: (BuildContext context) => HomeView(),
    };
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[


        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
