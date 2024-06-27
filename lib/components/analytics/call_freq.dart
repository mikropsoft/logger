import 'package:flutter/material.dart';
import 'package:logger/components/contact_log_freq.dart';
import 'package:logger/components/sized_text.dart';
import 'package:logger/utils/analytics_fns.dart';

class CallFreqTile extends StatelessWidget {
  final double spacing;
  final CallLogEntryWithFreq mostFrequent;

  const CallFreqTile(
      {super.key, required this.mostFrequent, this.spacing = 20.0});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedText(
          "Most Called Number",
          size: 20.0,
        ),
        SizedBox(
          height: spacing - 5,
        ),
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: const Color.fromARGB(250, 42, 40, 40),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ContactLogFreq(
            logDetails: mostFrequent.entry,
            count: mostFrequent.count,
          ),
        ),
        SizedBox(
          height: spacing,
        ),
      ],
    );
  }
}
