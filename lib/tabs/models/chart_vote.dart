import 'package:decide/tabs/models/chart_option.dart';
import 'package:decide/tabs/models/profile_model.dart';

class ChartVote {
  final ProfileModel participant;
  final ChartOption option;

  ChartVote({
    required this.participant,
    required this.option,
  });
}
