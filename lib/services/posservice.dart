import 'dart:convert';
import 'dart:io';

import 'package:g60/comms/udp_test.dart';


class PosService {


  String ip = '224.0.2.200';
  int port = 7777; // default server port is 7777

  String data = 'Start';

  List<Datagram> cds = [];

  String strCdsConnected = "No CDS Connected";
  List<String> terminals = [];


   Future <String> posStart() async {


    UDPTest _udpTest = UDPTest();

    _udpTest.addReceiveEventListener(RESPONSE, (Datagram datagram) {
      // Checking is the new CDS well add to List
      if (cds.any((element) => element.port != datagram.port)) {
        cds.add(datagram);
      }

      // Convert list cds to String
      cds.forEach((element) {
        strCdsConnected += '${element.port},';
      });

      print('running');
       return data = ascii.decode(datagram.data);

      // // Add new message of the CDS to terminals
      // terminals.add(
      //     'Res-[${datagram.address.address}:${datagram.port}]:\n${ascii.decode(datagram.data)}');
    });

    // Add my message sending to terminals
    _udpTest.addSenderEventListener(SENDER, (String str) {
      terminals.add('Send-[$ip:$port]:\n$str');

    });

    await _udpTest.bindMulticastServer(ip, port);

    return 'waiting';


  }





}