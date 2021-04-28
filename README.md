# flutter_async_widgets

[![style: lint](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lint)

Convenience widgets for working with asynchronicity

## AsyncBuilder
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