import 'dart:convert';

class Employee {
  final String name;
  final double baseSalary;
  final double bonus;
  final String? id;
  final bool isActive;

  Employee(this.name, this.baseSalary, this.bonus, this.isActive, {this.id});
  Employee.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        baseSalary = json["base_salary"],
        bonus = json["bonus"],
        id = json["_id"],
        isActive = json["is_active"];

  String toJsonString() {
    return jsonEncode({
      "is_active": true,
      "bonus": bonus,
      "base_salary": baseSalary,
      "name": name
    });
  }
}
