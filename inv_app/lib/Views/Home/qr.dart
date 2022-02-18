import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inv_app/Views/Home/resource_details.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../Classes/resourceArguments.dart';

class QRScreen extends StatefulWidget {
  @override
  _QRScreenSate createState() => _QRScreenSate();
}

class _QRScreenSate extends State<QRScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Scan a code',
                style: TextStyle(
                    color: Colors.blue[500],
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      await controller.pauseCamera();
      if (scanData.code!.contains('invapp://app/resources?id=')) {
        int id = int.parse(scanData.code!.substring(26));
        Navigator.pushNamed(
          context,
          ResourceDetails.routeName,
          arguments: ResourceArguments(id),
        );
      }
      await controller.resumeCamera();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
