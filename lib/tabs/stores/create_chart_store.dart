import 'package:decide/tabs/controllers/create_chart_controller.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'create_chart_store.g.dart';

class CreateChartStore = _CreateChartStore with _$CreateChartStore;

abstract class _CreateChartStore with Store {
  @observable
  var firstOptionMedia = "";
  @observable
  var secondOptionMedia = "";
  @observable
  var allowComments = true;
  final TextEditingController titleController = TextEditingController();
  final CreateChartController _createChartController;


  _CreateChartStore(this._createChartController);

  String? submit(){
    final titleText = titleController.text;
    final firstMedia = firstOptionMedia;
    final secondMedia = secondOptionMedia;
    if(titleText.isEmpty) return "Informe o título da enquete";
    if(firstMedia.isEmpty) return "Informe a primeira opção da enquete";
    if(secondMedia.isEmpty) return "Informe a segunda opção da enquete";
    return _createChartController.create(titleText,firstMedia,secondMedia,allowComments);
  }
}