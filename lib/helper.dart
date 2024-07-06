enum paymentStatus { tbd, paid, calculated }

String paymentStatusStr(paymentStatus p) {
  if (p == paymentStatus.calculated) {
    return "CALCULATED";
  } else if (p == paymentStatus.tbd) {
    return "TBD";
  } else {
    return "PAID";
  }
}
