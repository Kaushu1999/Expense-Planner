import "./models/transaction.dart";
import "./widgets/new_transaction.dart";
import 'package:flutter/material.dart';
import "./widgets/transaction_list.dart";
import './widgets//chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Planner",
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            titleMedium: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            titleLarge: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white),
            labelLarge: const TextStyle(color: Colors.white)),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
        )),
      ),
      home: const MyHomePage(title: 'Expense Planner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

// this is our homepage widget

class MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransaction = [];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  bool _showChart = false;

  void _addNewTransaction(
      String newTitle, double newAmount, DateTime selectedDate) {
    final tx = Transaction(
        title: newTitle,
        amount: newAmount,
        date: selectedDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransaction.add(tx);
    });
  }

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> _buildLandscape(
      MediaQueryData mediaQuery, AppBar appBar, txList) {
    return [
      Row(
        children: <Widget>[
          Text(_showChart ? "Hide List" : "Show List"),
          Switch.adaptive(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? SizedBox(
              height:
                  (mediaQuery.size.height - appBar.preferredSize.height) * 0.7,
              child: Chart(_recentTransactions),
            )
          : Container(
              child: txList,
            ),
    ];
  }

  List<Widget> _buildPortriat(
      MediaQueryData mediaQuery, AppBar appBar, txList) {
    return [
      SizedBox(
        height: (mediaQuery.size.height - appBar.preferredSize.height) * 0.3,
        child: Chart(_recentTransactions),
      ),
      txList,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actions: [
        IconButton(
            onPressed: () {
              startAddNewTransaction(context);
            },
            icon: const Icon(
              Icons.add,
            ))
      ],
    );

// this is transaction list widget of homepage
    final txList = Container(
        child: _userTransaction.isEmpty
            ? SizedBox(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.70,
                child: Column(
                  children: [
                    Text(
                      "No Transaction Added yet ! ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Image.asset("assets/images/No-data-pana.png",
                            fit: BoxFit.cover),
                      ),
                    )
                  ],
                ),
              )
            : SizedBox(
                height: (mediaQuery.size.height - appBar.preferredSize.height) *
                    0.70,
                child: TransactionList(_userTransaction, _deleteTransaction),
              ));

    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandScape) ..._buildLandscape(mediaQuery, appBar, txList),
            if (!isLandScape) ..._buildPortriat(mediaQuery, appBar, txList),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startAddNewTransaction(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
