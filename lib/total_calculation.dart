class TotalCalculator {
  double total = 0.0;

  void updateTotal(double price, bool isAdding) {
    if (isAdding) {
      total += price;
    } else {
      total -= price;
    }
  }
}
