class Payment {
  final String id;
  final double amount;
  final DateTime timeStamp;
  final String payeeId;

  Payment(
      {required this.id,
      required this.amount,
      required this.timeStamp,
      required this.payeeId});
}
