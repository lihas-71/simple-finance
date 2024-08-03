import 'package:psh_finance/models/employee.dart';

class MonthlyStats {
  double leaves;
  double overtime;
  final Employee employee;
  double miscellenousAmount;

  MonthlyStats({
    this.leaves = 0,
    this.overtime = 0,
    this.miscellenousAmount = 0,
    required this.employee,
  });
}
