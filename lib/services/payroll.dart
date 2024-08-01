import 'dart:convert';
import 'dart:html';

import 'package:psh_finance/helper.dart';
import 'package:psh_finance/models/employee.dart';
import 'package:psh_finance/models/monthly_stats.dart';

import '../models/payment.dart';
import 'package:http/http.dart' as http;

String baseUrl = "http://127.0.0.1:3000/payroll";

class PayrollService {
  List<Employee> getEmployees() => [];
  List<Payment> getPayments() => [];
  List<Payment> getPaymentsByEmployee(Employee e) => [];
  void addPayment(Employee employee, double amount, DateTime? timeStamp) {}
  void updateMonthlyStats(List<MonthlyStats> stats) {}
  void updateStatus(paymentStatus s) {}
  Future<bool> addEmployee(Employee e) async {
    print("$baseUrl/add-employee");
    var response = http.post(Uri.parse("$baseUrl/add-employee"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "is_active": true,
          "bonus": e.bonus,
          "base_salary": e.baseSalary,
          "name": e.name
        }));
    print("govinda");
    return response.then((value) {
      print(value.statusCode);
      return value.statusCode == HttpStatus.created;
    });
  }
}
