import 'package:flutter/material.dart';
import 'package:psh_finance/models/employee.dart';
import 'package:psh_finance/models/monthly_stats.dart';
import 'package:provider/provider.dart';

import '../models/payment.dart';

class SalaryCalculatorRowData {
  final Employee employee;
  final MonthlyStats monthlyStats;
  final List<Payment> payments;

  SalaryCalculatorRowData({
    required this.employee,
    required this.monthlyStats,
    required this.payments,
  });
}

class SalaryCalculatorController extends ChangeNotifier {
  final List<SalaryCalculatorRowData> _rowsData = [];
  final List<Employee> _employees = [];
  final List<SalaryCalculatorRow> _rows = [];
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  void init() {}
  void changeMonth(int month) {}
  void changeyear(int year) {}
  void addPayment(Employee employee, double amount, DateTime timeStamp) {}
  List<DataRow> getRows() {
    return _rows.map((e) => e.get()).toList();
  }
}

class SalaryCalculatorRow {
  final SalaryCalculatorRowData data;
  final TextEditingController _miscelleneousController =
      TextEditingController();
  final TextEditingController _leavesController = TextEditingController();
  final TextEditingController _otController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  SalaryCalculatorRow(this.data);

  void killTextEditingControllers() {
    _miscelleneousController.dispose();
    _leavesController.dispose();
    _otController.dispose();
  }

  double _getPaidAmount() {
    return 0.0;
  }

  double _netPayable() {
    // return data.employee.baseSalary+da _getPaidAmount();
    return 0.0;
  }

  DataRow get() {
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(data.employee.name)),
        DataCell(Text("${data.employee.baseSalary} ₹")),
        DataCell(Text("${data.employee.bonus} ₹")),
        DataCell(TextField(controller: _miscelleneousController)),
        DataCell(TextField(controller: _leavesController)),
        DataCell(TextField(controller: _otController)),
        DataCell(Text("${_getPaidAmount()} ₹")),
        DataCell(Text("${_netPayable()} ₹")),
        DataCell(TextField(controller: _remarksController)),
        DataCell(Text("")),
      ],
    );
  }
}
