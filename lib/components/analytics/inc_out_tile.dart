import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logger/components/analytics/indicator.dart';
import 'package:logger/components/sized_text.dart';
import 'package:logger/utils/utils.dart';

class IncomingVsOutgoingTile extends StatelessWidget {
  final double spacing;
  final int incomingCallsCount, outgoingCallsCount;
  const IncomingVsOutgoingTile({
    super.key,
    required this.incomingCallsCount,
    required this.outgoingCallsCount,
    this.spacing = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    if (incomingCallsCount == 0 && outgoingCallsCount == 0) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedText(
          "Call Direction Analysis",
          size: 20.0,
        ),
        SizedBox(
          height: spacing - 5,
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(250, 42, 40, 40),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Indicator(
                    text: 'Outgoing',
                    color: Colors.red,
                    isSquare: false,
                    size: 16,
                    textColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  Indicator(
                    color: Colors.blue,
                    text: 'Incoming',
                    isSquare: false,
                    size: 16,
                    textColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              AspectRatio(
                aspectRatio: 1.3,
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        prettifyNumbers(
                            incomingCallsCount + outgoingCallsCount),
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ),
                    PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            value: incomingCallsCount.toDouble(),
                            title: prettifyNumbers(incomingCallsCount),
                            color: Colors.blue,
                          ),
                          PieChartSectionData(
                            value: outgoingCallsCount.toDouble(),
                            title: prettifyNumbers(outgoingCallsCount),
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: spacing,
        ),
      ],
    );
  }
}
