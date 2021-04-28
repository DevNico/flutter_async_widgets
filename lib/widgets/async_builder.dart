library flutter_async_builder;

import 'package:flutter/material.dart';

typedef ErrorBuilder = Widget Function(BuildContext context, Object? error);

/// Convenience widget for working with Futures
///
/// Example:
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return AsyncBuilder.single<String>(
///       Future.delayed(const Duration(seconds: 3), () => 'String from the future'),
///       onData: (context, data) => Center(child: Text(data)),
///     );
///   }
/// }
/// ```
class AsyncBuilder extends StatelessWidget {
  final Future<List<dynamic>> snapshots;

  final int dataLength;

  /// Used to wrap the [onData], [onError] on [onLoading] result with another [Widget] such as a [Scaffold].
  final Widget Function(BuildContext context, Widget child, List<dynamic> data) builder;

  /// Display a widget when the data is loaded
  final Widget Function(BuildContext context, List<dynamic> data) onData;

  /// Display a widget when an error occurred
  ///
  /// Defaults to a centered [Text] Widget containing the error
  final ErrorBuilder? onError;

  /// Display a widget while data is loading
  ///
  /// Defaults to [Center] -> [CircularProgressIndicator]
  final WidgetBuilder? onLoading;

  /// Convenience override of [onLoading] and [onError] behaviour
  ///
  /// Can only be used when [onError] **and** [onLoading] are not specified.
  final WidgetBuilder? orElse;

  AsyncBuilder._({
    Key? key,
    required Iterable<Future<dynamic>> snapshots,
    required this.builder,
    required this.onData,
    required this.onError,
    required this.onLoading,
    required this.orElse,
  })   : assert((orElse != null && onError == null && onLoading == null) || orElse == null,
            'orElse is only allowed if onError and onLoading are null'),
        snapshots = Future.wait(snapshots),
        dataLength = snapshots.length,
        super(key: key);

  static AsyncBuilder single<A>(
    Future<A> snapshot, {
    Key? key,
    required Widget Function(BuildContext context, A data) onData,
    Widget Function(BuildContext context, Widget child, A? data)? builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncBuilder._(
        key: key,
        snapshots: [snapshot],
        onData: (context, data) => onData(context, data[0] as A),
        builder: (context, child, data) => builder != null ? builder.call(context, child, data[0] as A?) : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  static AsyncBuilder combine2<A, B>(
    Future<A> snapshot1,
    Future<B> snapshot2, {
    required Widget Function(BuildContext context, A data1, B data2) onData,
    Widget Function(BuildContext context, Widget child, A? data1, B? data2)? builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncBuilder._(
        snapshots: [snapshot1, snapshot2],
        onData: (context, data) => onData(context, data[0] as A, data[1] as B),
        builder: (context, child, data) => builder != null ? builder.call(context, child, data[0] as A?, data[1] as B?) : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  static AsyncBuilder combine3<A, B, C>(
    Future<A> snapshot1,
    Future<B> snapshot2,
    Future<C> snapshot3, {
    required Widget Function(BuildContext context, A data1, B data2, C data3) onData,
    Widget Function(BuildContext context, Widget child, A? data1, B? data2, C? data3)? builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncBuilder._(
        snapshots: [snapshot1, snapshot2, snapshot3],
        onData: (context, data) => onData(context, data[0] as A, data[1] as B, data[2] as C),
        builder: (context, child, data) =>
            builder != null ? builder.call(context, child, data[0] as A?, data[1] as B?, data[2] as C?) : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  static AsyncBuilder combine4<A, B, C, D>(
    Future<A> snapshot1,
    Future<B> snapshot2,
    Future<C> snapshot3,
    Future<D> snapshot4, {
    required Widget Function(BuildContext context, A data1, B data2, C data3, D data4) onData,
    Widget Function(BuildContext context, Widget child, A? data1, B? data2, C? data3, D? data4)? builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncBuilder._(
        snapshots: [snapshot1, snapshot2, snapshot3, snapshot4],
        onData: (context, data) => onData(context, data[0] as A, data[1] as B, data[2] as C, data[3] as D),
        builder: (context, child, data) =>
            builder != null ? builder.call(context, child, data[0] as A?, data[1] as B?, data[2] as C?, data[3] as D?) : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  static AsyncBuilder combine5<A, B, C, D, E>(
    Future<A> snapshot1,
    Future<B> snapshot2,
    Future<C> snapshot3,
    Future<D> snapshot4,
    Future<E> snapshot5, {
    required Widget Function(BuildContext context, A data1, B data2, C data3, D data4, E data5) onData,
    Widget Function(BuildContext context, Widget child, A? data1, B? data2, C? data3, D? data4, E? data5)? builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncBuilder._(
        snapshots: [snapshot1, snapshot2, snapshot3, snapshot4, snapshot5],
        onData: (context, data) => onData(context, data[0] as A, data[1] as B, data[2] as C, data[3] as D, data[4] as E),
        builder: (context, child, data) => builder != null
            ? builder.call(context, child, data[0] as A?, data[1] as B?, data[2] as C?, data[3] as D?, data[4] as E?)
            : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  static AsyncBuilder combine6<A, B, C, D, E, F>(
    Future<A> snapshot1,
    Future<B> snapshot2,
    Future<C> snapshot3,
    Future<D> snapshot4,
    Future<E> snapshot5,
    Future<F> snapshot6, {
    required Widget Function(BuildContext context, A data1, B data2, C data3, D data4, E data5, F data6) onData,
    Widget Function(BuildContext context, Widget child, A? data1, B? data2, C? data3, D? data4, E? data5, F? data6)? builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncBuilder._(
        snapshots: [snapshot1, snapshot2, snapshot3, snapshot4, snapshot5, snapshot6],
        onData: (context, data) => onData(context, data[0] as A, data[1] as B, data[2] as C, data[3] as D, data[4] as E, data[5] as F),
        builder: (context, child, data) => builder != null
            ? builder.call(context, child, data[0] as A?, data[1] as B?, data[2] as C?, data[3] as D?, data[4] as E?, data[5] as F?)
            : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  static AsyncBuilder combine7<A, B, C, D, E, F, G>(
    Future<A> snapshot1,
    Future<B> snapshot2,
    Future<C> snapshot3,
    Future<D> snapshot4,
    Future<E> snapshot5,
    Future<F> snapshot6,
    Future<G> snapshot7, {
    required Widget Function(BuildContext context, A data1, B data2, C data3, D data4, E data5, F data6, G data7) onData,
    Widget Function(BuildContext context, Widget child, A? data1, B? data2, C? data3, D? data4, E? data5, F? data6, G? data7)? builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncBuilder._(
        snapshots: [snapshot1, snapshot2, snapshot3, snapshot4, snapshot5, snapshot6, snapshot7],
        onData: (context, data) => onData(
          context,
          data[0] as A,
          data[1] as B,
          data[2] as C,
          data[3] as D,
          data[4] as E,
          data[5] as F,
          data[6] as G,
        ),
        builder: (context, child, data) => builder != null
            ? builder.call(
                context,
                child,
                data[0] as A?,
                data[1] as B?,
                data[2] as C?,
                data[3] as D?,
                data[4] as E?,
                data[5] as F?,
                data[6] as G?,
              )
            : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  static AsyncBuilder combine8<A, B, C, D, E, F, G, H>(
    Future<A> snapshot1,
    Future<B> snapshot2,
    Future<C> snapshot3,
    Future<D> snapshot4,
    Future<E> snapshot5,
    Future<F> snapshot6,
    Future<G> snapshot7,
    Future<H> snapshot8, {
    required Widget Function(BuildContext context, A data1, B data2, C data3, D data4, E data5, F data6, G data7, H data8) onData,
    Widget Function(BuildContext context, Widget child, A? data1, B? data2, C? data3, D? data4, E? data5, F? data6, G? data7, H? data8)?
        builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncBuilder._(
        snapshots: [snapshot1, snapshot2, snapshot3, snapshot4, snapshot5, snapshot6, snapshot7, snapshot8],
        onData: (context, data) => onData(
          context,
          data[0] as A,
          data[1] as B,
          data[2] as C,
          data[3] as D,
          data[4] as E,
          data[5] as F,
          data[6] as G,
          data[7] as H,
        ),
        builder: (context, child, data) => builder != null
            ? builder.call(
                context,
                child,
                data[0] as A?,
                data[1] as B?,
                data[2] as C?,
                data[3] as D?,
                data[4] as E?,
                data[5] as F?,
                data[6] as G?,
                data[7] as H?,
              )
            : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  static AsyncBuilder combine9<A, B, C, D, E, F, G, H, I>(
    Future<A> snapshot1,
    Future<B> snapshot2,
    Future<C> snapshot3,
    Future<D> snapshot4,
    Future<E> snapshot5,
    Future<F> snapshot6,
    Future<G> snapshot7,
    Future<H> snapshot8,
    Future<I> snapshot9, {
    required Widget Function(BuildContext context, A data1, B data2, C data3, D data4, E data5, F data6, G data7, H data8, I data9) onData,
    Widget Function(
      BuildContext context,
      Widget child,
      A? data1,
      B? data2,
      C? data3,
      D? data4,
      E? data5,
      F? data6,
      G? data7,
      H? data8,
      I? data9,
    )?
        builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncBuilder._(
        snapshots: [snapshot1, snapshot2, snapshot3, snapshot4, snapshot5, snapshot6, snapshot7, snapshot8, snapshot9],
        onData: (context, data) => onData(
          context,
          data[0] as A,
          data[1] as B,
          data[2] as C,
          data[3] as D,
          data[4] as E,
          data[5] as F,
          data[6] as G,
          data[7] as H,
          data[8] as I,
        ),
        builder: (context, child, data) => builder != null
            ? builder.call(
                context,
                child,
                data[0] as A?,
                data[1] as B?,
                data[2] as C?,
                data[3] as D?,
                data[4] as E?,
                data[5] as F?,
                data[6] as G?,
                data[7] as H?,
                data[8] as I?,
              )
            : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<List<dynamic>>(
      future: snapshots,
      builder: (context, snapshot) {
        Widget child;

        if (snapshot.hasData) {
          child = onData(context, snapshot.data!);
        } else if (snapshot.hasError) {
          final error = snapshot.error!;

          if (onError != null) {
            child = onError!(context, error);
          } else {
            child = Center(
              child: Text(
                error.toString(),
                style: theme.textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            );
          }
        } else {
          if (onLoading != null) {
            child = onLoading!.call(context);
          } else {
            child = const Center(child: CircularProgressIndicator());
          }
        }

        return builder(
          context,
          child,
          snapshot.data ?? List.generate(dataLength, (index) => null),
        );
      },
    );
  }
}
