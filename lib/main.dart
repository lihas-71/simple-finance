import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psh_finance/controllers/salary_calculator.dart';
import 'package:psh_finance/helper.dart';
import 'package:psh_finance/models/employee.dart';
import 'package:psh_finance/models/payment.dart';
import 'package:psh_finance/services/payroll.dart';

/// Flutter code sample for [DataTable].

void main() => runApp(const DataTableExampleApp());

class DataTableExampleApp extends StatelessWidget {
  const DataTableExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async {
          Employee e = Employee("Ram", 10000000, 250000, true);
          print("ram");
          var res = PayrollService().addEmployee(e);
          res.then((value) {
            var msg = value ? "success" : "false";
            print(msg);
          });
        }),
        appBar: AppBar(title: const Text('DataTable Sample')),
        body: ChangeNotifierProvider(
          create: (context) => SalaryCalculatorController(),
          child: const DataTableExample(),
        ),
      ),
    );
  }
}

class DataTableExample extends StatelessWidget {
  const DataTableExample({super.key});

  final List<String> _columnNames = const [
    "EMPLOYEE NAME",
    "BASE SALARY",
    "BONUS",
    "MISC",
    "LEAVES",
    "OVERTIME ( hours )",
    "PAID",
    "NET PAYABLE",
    "REMARKS",
    "STATUS"
  ];

  @override
  Widget build(BuildContext context) {
    // Employee emp = Employee("1", "Sanjeev", 18000, 3000, true);
    Payment payment =
        Payment(id: "1", amount: 5000, timeStamp: DateTime.now(), payeeId: "1");
    return Center(
      child: Consumer<SalaryCalculatorController>(
          builder: (context, salaryCalculator, child) {
        return DataTable(
          columns: _columnNames
              .map(
                (e) => DataColumn(
                  label: Expanded(
                    child: Text(
                      e,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              )
              .toList(),
          rows: salaryCalculator.getRows(),
        );
      }),
    );
  }
}
