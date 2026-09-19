import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.trailingText,
    this.isDestructive = false,
    this.showSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? trailingText;
  final bool isDestructive;
  final bool showSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final VoidCallback? onTap;

  static const Color _accent = Color(0xFFFF5A36);
  static const Color _borderColor = Color(0x1AFFFFFF);

  @override
  Widget build(BuildContext context) {
    final Color titleColor = isDestructive ? _accent : Colors.white;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: _borderColor)),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18, color: _accent),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                  children: [
                    TextSpan(text: title),
                    if (trailingText != null)
                      TextSpan(
                        text: ' ($trailingText)',
                        style: const TextStyle(color: _accent),
                      ),
                  ],
                ),
              ),
            ),
            if (showSwitch)
              Switch(
                value: switchValue,
                onChanged: onSwitchChanged,
                activeColor: Colors.white,
                activeTrackColor: _accent,
              )
            else
              const Icon(Icons.chevron_right, color: Colors.white54, size: 22),
          ],
        ),
      ),
    );
  }
}