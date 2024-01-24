import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

const platform = MethodChannel(
  'com.example.flutter_native_communication/platform_channel',
);

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = '';

  Future<void> _initTSSDK() async {
    await platform.invokeMethod(
      'initTSSDk',
      {'clientId': 'tmjr0ag2f16hi80p4fuqlhgovnn4k3or'},
    );
  }

  Future<void> _camera() async {
    var status = await Permission.camera.status;
    print(status);
    if (status.isDenied) {
      await Permission.camera.request();
    }
  }

  Future<void> _startSession() async {
    await platform.invokeMethod(
      'startSession',
      {'startToken': '#Reemplazar Start Token#'},
    );
  }

  Future<void> _recapture() async {
    await platform.invokeMethod(
      'recapture',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _initTSSDK();
              },
              child: const Text('Init SDK'),
            ),
            ElevatedButton(
              onPressed: () {
                _camera();
              },
              child: const Text('Camara'),
            ),
            const Text('Obtener Access Token'),
            const Text('Crear Sesion'),
            ElevatedButton(
              onPressed: () {
                _startSession();
              },
              child: const Text('Iniciar'),
            ),
            ElevatedButton(
              onPressed: () {
                _recapture();
              },
              child: const Text('Recapture'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
