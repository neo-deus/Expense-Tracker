import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                'No transactions added yet!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 240,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            //ListView.builder used in place of ListView used in place of SinglChildScrollView+Column
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 8,
                ),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text('\$${transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                    onPressed: () => deleteTx(transactions[index].id),
                  ),
                ),
              );
              // return Card(
              //   child: Row(children: [
              //     Container(
              //       margin: EdgeInsets.symmetric(
              //         vertical: 10,
              //         horizontal: 15,
              //       ),
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           color: Theme.of(context).primaryColor,
              //           width: 2,
              //         ),
              //       ),
              //       padding: EdgeInsets.all(10),
              //       child: Text(
              //         '\$${transactions[index].amount.toStringAsFixed(1)}',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 20,
              //           fontFamily: 'Quicksand',
              //           color: Theme.of(context).primaryColor,
              //         ),
              //       ),
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           transactions[index].title,
              //           style: Theme.of(context).textTheme.titleMedium,
              //         ),
              //         Text(
              //           DateFormat.yMMMd().format(transactions[index].date),
              //           style: TextStyle(
              //             color: Colors.grey,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ]),
              // );
            },
            itemCount: transactions.length,
          );
  }
}
