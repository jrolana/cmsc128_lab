import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:cmsc128_lab/utils/styles.dart';
import 'package:confetti/confetti.dart';

class Streaks extends StatefulWidget {
  const Streaks({
    super.key,
  });

  @override
  State<Streaks> createState() => _StreaksState();
}

class _StreaksState extends State<Streaks> {
  late ConfettiController _controller;
  late int _days;
  late String _phrase;
  final int _index = DateTime.now().day % 10;

  final List<String> _congratulatoryPhrases = [
    "You’re on fire! Keep that streak going! 🔥",
    "Way to go! Consistency is paying off! 💪",
    "Streaks don’t lie—you're crushing it! 🎉",
    "Look at you go! Progress in motion! 🚀",
    "Impressive streak! You’re unstoppable! 🙌",
    "Wow, that’s a streak to be proud of! Keep up the awesome work! 🌟",
    "Streak + progress = success! Keep it up! 💥",
    "You’re building habits like a pro! Keep going! 👏",
    "Your dedication is showing—amazing work! 💯",
    "Another day, another win! Keep that streak alive! 🏆"
  ];

  final List<String> _upliftingPhrases = [
    "A streak may take time, but you're building something real! 🌱",
    "It’s okay to stumble. Just get back on track and keep moving forward! 💫",
    "Every day counts. You’re making progress, no matter the pace. 💪",
    "A setback is just a setup for a comeback—keep going! 💥",
    "Don’t worry about perfection, just focus on progress. You’ve got this! ✨",
    "You’re doing better than you think. Every step counts! 👣",
    "Growth happens one day at a time. Keep going, you're moving forward! 🌟",
    "Rome wasn’t built in a day, and neither are streaks! You’re on the right track! 🔨",
    "It’s not about the streak; it’s about the effort. Keep showing up! 💪",
    "Each day is a new opportunity. Keep building your momentum! 💫"
  ];

  @override
  void initState() {
    _controller = ConfettiController(duration: const Duration(seconds: 10));
    _days = getDays();

    _phrase = _upliftingPhrases[_index];

    if (_days > 0) {
      _phrase = _congratulatoryPhrases[_index];
    }

    super.initState();
  }

  int getDays() {
    return 7;
  }

  @override
  Widget build(BuildContext context) {
    _controller.play();

    return ConfettiWidget(
      confettiController: _controller,
      blastDirectionality: BlastDirectionality.explosive,
      shouldLoop: false,
      colors: const [
        StyleColor.secondary,
        StyleColor.tertiary,
        StyleColor.accentYellow,
        StyleColor.accentPink,
      ],
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.fromLTRB(40, 35, 40, 35),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$_days",
                      style: TextStyle(
                        fontSize: 75,
                        fontWeight: FontWeight.w700,
                        color: StyleColor.primary,
                        fontFamily: GoogleFonts.lexendDeca().fontFamily,
                      ),
                    ),
                    Text(
                      "Streak days",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: StyleColor.primary,
                        fontFamily: GoogleFonts.lexendDeca().fontFamily,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  IconlyBold.heart,
                  size: 75,
                  color: StyleColor.primary,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _phrase,
              style: TextStyle(
                fontFamily: GoogleFonts.lexendDeca().fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
