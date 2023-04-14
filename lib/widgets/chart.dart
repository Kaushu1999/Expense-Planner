import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "./chart_bar.dart";

class Chart extends StatelessWidget {
  final List recentTransactions;

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "Amount": totalAmount
      };
    });
  }

  double get totalSpending {
    return groupTransactionValues.fold(0.0, (sum, current) {
      return sum + (current["Amount"] as double);
    });
  }

  const Chart(this.recentTransactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: const Color.fromARGB(255, 255, 106, 96),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupTransactionValues.map((data) {
              return ChartBar(
                  data["day"].toString(),
                  data["Amount"] as double,
                  totalSpending == 0.0
                      ? 0.0
                      : (data["Amount"] as double) / totalSpending);
            }).toList()),
      ),
    );
  }
}
