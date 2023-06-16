// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_chart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateChartStore on _CreateChartStore, Store {
  late final _$firstOptionMediaAtom =
      Atom(name: '_CreateChartStore.firstOptionMedia', context: context);

  @override
  String get firstOptionMedia {
    _$firstOptionMediaAtom.reportRead();
    return super.firstOptionMedia;
  }

  @override
  set firstOptionMedia(String value) {
    _$firstOptionMediaAtom.reportWrite(value, super.firstOptionMedia, () {
      super.firstOptionMedia = value;
    });
  }

  late final _$secondOptionMediaAtom =
      Atom(name: '_CreateChartStore.secondOptionMedia', context: context);

  @override
  String get secondOptionMedia {
    _$secondOptionMediaAtom.reportRead();
    return super.secondOptionMedia;
  }

  @override
  set secondOptionMedia(String value) {
    _$secondOptionMediaAtom.reportWrite(value, super.secondOptionMedia, () {
      super.secondOptionMedia = value;
    });
  }

  late final _$allowCommentsAtom =
      Atom(name: '_CreateChartStore.allowComments', context: context);

  @override
  bool get allowComments {
    _$allowCommentsAtom.reportRead();
    return super.allowComments;
  }

  @override
  set allowComments(bool value) {
    _$allowCommentsAtom.reportWrite(value, super.allowComments, () {
      super.allowComments = value;
    });
  }

  @override
  String toString() {
    return '''
firstOptionMedia: ${firstOptionMedia},
secondOptionMedia: ${secondOptionMedia},
allowComments: ${allowComments}
    ''';
  }
}
