import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../utils/get_text_size.dart';

class GameScore extends HookWidget {
  const GameScore({super.key, required this.score, this.size = 16});

  final double score;
  final int size;

  @override
  Widget build(BuildContext context) {
    final scoreInPercent = (score / 5) * 100;

    Color scoreColor = Colors.green;
    if (scoreInPercent < 60) scoreColor = Colors.orange;
    if (scoreInPercent < 40) scoreColor = Colors.red;
    // final textWidth = getTextSize(score.toString(), TextStyle(fontSize: size.toDouble())).width;
    final textWidth = useState(0.0);
    useEffect(() {
      textWidth.value = getTextSize(score.toString(), TextStyle(fontSize: size.toDouble())).width;
      return () {};
    }, [score, size]);
    final verticalSpacing = size * 0.3;
    final horizontalSpacing = size * 0.6;
    final iconSize = size * 1.2;
    // +7 for some buffer incase of overflow
    final wholeBoxSize = textWidth.value + iconSize + horizontalSpacing + horizontalSpacing + horizontalSpacing + 7;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalSpacing, vertical: verticalSpacing),
      decoration: BoxDecoration(
        color: scoreColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scoreColor.withValues(alpha: 0.5)),
      ),
      width: wholeBoxSize,

      child: Row(
        children: [
          Icon(Icons.star, color: scoreColor, size: iconSize),
          SizedBox(width: horizontalSpacing),
          Text(
            score.toString(),
            style: TextStyle(color: scoreColor, fontWeight: FontWeight.bold, fontSize: size.toDouble()),
          ),
        ],
      ),
    );
  }
}
