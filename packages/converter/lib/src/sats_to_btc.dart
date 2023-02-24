extension SatsToBTC on int {
  String toBTC() {
    double btcAmount = this / 100000000;
    return btcAmount.toStringAsFixed(8);
  }
}
