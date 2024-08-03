import 'dart:convert';
import 'dart:html';

import 'package:psh_finance/helper.dart';
import 'package:psh_finance/models/employee.dart';
import 'package:psh_finance/models/monthly_stats.dart';

import '../models/payment.dart';
import 'package:http/http.dart' as http;

String baseUrl = "http://127.0.0.1:3000/payroll";

class CustomResponse {
  final dynamic data;
  final bool success;
  final String message;

  CustomResponse({this.data, required this.success, required this.message});
  CustomResponse.error()
      : success = false,
        message = "something went wrong",
        data = Null;
}

class PayrollService {
  Future<http.Response> getRequest(String url) {
    return http.get(Uri.parse("$baseUrl/$url"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
  }

  Future<http.Response> postRequest(String url, Map<String, dynamic> payload) {
    return http.post(Uri.parse("$baseUrl/$url"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(payload));
  }

  Future<CustomResponse> getEmployees() async {
    try {
      var response = await getRequest("employees");
      var data = jsonDecode(response.body);

      return response.statusCode == HttpStatus.ok
          ? CustomResponse(
              data:
                  List.generate(data.length, (i) => Employee.fromJson(data[i])),
              success: true,
              message: "")
          : CustomResponse(success: false, message: "");
    } catch (e) {
      print(e);
      return CustomResponse.error();
    }
  }

  List<Payment> getPayments() => [];
  List<Payment> getPaymentsByEmployee(Employee e) => [];

  String _formatDateTime(DateTime t) {
    return "${t.toString().split('.')[0].replaceAll(RegExp(r' '), "T")}Z";
  }

  Future<CustomResponse> addPayment(Payment p) async {
    try {
      var response = http.post(Uri.parse("$baseUrl/add-payment"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "amount": p.amount,
            "time_stamp": _formatDateTime(p.timeStamp),
            "payee": {
              "name": p.payee.name,
              "base_salary": p.payee.baseSalary,
              "bonus": p.payee.bonus
            },
          }));

      return response.then((value) {
        print(value.body);
        return CustomResponse(
            data: Null,
            success: value.statusCode == 201,
            message: jsonDecode(value.body)["msg"]);
      });
    } catch (e) {
      print(e);
      return CustomResponse(
          data: Null, success: false, message: "something went wrong");
    }
  }

  void updateMonthlyStats(List<MonthlyStats> stats) {}
  void updateStatus(paymentStatus s) {}
  Future<CustomResponse> addEmployee(Employee e) async {
    try {
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
      return response.then((value) {
        return CustomResponse(
            data: Null, success: value.statusCode == 201, message: "");
      });
    } catch (e) {
      return CustomResponse(
          data: Null, success: false, message: "something went wrong");
    }
  }
}
