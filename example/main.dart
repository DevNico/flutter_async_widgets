import 'package:flutter/material.dart';
import 'package:flutter_async_widgets/flutter_async_widgets.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_async_builder example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ExampleWidget(),
    );
  }
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder.single<String>(
      Future.delayed(const Duration(seconds: 5), () => 'String from the future'),
      builder: (context, child, data) => Scaffold(
        appBar: AppBar(
          title: const Text('AsyncBuilder'),
          actions: [
            // If data is null the future is still loading
            if (data == null)
              Padding(
                padding: const EdgeInsets.all(16),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Theme(data: ThemeData(accentColor: Colors.white), child: const CircularProgressIndicator()),
                ),
              ),
          ],
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          child: child,
        ),
      ),
      onData: (context, data) => Center(child: Text(data, textAlign: TextAlign.center)),
    );
  }
}
