import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/features/ai_assistant/models/chat_message.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isTyping;

  const ChatMessageBubble({
    super.key,
    required this.message,
    this.isTyping = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            // AI Avatar
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: AppColors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
          ],
          // Message Bubble
          Flexible(
            child: Column(
              crossAxisAlignment: message.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: message.isUser
                        ? AppColors.primary
                        : (isDarkMode ? AppColors.grey800 : AppColors.white),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(message.isUser ? 20 : 4),
                      bottomRight: Radius.circular(message.isUser ? 4 : 20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: isTyping
                      ? _buildTypingIndicator()
                      : message.isUser
                      ? Text(
                          message.text,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.white,
                            height: 1.4,
                          ),
                        )
                      : MarkdownBody(
                          data: message.text,
                          shrinkWrap: true,
                          fitContent: true,
                          styleSheet: MarkdownStyleSheet(
                            p: AppTypography.bodyMedium.copyWith(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              height: 1.4,
                            ),
                            strong: AppTypography.bodyMedium.copyWith(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                            em: AppTypography.bodyMedium.copyWith(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              fontStyle: FontStyle.italic,
                              height: 1.4,
                            ),
                            code: AppTypography.bodyMedium.copyWith(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                              backgroundColor: isDarkMode
                                  ? AppColors.grey700
                                  : AppColors.grey200,
                              fontFamily: 'monospace',
                            ),
                            listBullet: AppTypography.bodyMedium.copyWith(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.black,
                            ),
                          ),
                          selectable: true,
                        ),
                ),
                const SizedBox(height: 4),
                if (!isTyping)
                  Text(
                    DateFormat('HH:mm').format(message.timestamp),
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.grey500,
                      fontSize: 11,
                    ),
                  ),
              ],
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            // User Avatar
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.grey300,
                shape: BoxShape.circle,
              ),
              child: Icon(LucideIcons.user, color: AppColors.grey600, size: 18),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TypingDot(delay: 0),
        const SizedBox(width: 4),
        _TypingDot(delay: 200),
        const SizedBox(width: 4),
        _TypingDot(delay: 400),
      ],
    );
  }
}

class _TypingDot extends StatefulWidget {
  final int delay;

  const _TypingDot({required this.delay});

  @override
  State<_TypingDot> createState() => _TypingDotState();
}

class _TypingDotState extends State<_TypingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.grey400.withValues(
              alpha: 0.3 + (_animation.value * 0.7),
            ),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
