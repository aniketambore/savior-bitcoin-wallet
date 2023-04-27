import 'package:flutter/material.dart';

import '../component_library.dart';

class BalanceFormatter extends StatelessWidget {
  const BalanceFormatter({
    super.key,
    required this.balance,
  });
  final int balance;

  @override
  Widget build(BuildContext context) {
    Map<String, List> formattedBalance = _formatBalance(balance);
    return _formattedText(formattedBalance);
  }

  Map<String, List> _formatBalance(int balance) {
    String result = '';
    String denomination = '';
    bool isBold = false;

    if (balance >= 100000000) {
      denomination = 'btc';
      result = (balance / 100000000).toStringAsFixed(2);
    } else {
      denomination = 'sats';
      result = (balance / 100000000.0).toStringAsFixed(8);
    }

    List<String> parts = result.split('.');
    String wholePart = parts[0];
    String lastPart = parts[1].padRight(8, '0');

    String formattedWholePart = _formatNumber(wholePart);
    String formattedLastPart = _formatNumber(lastPart, [2, 5]);

    result = '$formattedWholePart.$formattedLastPart $denomination';

    Map<String, List> resultToReturn = {};

    for (int i = 0; i < result.length; i++) {
      final element = int.tryParse(result[i]) ?? 0;
      if (element > 0) {
        isBold = true;
      }
      resultToReturn['$i'] = [result[i], isBold];
    }

    return resultToReturn;
  }

  String _formatNumber(String number, [List<int>? positions]) {
    String formattedNumber = '';
    for (int i = 0; i < number.length; i++) {
      if (positions != null && positions.contains(i)) {
        formattedNumber += ' ';
      }
      formattedNumber += number[i];
    }
    return formattedNumber;
  }

  Widget _formattedText(Map<String, List> input) {
    List<TextSpan> textSpans = [];
    Color color = santasGray10;

    for (final element in input.entries) {
      String character = element.value[0].toString();
      bool isBold = element.value[1];

      if (isBold) {
        color = woodSmoke;
      } else {
        color = santasGray10;
      }

      textSpans.add(
        TextSpan(
          text: character,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: FontSize.large,
            color: color,
          ),
        ),
      );
    }

    return Text.rich(TextSpan(children: textSpans));
  }
}
