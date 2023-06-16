// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'following_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FollowingStore on _FollowingStore, Store {
  late final _$chartsAtom =
      Atom(name: '_FollowingStore.charts', context: context);

  @override
  ObservableList<dynamic> get charts {
    _$chartsAtom.reportRead();
    return super.charts;
  }

  @override
  set charts(ObservableList<dynamic> value) {
    _$chartsAtom.reportWrite(value, super.charts, () {
      super.charts = value;
    });
  }

  late final _$_FollowingStoreActionController =
      ActionController(name: '_FollowingStore', context: context);

  @override
  void getCharts() {
    final _$actionInfo = _$_FollowingStoreActionController.startAction(
        name: '_FollowingStore.getCharts');
    try {
      return super.getCharts();
    } finally {
      _$_FollowingStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
charts: ${charts}
    ''';
  }
}
