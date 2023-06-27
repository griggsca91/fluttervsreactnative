import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:listy_list/src/construction/construction_main_view.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

// /// The Widget that configures your application.
// class MyApp extends StatelessWidget {
//   const MyApp({
//     super.key,
//     required this.settingsController,
//   });

//   final SettingsController settingsController;

//   @override
//   Widget build(BuildContext context) {
//     // Glue the SettingsController to the MaterialApp.
//     //
//     // The AnimatedBuilder Widget listens to the SettingsController for changes.
//     // Whenever the user updates their settings, the MaterialApp is rebuilt.
//     return AnimatedBuilder(
//       animation: settingsController,
//       builder: (BuildContext context, Widget? child) {
//         return MaterialApp(
//           // Providing a restorationScopeId allows the Navigator built by the
//           // MaterialApp to restore the navigation stack when a user leaves and
//           // returns to the app after it has been killed while running in the
//           // background.
//           restorationScopeId: 'app',

//           // Provide the generated AppLocalizations to the MaterialApp. This
//           // allows descendant Widgets to display the correct translations
//           // depending on the user's locale.
//           localizationsDelegates: const [
//             AppLocalizations.delegate,
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//             GlobalCupertinoLocalizations.delegate,
//           ],
//           supportedLocales: const [
//             Locale('en', ''), // English, no country code
//           ],

//           // Use AppLocalizations to configure the correct application title
//           // depending on the user's locale.
//           //
//           // The appTitle is defined in .arb files found in the localization
//           // directory.
//           onGenerateTitle: (BuildContext context) =>
//               AppLocalizations.of(context)!.appTitle,

//           // Define a light and dark color theme. Then, read the user's
//           // preferred ThemeMode (light, dark, or system default) from the
//           // SettingsController to display the correct theme.
//           theme: ThemeData(),
//           darkTheme: ThemeData.dark(),
//           themeMode: settingsController.themeMode,

//           // Define a function to handle named routes in order to support
//           // Flutter web url navigation and deep linking.
//           onGenerateRoute: (RouteSettings routeSettings) {
//             return MaterialPageRoute<void>(
//               settings: routeSettings,
//               builder: (BuildContext context) {
//                 print("builder called ${routeSettings.name}");

//                 switch (routeSettings.name) {
//                   case ConstructionViewer.routeName:
//                     return const ConstructionViewer();
//                   case SettingsView.routeName:
//                     return SettingsView(controller: settingsController);
//                   case SampleItemDetailsView.routeName:
//                     return const SampleItemDetailsView();
//                   case SampleItemListView.routeName:
//                   default:
//                     return const SampleItemListView();
//                 }
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class Map extends StatelessWidget {
  Map({super.key});

  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: <Widget>[
      GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
      const Positioned(
        bottom: 50.0,
        left: 0,
        right: 0,
        height: 150.0,
        child: ConstructionList(),
      ),
    ]);
  }
}

class ConstructionList extends StatefulWidget {
  const ConstructionList({super.key});

  @override
  State<StatefulWidget> createState() => ConstructionListState();
}

class ConstructionListState extends State<ConstructionList> {
  int _focusedIndex = 0;

  final controller = FixedExtentScrollController();

  void _onItemFocus(int index) {
    setState(() => _focusedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
      onItemFocus: _onItemFocus,
      itemSize: 350 + 5 + 5,
      itemBuilder: (BuildContext context, int index) {
        return const ConstructionCard();
      },
      itemCount: 10,
      reverse: true,
    );
  }
}

class ConstructionCard extends StatelessWidget {
  const ConstructionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SizedBox(
          width: 350,
          height: 10,
          child: Card(
            color: const Color(0xffffffff),
            semanticContainer: false,
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                'https://www.fairfaxcounty.gov/publicworks/sites/publicworks/files/Assets/images/projects/Lorton%20CC-edit.png'),
                          ],
                        ))),
                const Expanded(
                    flex: 2,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Lorton Community Center"),
                            Text("9520 Richmond Highway, Lorton Virginia"),
                          ],
                        ))),
              ],
            ),
          ),
        ));
  }
}

class _MyAppState extends State<MyApp> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          elevation: 2,
        ),
        body: Map(),
      ),
    );
  }
}
