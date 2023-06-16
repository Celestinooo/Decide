import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:decide/authentication/views/logout_confirmation_dialog.dart';
import 'package:decide/tabs/models/chart_model.dart';
import 'package:decide/tabs/models/profile_model.dart';
import 'package:decide/tabs/stores/profile_store.dart';
import 'package:decide/tabs/views/modal/on_comment_sent.dart';
import 'package:decide/tabs/views/widgets/chart_participation_widget.dart';
import 'package:decide/tabs/views/widgets/chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ModularState<ProfileTab, ProfileStore> with AfterLayoutMixin implements OnCommentSent
     {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                color: Colors.grey[800],
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 40,
                  bottom: 16,
                ),
                child: Row(
                  children: [
                    Observer(builder: (context) {
                      final ImageProvider imageProvider;
                      var imagePath = store.imagePath;
                      if (imagePath.isEmpty) {
                        imageProvider =
                            AssetImage("assets/images/default_profile.jpeg");
                      } else {
                        imageProvider = FileImage(File(imagePath));
                      }
                      return CircleAvatar(
                          radius: 50, backgroundImage: imageProvider);
                    }),
                    const SizedBox(
                      width: 16,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            _showEditProfileDialog(context);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey[800],
                            side: const BorderSide(
                                width: 1, color: Color.fromRGBO(255, 255, 255, 1)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Editar perfil',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _askForLogout();
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red[800],
                            side: const BorderSide(
                                width: 0.2, color: Color.fromRGBO(255, 0, 0, 1.0)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          icon: const Icon(Icons.exit_to_app_sharp,color: Colors.red,size: 22,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.grey[800],
                padding: const EdgeInsets.only(left: 16, bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Observer(builder: (context) {
                              return Text(
                                store.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Observer(builder: (context) {
                                    return Flexible(
                                      child: Text(
                                        store.description,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 5,
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey[800],
                      child: const TabBar(
                        indicatorColor: Colors.red,
                        labelColor: Colors.white,
                        tabs: [
                          Tab(
                            text: 'Decides',
                          ),
                          Tab(
                            text: 'Participações',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Observer(builder: (context) {
                            return ListView.builder(
                                itemCount: store.charts.length,
                                itemBuilder: (context, index) {
                                  return ChartWidget(
                                    chartModel: store.charts[index],
                                    currentUser: store.getCurrentUser(),
                                    onCommentSent: this,
                                  );
                                });
                          }),
                          Observer(
                            builder: (context) {
                              return ListView.builder(
                                itemCount: store.charts.length,
                                itemBuilder: (context, index) {
                                  var repoProfile = store.getRepoProfile();
                                  if (repoProfile == null) return const SizedBox();
                                  return ChartParticipationWidget(
                                    chartModel: store.charts[index],
                                    currentUser: repoProfile,
                                  );
                                },
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditProfileDialog(BuildContext context) async {
    store.openProfileEdit();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Perfil'),
          content: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        final croppedFile = await ImageCropper()
                            .cropImage(sourcePath: pickedFile.path);
                        if (croppedFile == null) return;
                        setState(() {
                          store.editingImagePath = croppedFile.path;
                        });
                      }
                    },
                    child: Row(
                      children: [
                        Observer(builder: (context) {
                          ImageProvider imageProvider;
                          var imagePath = store.imagePath;
                          if (imagePath.isEmpty) {
                            imageProvider = AssetImage(
                                "assets/images/default_profile.jpeg");
                          } else {
                            imageProvider = FileImage(File(imagePath));
                          }
                          var editingImagePath = store.editingImagePath;
                          if (editingImagePath.isNotEmpty)
                            imageProvider = FileImage(File(editingImagePath));
                          return CircleAvatar(
                              radius: 50, backgroundImage: imageProvider);
                        }),
                      ],
                    ),
                  ),
                  Row(
                    children: const [
                      Text(
                        "Toque para alterar",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: store.name,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                    ),
                    onChanged: (value) {
                      setState(() {
                        store.editingName = value;
                      });
                    },
                  ),
                  TextFormField(
                    initialValue: store.description,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                    ),
                    onChanged: (value) {
                      setState(() {
                        store.editingDescription = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  store.saveProfile();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    store.getProfile();
    store.getCharts();
  }

  Future<void> _askForLogout() async {
    final confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) => const LogoutConfirmationDialog(),
    );
    if (confirmed == true) {
      Modular.to.popUntil((p0) => p0.isFirst);
    }

  }

  @override
  void onCommentSent(ChartModel chartModel, String comment) {
  }

  @override
  void onFollowUser(ProfileModel currentUser, ProfileModel followedUser) {
    store.followUser(currentUser, followedUser);
  }
}
