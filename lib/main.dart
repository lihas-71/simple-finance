import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psh_finance/controllers/salary_calculator.dart';
import 'package:psh_finance/helper.dart';
import 'package:psh_finance/models/employee.dart';
import 'package:psh_finance/models/payment.dart';
import 'package:psh_finance/services/payroll.dart';

/// Flutter code sample for [DataTable].

void main() => runApp(const PSHFinanceApp());

class PSHFinanceApp extends StatelessWidget {
  const PSHFinanceApp({super.key});

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert Dialog'),
          content: Text('This is a simple alert dialog.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Salary Calculator')),
        body: ChangeNotifierProvider(
          create: (context) => SalaryCalculatorController(),
          child: SalaryCalculator(),
        ),
      ),
    );
  }
}

class SalaryCalculator extends StatelessWidget {
  const SalaryCalculator({super.key});

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

  void showAddEmployeeDialog(BuildContext context) {
    final TextEditingController employeeNameController =
        TextEditingController();
    final TextEditingController employeeSalaryController =
        TextEditingController();
    final TextEditingController employeeBonusController =
        TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Employee Details'),
          content: Column(
            children: [
              TextField(
                controller: employeeNameController,
                decoration: const InputDecoration(hintText: "Name"),
              ),
              TextField(
                decoration: const InputDecoration(hintText: "Salary"),
                controller: employeeSalaryController,
              ),
              TextField(
                controller: employeeBonusController,
                decoration: const InputDecoration(hintText: "Bonus"),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                var employee = Employee(
                    employeeNameController.text,
                    double.parse(employeeSalaryController.text.trim()),
                    double.parse(employeeBonusController.text.trim()),
                    true);
                PayrollService().addEmployee(employee).then((_) {
                  employeeNameController.clear();
                  employeeSalaryController.clear();
                  employeeBonusController.clear();
                  Navigator.of(context).pop();
                });
                // Close the dialog
              },
              child: const Text('Create Employee'),
            ),
          ],
        );
      },
    );
  }

  void showAddPaymentDialog(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Payment Details'),
          content: Column(
            children: [
              TextField(
                controller: amountController,
                decoration: const InputDecoration(hintText: "Name"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                amountController.dispose();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Create Employee'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<SalaryCalculatorController>(
          builder: (context, controller, child) {
        if (!controller.isInitialized) {
          controller.init();
        }

        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[200]),
                  onPressed: () {
                    showAddEmployeeDialog(context);
                  },
                  child: const Text('Add New Employee'),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[200]),
                  onPressed: () {
                    showAddPaymentDialog(context);
                  },
                  child: const Text('Add New Payment'),
                )
              ],
            ),
            DataTable(
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
              rows: controller.getRows(),
            ),
          ],
        );
      }),
    );
  }
}
