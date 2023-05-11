//JBJOB David TODO
part of flutter_beacon;

//add for find specific beacon (by UUID)
//usage : double distance = calculateDistance(beaconRssi, beaconTxPower);
double calculateDistance(int rssi, int txPower) {
  if (rssi == 0) {
    return -1.0; // If the RSSI value is not available, return -1.
  }

  double ratio = rssi * 1.0 / txPower;
  if (ratio < 1.0) {
    return pow(ratio, 10);
  } else {
    double distance = (0.89976) * pow(ratio, 7.7095) + 0.111;
    return distance;
  }
}