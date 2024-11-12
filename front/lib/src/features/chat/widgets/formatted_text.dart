import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormattedText extends StatelessWidget {
  final String text;

  const FormattedText(this.text, {super.key});

  List<InlineSpan> _formatText(String text) {
    final List<InlineSpan> spans = [];
    final lines = text.split('*');  
    for (var line in lines) {
      final regex = RegExp(r'\*\*(.*?)\*\*');  
      final matches = regex.allMatches(line);
      int lastMatchEnd = 0;

      for (final match in matches) {
        if (match.start > lastMatchEnd) {
          spans.add(TextSpan(text: line.substring(lastMatchEnd, match.start)));
        }

        spans.add(
          TextSpan(
            text: match.group(1),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
        );
        lastMatchEnd = match.end;
      }

      if (lastMatchEnd < line.length) {
        spans.add(TextSpan(text: line.substring(lastMatchEnd)));
      }

      spans.add(const TextSpan(text: '\n'));
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.white,
          wordSpacing: 1.5,
          fontSize: 16,
          fontFamily: GoogleFonts.montserrat().fontFamily,
        ),
        children: _formatText(text),
      ),
    );
  }
}
