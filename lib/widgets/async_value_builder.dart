import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import 'async_builder.dart';

class AsyncValueBuilder extends StatelessWidget {
  final Future<List<dynamic>> snapshot;

  final int dataLength;

  /// Used to wrap the onData, onError on onLoading result with another [Widget] such as a [Scaffold].
  final Widget Function(BuildContext context, Widget child, List<dynamic> data)
      builder;

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

  /// Override [onLoading] and [onError] behaviour
  ///
  /// Can only be used when onError and onLoading are not specified.
  final WidgetBuilder? orElse;

  AsyncValueBuilder._({
    Key? key,
    required Iterable<AsyncValue<dynamic>> asyncValues,
    required this.builder,
    required this.onData,
    required this.onError,
    required this.onLoading,
    required this.orElse,
  })  : assert(
          (orElse != null && onError == null && onLoading == null) ||
              orElse == null,
          'orElse is only allowed if onError and onLoading are null',
        ),
        snapshot = Future.wait(asyncValues.map(_asyncValueFuture).toList()),
        dataLength = asyncValues.length,
        super(key: key);

  static AsyncValueBuilder single<A>(
    AsyncValue<A> asyncValue, {
    Key? key,
    required Widget Function(BuildContext context, A data) onData,
    Widget Function(BuildContext context, Widget child, A? data)? builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncValueBuilder._(
        key: key,
        asyncValues: [asyncValue],
        onData: (context, data) => onData(context, data[0] as A),
        builder: (context, child, data) => builder != null
            ? builder.call(
                context,
                child,
                data[0] as A?,
              )
            : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  static AsyncValueBuilder combine2<A, B>(
    AsyncValue<A> asyncValue1,
    AsyncValue<B> asyncValue2, {
    required Widget Function(BuildContext context, A data1, B data2) onData,
    Widget Function(BuildContext context, Widget child, A? data1, B? data2)?
        builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncValueBuilder._(
        asyncValues: [asyncValue1, asyncValue2],
        onData: (context, data) => onData(context, data[0] as A, data[1] as B),
        builder: (context, child, data) => builder != null
            ? builder.call(
                context,
                child,
                data[0] as A?,
                data[1] as B?,
              )
            : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  static AsyncValueBuilder combine3<A, B, C>(
    AsyncValue<A> asyncValue1,
    AsyncValue<B> asyncValue2,
    AsyncValue<C> asyncValue3, {
    required Widget Function(BuildContext context, A data1, B data2, C data3)
        onData,
    Widget Function(
      BuildContext context,
      Widget child,
      A? data1,
      B? data2,
      C? data3,
    )?
        builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncValueBuilder._(
        asyncValues: [asyncValue1, asyncValue2, asyncValue3],
        onData: (context, data) =>
            onData(context, data[0] as A, data[1] as B, data[2] as C),
        builder: (context, child, data) => builder != null
            ? builder.call(
                context,
                child,
                data[0] as A?,
                data[1] as B?,
                data[2] as C?,
              )
            : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  static AsyncValueBuilder combine4<A, B, C, D>(
    AsyncValue<A> asyncValue1,
    AsyncValue<B> asyncValue2,
    AsyncValue<C> asyncValue3,
    AsyncValue<D> asyncValue4, {
    required Widget Function(
      BuildContext context,
      A data1,
      B data2,
      C data3,
      D data4,
    )
        onData,
    Widget Function(
      BuildContext context,
      Widget child,
      A? data1,
      B? data2,
      C? data3,
      D? data4,
    )?
        builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncValueBuilder._(
        asyncValues: [asyncValue1, asyncValue2, asyncValue3, asyncValue4],
        onData: (context, data) => onData(
          context,
          data[0] as A,
          data[1] as B,
          data[2] as C,
          data[3] as D,
        ),
        builder: (context, child, data) => builder != null
            ? builder.call(
                context,
                child,
                data[0] as A?,
                data[1] as B?,
                data[2] as C?,
                data[3] as D?,
              )
            : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  static AsyncValueBuilder combine5<A, B, C, D, E>(
    AsyncValue<A> asyncValue1,
    AsyncValue<B> asyncValue2,
    AsyncValue<C> asyncValue3,
    AsyncValue<D> asyncValue4,
    AsyncValue<E> asyncValue5, {
    required Widget Function(
      BuildContext context,
      A data1,
      B data2,
      C data3,
      D data4,
      E data5,
    )
        onData,
    Widget Function(
      BuildContext context,
      Widget child,
      A? data1,
      B? data2,
      C? data3,
      D? data4,
      E? data5,
    )?
        builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncValueBuilder._(
        asyncValues: [
          asyncValue1,
          asyncValue2,
          asyncValue3,
          asyncValue4,
          asyncValue5
        ],
        onData: (context, data) => onData(
          context,
          data[0] as A,
          data[1] as B,
          data[2] as C,
          data[3] as D,
          data[4] as E,
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
              )
            : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  static AsyncValueBuilder combine6<A, B, C, D, E, F>(
    AsyncValue<A> asyncValue1,
    AsyncValue<B> asyncValue2,
    AsyncValue<C> asyncValue3,
    AsyncValue<D> asyncValue4,
    AsyncValue<E> asyncValue5,
    AsyncValue<F> asyncValue6, {
    required Widget Function(
      BuildContext context,
      A data1,
      B data2,
      C data3,
      D data4,
      E data5,
      F data6,
    )
        onData,
    Widget Function(
      BuildContext context,
      Widget child,
      A? data1,
      B? data2,
      C? data3,
      D? data4,
      E? data5,
      F? data6,
    )?
        builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncValueBuilder._(
        asyncValues: [
          asyncValue1,
          asyncValue2,
          asyncValue3,
          asyncValue4,
          asyncValue5,
          asyncValue6
        ],
        onData: (context, data) => onData(
          context,
          data[0] as A,
          data[1] as B,
          data[2] as C,
          data[3] as D,
          data[4] as E,
          data[5] as F,
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
              )
            : child,
        onError: onError,
        onLoading: onLoading,
        orElse: orElse,
      );

  static AsyncValueBuilder combine7<A, B, C, D, E, F, G>(
    AsyncValue<A> asyncValue1,
    AsyncValue<B> asyncValue2,
    AsyncValue<C> asyncValue3,
    AsyncValue<D> asyncValue4,
    AsyncValue<E> asyncValue5,
    AsyncValue<F> asyncValue6,
    AsyncValue<G> asyncValue7, {
    required Widget Function(
      BuildContext context,
      A data1,
      B data2,
      C data3,
      D data4,
      E data5,
      F data6,
      G data7,
    )
        onData,
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
    )?
        builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncValueBuilder._(
        asyncValues: [
          asyncValue1,
          asyncValue2,
          asyncValue3,
          asyncValue4,
          asyncValue5,
          asyncValue6,
          asyncValue7
        ],
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

  static AsyncValueBuilder combine8<A, B, C, D, E, F, G, H>(
    AsyncValue<A> asyncValue1,
    AsyncValue<B> asyncValue2,
    AsyncValue<C> asyncValue3,
    AsyncValue<D> asyncValue4,
    AsyncValue<E> asyncValue5,
    AsyncValue<F> asyncValue6,
    AsyncValue<G> asyncValue7,
    AsyncValue<H> asyncValue8, {
    required Widget Function(
      BuildContext context,
      A data1,
      B data2,
      C data3,
      D data4,
      E data5,
      F data6,
      G data7,
      H data8,
    )
        onData,
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
    )?
        builder,
    ErrorBuilder? onError,
    WidgetBuilder? onLoading,
    WidgetBuilder? orElse,
  }) =>
      AsyncValueBuilder._(
        asyncValues: [
          asyncValue1,
          asyncValue2,
          asyncValue3,
          asyncValue4,
          asyncValue5,
          asyncValue6,
          asyncValue7,
          asyncValue8
        ],
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

  static AsyncValueBuilder combine9<A, B, C, D, E, F, G, H, I>(
    AsyncValue<A> asyncValue1,
    AsyncValue<B> asyncValue2,
    AsyncValue<C> asyncValue3,
    AsyncValue<D> asyncValue4,
    AsyncValue<E> asyncValue5,
    AsyncValue<F> asyncValue6,
    AsyncValue<G> asyncValue7,
    AsyncValue<H> asyncValue8,
    AsyncValue<I> asyncValue9, {
    required Widget Function(
      BuildContext context,
      A data1,
      B data2,
      C data3,
      D data4,
      E data5,
      F data6,
      G data7,
      H data8,
      I data9,
    )
        onData,
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
      AsyncValueBuilder._(
        asyncValues: [
          asyncValue1,
          asyncValue2,
          asyncValue3,
          asyncValue4,
          asyncValue5,
          asyncValue6,
          asyncValue7,
          asyncValue8,
          asyncValue9
        ],
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
      future: snapshot,
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
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  error.toString(),
                  style: theme.primaryTextTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        } else {
          if (onLoading != null) {
            child = onLoading!.call(context);
          } else {
            child = const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              ),
            );
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

Future<T> _asyncValueFuture<T>(AsyncValue<T> value) async {
  final Completer<T> completer = Completer();
  value.when(
    data: completer.complete,
    error: completer.completeError,
    loading: () {},
  );
  return completer.future;
}
