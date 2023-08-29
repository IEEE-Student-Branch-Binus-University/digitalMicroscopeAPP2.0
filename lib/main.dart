import 'package:digimicapp/controls.dart';
import 'package:provider/provider.dart';
import 'model.dart';
import 'package:digimicapp/camera.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Example app for Camera Windows plugin.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ESPdataState(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Digital Microscope IEEE',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(),
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Microscope IEEE'),
      ),
      body: Row(
        children: [
          const Expanded(
            child: CameraWindow(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              color: Colors.white,
              height: double.infinity,
              child: const Center(
                child: newControlPanel(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
