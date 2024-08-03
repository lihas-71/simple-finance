import 'package:psh_finance/models/employee.dart';

class Payment {
  final String? id;
  final double amount;
  final DateTime timeStamp;
  final Employee payee;

  Payment(
      {this.id,
      required this.amount,
      required this.timeStamp,
      required this.payee});
}
