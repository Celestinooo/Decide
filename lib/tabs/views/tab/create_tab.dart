import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:decide/authentication/views/authentication_failed_dialog.dart';
import 'package:decide/tabs/stores/create_chart_store.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CreateTab extends StatefulWidget {
  const CreateTab({Key? key}) : super(key: key);

  @override
  State<CreateTab> createState() => _CreateTabState();
}

class _CreateTabState extends ModularState<CreateTab, CreateChartStore> {
  @override
  void dispose() {
    store.titleController.dispose();
    super.dispose();
  }

  Future<void> _selectMediaOption1() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final croppedFile =
          await ImageCropper().cropImage(sourcePath: pickedFile.path);
      if (croppedFile == null) return;
      store.firstOptionMedia = croppedFile.path;
    }
  }

  void _removeMediaOption1() {
    setState(() {
      store.firstOptionMedia = "";
    });
  }

  Future<void> _selectMediaOption2() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final croppedFile =
          await ImageCropper().cropImage(sourcePath: pickedFile.path);
      if (croppedFile == null) return;
      store.secondOptionMedia = croppedFile.path;
    }
  }

  void _removeMediaOption2() {
    setState(() {
      store.secondOptionMedia = "";
    });
  }

  void _submitForm() {
    final returnMessage = store.submit();
    final registerSuccess = returnMessage == null;
    if (registerSuccess) {
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AuthenticationFailedDialog(
          title: "Falha na criação",
          content: returnMessage,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Material(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      _getHeader(),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: store.titleController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Título',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Opção 1',
                              style: TextStyle(color: Colors.white),
                            ),
                            if (store.firstOptionMedia.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.remove_circle),
                                onPressed: _removeMediaOption1,
                              ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Observer(builder: (context) {
                          var firstOptionMedia = store.firstOptionMedia;
                          if (firstOptionMedia.isEmpty) return const SizedBox();
                          return SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.file(File(firstOptionMedia),
                                fit: BoxFit.cover),
                          );
                        }),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: _selectMediaOption1,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey[800],
                            onPrimary: Colors.white,
                          ),
                          child: const Text(
                            'Selecionar imagem ou vídeo',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Opção 2',
                              style: TextStyle(color: Colors.white),
                            ),
                            if (store.secondOptionMedia.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.remove_circle),
                                onPressed: _removeMediaOption2,
                              ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Observer(builder: (context) {
                          var secondOptionMedia = store.secondOptionMedia;
                          if (secondOptionMedia.isEmpty)
                            return const SizedBox();
                          return SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.file(File(secondOptionMedia),
                                fit: BoxFit.cover),
                          );
                        }),
                        const SizedBox(height: 8.0),
                        ElevatedButton(
                          onPressed: _selectMediaOption2,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey[800],
                            onPrimary: Colors.white,
                          ),
                          child: const Text(
                            'Selecionar imagem ou vídeo',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Permitir comentários',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Observer(builder: (context) {
                              return Switch(
                                value: store.allowComments,
                                onChanged: (value) {
                                  store.allowComments = value;
                                },
                                activeColor: Colors.red,
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey[800],
                            onPrimary: Colors.white,
                          ),
                          child: const Text(
                            'Concluir',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextButton(
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Decide",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Preencha o formulário abaixo para cadastrar uma nova enquete",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
