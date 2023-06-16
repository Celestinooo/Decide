import 'package:decide/tabs/models/chart_vote.dart';
import 'package:decide/tabs/models/profile_model.dart';

import 'chart_comment.dart';
import 'chart_option.dart';

class ChartModel {
  final int id;
  final ProfileModel owner;
  int votes;
  final String title;
  ChartOption option1;
   ChartOption option2;
  final bool allowComments;
  List<ChartComment> chartComments = <ChartComment>[];
  List<ChartVote> chartVotes = <ChartVote>[];

  ChartModel({
    required this.id,
    required this.owner,
    this.votes = 0,
    required this.title,
    required this.allowComments,
    required this.option1,
    required this.option2,
  });
}
