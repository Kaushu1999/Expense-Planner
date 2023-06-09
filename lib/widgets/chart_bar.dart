import "package:flutter/material.dart";

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctTotal;
  const ChartBar(this.label, this.spendingAmount, this.spendingPctTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: constraints.maxHeight * 0.15,
                  child: FittedBox(
                      child: Text('\$ ${spendingAmount.toStringAsFixed(0)}'))),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.60,
                width: 10,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          color: const Color.fromRGBO(220, 220, 220, 1),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    FractionallySizedBox(
                      heightFactor: spendingPctTotal,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              SizedBox(
                  height: constraints.maxHeight * 0.15,
                  child: FittedBox(child: Text(label))),
            ],
          ),
        );
      },
    );
  }
}
