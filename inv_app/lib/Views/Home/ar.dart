import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class ARwayKitUnityScreen extends StatefulWidget {
  ARwayKitUnityScreen({Key? key}) : super(key: key);

  @override
  _ARwayKitUnityScreenState createState() => _ARwayKitUnityScreenState();
}

class _ARwayKitUnityScreenState extends State<ARwayKitUnityScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  late UnityWidgetController _unityWidgetController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Card(
        margin: const EdgeInsets.all(0),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            UnityWidget(
              onUnityCreated: _onUnityCreated,
              isARScene: true,
              onUnityMessage: onUnityMessage,
              onUnitySceneLoaded: onUnitySceneLoaded,
            ),
          ],
        ),
      ),
    );
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  void onUnitySceneLoaded(SceneLoaded scene) {
    print('Received scene loaded from unity: ${scene.name}');
    print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
  }

  // Callback that connects the created controller to the unity controller
  void _onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }
}
