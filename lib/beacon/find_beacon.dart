//JBJOB David TODO
part of flutter_beacon;

//add for find specific beacon (by UUID)

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

  //other way
  void findDesiredBeacon(List<ScanResult> scanResults, String desiredUuid, int desiredMajor, int desiredMinor) {
  for (ScanResult scanResult in scanResults) {
    // Check if the scan result matches the desired beacon
    if (scanResult.advertisementData.serviceUuids.contains(desiredUuid) &&
        scanResult.advertisementData.manufacturerData.containsKey(desiredMajor) &&
        scanResult.advertisementData.manufacturerData[desiredMajor] == desiredMinor) {
      // Found the desired beacon
      print('Found the desired beacon!');
      print('Device ID: ${scanResult.device.id}');
      print('RSSI: ${scanResult.rssi}');
      // Perform further actions or store reference to the beacon as needed
      break;
    }
  }
}