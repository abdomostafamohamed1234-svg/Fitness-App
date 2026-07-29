import 'package:flowery/config/l10n/translations/app_localizations.dart';
import 'package:flowery/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final AppLocalizations localizations;
  const ChatInputField({
    super.key,
    required this.controller,
    required this.localizations,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: localizations.fitness_hint_text,
                  hintStyle: TextStyle(
                    color: AppColors.lightGreyColor.withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // Send the text to the bot and firestore
              controller.clear();
            },
            icon: const Icon(Icons.send, color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
