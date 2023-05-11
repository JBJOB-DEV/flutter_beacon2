import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon_example/controller/requirement_state_controller.dart';
import 'package:flutter_beacon_example/view/home_page.dart';
import 'package:get/get.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(RequirementStateController());

    final themeData = Theme.of(context);
    final primary = Colors.blue;

    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: primary,
        appBarTheme: themeData.appBarTheme.copyWith(
          brightness: Brightness.light,
          elevation: 0.5,
          color: Colors.white,
          actionsIconTheme: themeData.primaryIconTheme.copyWith(
            color: primary,
          ),
          iconTheme: themeData.primaryIconTheme.copyWith(
            color: primary,
          ),
          textTheme: themeData.primaryTextTheme.copyWith(
            headline6: themeData.textTheme.headline6?.copyWith(
              color: primary,
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: primary,
      ),
      home: HomePage(),
    );
  }
}

//add for scan specific beacon (by UUID)
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //final String _uuid = 'YOUR_SPECIFIC_BEACON_UUID';
  final String _uuid = 'D0611E78-BBB4-4591-A5F8-487910AE4366';

  StreamSubscription<RangingResult> _rangingSubscription;

  @override
  void initState() {
    super.initState();

    // initialize flutter_beacon
    FlutterBeacon.initializeAndCheckScanning;

    // start ranging for beacons
    _rangingSubscription = FlutterBeacon.ranging(
      region: BeaconRegion(
        identifier: 'myRegion',
        proximityUUID: _uuid, // search for specific UUID only
      ),
    ).listen((result) {
      // handle ranging result here
    });
  }

  @override
  void dispose() {
    super.dispose();

    // stop ranging for beacons
    _rangingSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // build UI here
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Center(child: Text('Searching for beacon with UUID $_uuid...')),
    );
  }
}
