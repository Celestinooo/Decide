import 'package:decide/tabs/models/chart_option.dart';
import 'package:decide/tabs/models/profile_model.dart';

class ChartComment {
  final ProfileModel commentOwner;
  final ChartOption votedOption;
  final String comment;

  ChartComment({
    required this.commentOwner,
    required this.votedOption,
    required this.comment,
  });
}
