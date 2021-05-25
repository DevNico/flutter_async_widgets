# flutter_async_widgets

[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)
[![pub package](https://img.shields.io/pub/v/flutter_async_widgets.svg)](https://pub.dartlang.org/packages/flutter_async_widgets)

Convenience widgets for working with asynchronicity

## AsyncBuilder
Simple example with a single Future
```dart
class ExampleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AsyncBuilder.single<String>(
      Future.delayed(const Duration(seconds: 3), () => 'String from the future'),
      onData: (context, data) => Center(child: Text(data)),
    );
  }
}
```
Complex example with three Futures. The widget will show the loading state until all three Futures complete.
```dart
class ExampleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AsyncBuilder.combine3<String, int, double>(
      Future.delayed(const Duration(seconds: 1), () => 'String from the future'),
      Future.delayed(const Duration(seconds: 6), () => 42),
      Future.delayed(const Duration(seconds: 3), () => 1337.0),
      onData: (context, a, b, c) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(a),
          Text(b.toString()),
          Text(c.toString()),
        ],
      ),
    );
  }
}
```
