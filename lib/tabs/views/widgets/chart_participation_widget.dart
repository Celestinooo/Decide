import 'dart:io';
import 'dart:math';

import 'package:decide/tabs/models/chart_model.dart';
import 'package:decide/tabs/models/chart_option.dart';
import 'package:decide/tabs/models/profile_model.dart';
import 'package:decide/tabs/views/modal/comments_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ChartParticipationWidget extends StatefulWidget {
  final ProfileModel currentUser;
  final ChartModel chartModel;

  const ChartParticipationWidget(
      {Key? key, required this.chartModel, required this.currentUser})
      : super(key: key);

  @override
  State<ChartParticipationWidget> createState() =>
      _ChartParticipationWidgetState();
}

class _ChartParticipationWidgetState extends State<ChartParticipationWidget> {
  @override
  Widget build(BuildContext context) {
    var chartModel = widget.chartModel;
    var owner = chartModel.owner;
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Observer(builder: (context) {
                          final ImageProvider imageProvider;
                          var imagePath = owner.imagePath;
                          if (imagePath.isEmpty) {
                            imageProvider = const AssetImage(
                                "assets/images/default_profile.jpeg");
                          } else {
                            imageProvider = FileImage(File(imagePath));
                          }
                          return CircleAvatar(
                              radius: 15, backgroundImage: imageProvider);
                        }),
                        const SizedBox(width: 16.0),
                        Text(
                          owner.name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.arrow_upward),
                        const SizedBox(width: 8.0),
                        Text(
                          '${chartModel.votes} votos',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                          chartModel.title,
                          key: const Key("teste"),
                          style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200.0,
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              color: Colors.grey[200],
                              child: Center(
                                child: Image.file(File(chartModel.option1.picture)),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        color: Colors.amber.withOpacity(0.6),
                                        height: 40,
                                        child: const Icon(
                                            Icons.check_circle_outline)),
                                    Expanded(
                                      child: Container(
                                          color: Colors.amber.withOpacity(0.6),
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          height: 40,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      "${chartModel.option1.percentage}%",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          _getVotedCoverForOption(chartModel.option1),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              color: Colors.grey[200],
                              child: Center(
                                child: Image.file(File(chartModel.option2.picture)),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        color: Colors.amber.withOpacity(0.6),
                                        height: 40,
                                        child: const Icon(
                                            Icons.check_circle_outline)),
                                    Expanded(
                                      child: Container(
                                          color: Colors.amber.withOpacity(0.6),
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          height: 40,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      "${chartModel.option2.percentage}%",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          _getVotedCoverForOption(chartModel.option2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Comentários de ${widget.currentUser.name}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  itemCount: widget.chartModel.chartComments.length,
                  itemBuilder: (context, index) {
                    final comment = widget.chartModel.chartComments[index];
                    if(comment.commentOwner.id != widget.currentUser.id) return const SizedBox();
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Row(
                              children: [
                                Observer(builder: (context) {
                                  final ImageProvider imageProvider;
                                  var imagePath = widget.currentUser.imagePath;
                                  if (imagePath.isEmpty) {
                                    imageProvider = const AssetImage(
                                        "assets/images/default_profile.jpeg");
                                  } else {
                                    imageProvider = FileImage(File(imagePath));
                                  }
                                  return CircleAvatar(
                                      radius: 15, backgroundImage: imageProvider);
                                }),
                                const SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: Text(
                                    comment.comment,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const Divider(
                thickness: 2.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getVotedCoverForOption(ChartOption option) {
    final userId = widget.currentUser.id;
    final chartVotes = widget.chartModel.chartVotes;
    bool voted = false;
    for (var vote in chartVotes) {
      if (vote.participant.id != userId) continue;
      if (vote.option.id == option.id) voted = true;
    }
    if (!voted) return const SizedBox();
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey[800],
                  padding: const EdgeInsets.only(left: 10),
                  height: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: const [
                          Text("VOTOU",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
