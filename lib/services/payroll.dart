import 'package:psh_finance/helper.dart';
import 'package:psh_finance/models/employee.dart';
import 'package:psh_finance/models/monthly_stats.dart';

import '../models/payment.dart';

class PayrollService {
  List<Employee> getEmployees() => [];
  List<Payment> getPayments() => [];
  void addPayment(Employee employee, double amount, DateTime? timeStamp) {}
  void updateMonthlyStats(List<MonthlyStats> stats) {}
  void updateStatus(paymentStatus s) {}
}
