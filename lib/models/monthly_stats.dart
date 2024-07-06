class MonthlyStats {
  double leaves;
  double overtime;
  final String employeedId;
  double miscellenousAmount;

  MonthlyStats({
    this.leaves = 0,
    this.overtime = 0,
    this.miscellenousAmount = 0,
    required this.employeedId,
  });
}
