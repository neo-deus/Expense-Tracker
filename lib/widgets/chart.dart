import './chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  // List<Map<String, Object>> get groupedTransactionvalues {
  //   return List.generate(7, (index) {
  //     final weekDay = DateTime.now().subtract(
  //       Duration(days: index),
  //     );
  //     double totalSum = 0.0;
  //     for (var i = 0; i < recentTransaction.length; i++) {
  //       if (recentTransaction[i].date.day == weekDay.day &&
  //           recentTransaction[i].date.month == weekDay.month &&
  //           recentTransaction[i].date.year == weekDay.year) {
  //         totalSum += recentTransaction[i].amount;
  //       }
  //     }
  //     print(DateFormat.E().format(weekDay));
  //     print(totalSum);

  //     return {
  //       'day': DateFormat.E().format(weekDay),
  //       'amount': totalSum,
  //     };
  //   }).reversed.toList();
  // }

  List<Map<String, Object>> get groupedTransactionvalues {
    final List<String> weekdays = [
      'Sun',
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
    ];
    final List<Map<String, Object>> transactionValues =
        List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    });
    transactionValues.sort((a, b) => weekdays
        .indexOf(a['day'] as String)
        .compareTo(weekdays.indexOf(b['day'] as String)));
    return transactionValues;
  }

  double get totalSpending {
    return groupedTransactionvalues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupedTransactionvalues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionvalues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                //the values to be passed are not fixed,i.e.,dynamic, hence we cannot make this ChartBar instance an const
                data['day'] as String,
                data['amount'] as double,
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
