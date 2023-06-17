import 'dart:io';

import 'package:decide/tabs/models/chart_comment.dart';
import 'package:decide/tabs/models/profile_model.dart';
import 'package:decide/tabs/views/modal/on_comment_sent.dart';
import 'package:decide/tabs/views/modal/on_send_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CommentsModal extends StatefulWidget {
  final ProfileModel? currentUser;
  final List<ChartComment> comments;
  final OnSendComment onSendComment;

  const CommentsModal(
      {super.key,
      required this.comments,
      required this.currentUser,
      required this.onSendComment});

  @override
  State<CommentsModal> createState() => _CommentsModalState();
}

class _CommentsModalState extends State<CommentsModal> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: const Text("Comentários"),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final comment = widget.comments[index];
                    var commentOwner = comment.commentOwner;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Observer(builder: (context) {
                            final ImageProvider imageProvider;
                            var imagePath = commentOwner.imagePath;
                            if (imagePath.isEmpty) {
                              imageProvider = const AssetImage(
                                  "assets/images/default_profile.jpeg");
                            } else {
                              imageProvider = FileImage(File(imagePath));
                            }
                            return CircleAvatar(
                                radius: 15, backgroundImage: imageProvider);
                          }),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      commentOwner.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        final currentUser = widget.currentUser;
                                        if(currentUser == null) return;
                                        widget.onSendComment.onFollowUser(currentUser, commentOwner);
                                        Navigator.of(context).pop();
                                        final snackBar = SnackBar(
                                          content: Text('Você começou a seguir ${commentOwner.name}'),
                                          backgroundColor: Colors.blue,
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      },
                                      child:  Builder(
                                        builder: (context) {
                                          final currentUser = widget.currentUser;
                                          if(currentUser == null) return const SizedBox();
                                          if(commentOwner.login == currentUser.login) return const SizedBox();
                                          return Container(
                                            margin: const EdgeInsets.only(left: 10),
                                            child: const Text(
                                              "Seguir",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0),
                                            ),
                                          );
                                        }
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        comment.comment,
                                        style: const TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 2,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 60.0,
                                          width: 60.0,
                                          color: Colors.grey[200],
                                          child: Center(
                                            child: Image.asset(
                                                comment.votedOption.picture),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                const Divider(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Observer(builder: (context) {
                    final ImageProvider imageProvider;
                    final currentUser = widget.currentUser;
                    if(currentUser == null) return const SizedBox();
                    var imagePath = currentUser.imagePath;
                    if (imagePath.isEmpty) {
                      imageProvider = const AssetImage(
                          "assets/images/default_profile.jpeg");
                    } else {
                      imageProvider = FileImage(File(imagePath));
                    }
                    return CircleAvatar(
                        radius: 15, backgroundImage: imageProvider);
                  }),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: "Adicione um comentário...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    icon: const Icon(Icons.next_plan_rounded),
                    onPressed: () {
                      widget.onSendComment
                          .onSendComment(_commentController.text);
                      FocusManager.instance.primaryFocus?.unfocus();
                      _commentController.clear();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
