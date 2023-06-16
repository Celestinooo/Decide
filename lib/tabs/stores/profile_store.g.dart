// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileStore on _ProfileStore, Store {
  late final _$nameAtom = Atom(name: '_ProfileStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_ProfileStore.description', context: context);

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$imagePathAtom =
      Atom(name: '_ProfileStore.imagePath', context: context);

  @override
  String get imagePath {
    _$imagePathAtom.reportRead();
    return super.imagePath;
  }

  @override
  set imagePath(String value) {
    _$imagePathAtom.reportWrite(value, super.imagePath, () {
      super.imagePath = value;
    });
  }

  late final _$editingImagePathAtom =
      Atom(name: '_ProfileStore.editingImagePath', context: context);

  @override
  String get editingImagePath {
    _$editingImagePathAtom.reportRead();
    return super.editingImagePath;
  }

  @override
  set editingImagePath(String value) {
    _$editingImagePathAtom.reportWrite(value, super.editingImagePath, () {
      super.editingImagePath = value;
    });
  }

  late final _$_ProfileStoreActionController =
      ActionController(name: '_ProfileStore', context: context);

  @override
  void getProfile() {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.getProfile');
    try {
      return super.getProfile();
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getCharts() {
    final _$actionInfo = _$_ProfileStoreActionController.startAction(
        name: '_ProfileStore.getCharts');
    try {
      return super.getCharts();
    } finally {
      _$_ProfileStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
description: ${description},
imagePath: ${imagePath},
editingImagePath: ${editingImagePath}
    ''';
  }
}
