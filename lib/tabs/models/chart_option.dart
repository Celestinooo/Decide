class ChartOption {
  final int id;
  final String picture;
  int votes;
  double percentage;

  ChartOption({
    required this.id,
    this.percentage = 0,
    this.votes = 0,
    required this.picture,
  });
}
