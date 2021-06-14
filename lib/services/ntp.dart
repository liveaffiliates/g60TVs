import 'package:ntp/ntp.dart';

Future<DateTime> checkTime() async {
  DateTime _myTime;
  DateTime _ntpTime;

  /// Or you could get NTP current (It will call DateTime.now() and add NTP offset to it)
  _myTime = DateTime.now();

  /// Or get NTP offset (in milliseconds) and add it yourself
  final int offset =
  await NTP.getNtpOffset(localTime: _myTime, lookUpAddress: 'pool.ntp.org');

  _ntpTime = _myTime.add(Duration(milliseconds: offset));

  return _ntpTime;
}
