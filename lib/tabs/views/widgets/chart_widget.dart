import 'dart:io';

import 'package:decide/tabs/models/chart_model.dart';
import 'package:decide/tabs/models/profile_model.dart';
import 'package:decide/tabs/views/modal/comments_modal.dart';
import 'package:decide/tabs/views/modal/on_comment_sent.dart';
import 'package:decide/tabs/views/modal/on_send_comment.dart';
import 'package:decide/tabs/views/widgets/on_chart_option_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ChartWidget extends StatefulWidget {
  final ChartModel chartModel;
  final ProfileModel? currentUser;
  final bool isVotingMode;
  final OnChartOptionSelect? onChartOptionSelect;
  final OnCommentSent? onCommentSent;

  const ChartWidget({
    Key? key,
    required this.chartModel,
    this.currentUser,
    this.onChartOptionSelect,
    this.onCommentSent,
    this.isVotingMode = false,
  }) : super(key: key);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> implements OnSendComment {
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
                          GestureDetector(
                            onTapUp: (details) {
                              if (widget.isVotingMode) {
                                widget.onChartOptionSelect?.onChartOptionSelect(
                                    chartModel, chartModel.option1);
                              }
                            },
                            child: Container(
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
                                  child: Image.file(
                                      File(chartModel.option1.picture)),
                                ),
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
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTapUp: (details) {
                              if (widget.isVotingMode) {
                                widget.onChartOptionSelect?.onChartOptionSelect(
                                    chartModel, chartModel.option2);
                              }
                            },
                            child: Container(
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
                                  child: Image.file(
                                      File(chartModel.option2.picture)),
                                ),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (chartModel.allowComments)
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => CommentsModal(
                                comments: chartModel.chartComments,
                                currentUser: widget.currentUser,
                                chartModel: widget.chartModel,
                                onSendComment: this,
                              ),
                              isScrollControlled: true
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey[800],
                            onPrimary: Colors.white,
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.comment),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Comentários',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              const Divider(
                thickness: 2.0,
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  void onSendComment(String text) {
    widget.onCommentSent?.onCommentSent(widget.chartModel,text);
  }

  @override
  void onFollowUser(ProfileModel currentUser, ProfileModel followedUser) {
    widget.onCommentSent?.onFollowUser(currentUser,followedUser);
  }


}
