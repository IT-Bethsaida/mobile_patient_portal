import 'package:flutter/material.dart';
import 'package:patient_portal/core/app_colors.dart';
import 'package:patient_portal/core/app_typography.dart';
import 'package:patient_portal/core/utils/toast_utils.dart';
import 'package:patient_portal/features/ai_assistant/widgets/chat_message_bubble.dart';
import 'package:patient_portal/features/ai_assistant/models/chat_message.dart';
import 'package:patient_portal/features/ai_assistant/services/chatbot_service.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AIChatPage extends StatefulWidget {
  const AIChatPage({super.key});

  @override
  State<AIChatPage> createState() => _AIChatPageState();
}

class _AIChatPageState extends State<AIChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  bool _isLoadingHistory = true;

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadChatHistory() async {
    setState(() {
      _isLoadingHistory = true;
    });

    try {
      final response = await ChatbotService.getHistory(limit: 50);

      if (mounted) {
        setState(() {
          _isLoadingHistory = false;

          if (response.success && response.data != null) {
            // Convert backend messages to ChatMessage
            final historyMessages = response.data!.messages.map((msg) {
              return ChatMessage(
                text: msg.content,
                isUser: msg.role == 'USER',
                timestamp: msg.createdAt,
              );
            }).toList();

            _messages.addAll(historyMessages);
          }

          // Add welcome message if no history
          if (_messages.isEmpty) {
            _messages.add(
              ChatMessage(
                text:
                    'Halo! Saya adalah asisten virtual **Bethsaida Hospital**. '
                    'Saya siap membantu Anda dengan informasi seputar:\n\n'
                    '• **Layanan rumah sakit**\n'
                    '• **Jadwal dokter**\n'
                    '• **Booking appointment**\n'
                    '• **Informasi umum**\n\n'
                    'Ada yang bisa saya bantu? 😊',
                isUser: false,
                timestamp: DateTime.now(),
              ),
            );
          }
        });

        _scrollToBottom();
      }
    } catch (e) {
      // Catch any exception and fallback to welcome message
      if (mounted) {
        setState(() {
          _isLoadingHistory = false;
          _messages.add(
            ChatMessage(
              text:
                  'Halo! Saya adalah asisten virtual **Bethsaida Hospital**. '
                  'Saya siap membantu Anda dengan informasi seputar:\n\n'
                  '• **Layanan rumah sakit**\n'
                  '• **Jadwal dokter**\n'
                  '• **Booking appointment**\n'
                  '• **Informasi umum**\n\n'
                  'Ada yang bisa saya bantu? 😊',
              isUser: false,
              timestamp: DateTime.now(),
            ),
          );
        });
      }
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Icon(LucideIcons.trash2, color: Colors.red),
                title: Text(
                  'Clear chat',
                  style: AppTypography.bodyLarge.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showClearChatConfirmation(context);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  void _showClearChatConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(LucideIcons.triangleAlert, color: Colors.orange, size: 24),
            const SizedBox(width: 12),
            Text(
              'Clear Chat',
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to clear all chat messages? This action cannot be undone.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.grey600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _clearChat();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Clear',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _clearChat() {
    setState(() {
      _messages.clear();
      // Add welcome message back
      _messages.add(
        ChatMessage(
          text:
              'Halo! Saya adalah asisten virtual **Bethsaida Hospital**. '
              'Saya siap membantu Anda dengan informasi seputar:\n\n'
              '• **Layanan rumah sakit**\n'
              '• **Jadwal dokter**\n'
              '• **Booking appointment**\n'
              '• **Informasi umum**\n\n'
              'Ada yang bisa saya bantu? 😊',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    });
    ToastUtils.showSuccess('Chat cleared successfully');
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    // Add user message
    setState(() {
      _messages.add(
        ChatMessage(text: text, isUser: true, timestamp: DateTime.now()),
      );
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // Send message to API
    final response = await ChatbotService.sendMessage(text);

    if (mounted) {
      setState(() {
        _isTyping = false;
        if (response.success && response.data != null) {
          _messages.add(
            ChatMessage(
              text: response.data!.content,
              isUser: false,
              timestamp: response.data!.createdAt,
            ),
          );
        } else {
          // Show error message
          ToastUtils.showError(response.message ?? 'Failed to get response');
          // Add fallback message
          _messages.add(
            ChatMessage(
              text:
                  'Sorry, I\'m having trouble connecting. Please try again later.',
              isUser: false,
              timestamp: DateTime.now(),
            ),
          );
        }
      });
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.grey900 : AppColors.grey100,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: AppColors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Assistant',
                  style: AppTypography.titleMedium.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Online',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.white.withValues(alpha: 0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.ellipsisVertical, color: AppColors.white),
            onPressed: () => _showOptionsMenu(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: _isLoadingHistory
                ? const Center(child: CircularProgressIndicator())
                : _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: AppColors.grey400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Start a conversation',
                          style: AppTypography.bodyLarge.copyWith(
                            color: AppColors.grey600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    physics: const ClampingScrollPhysics(),
                    itemCount: _messages.length + (_isTyping ? 1 : 0),
                    addAutomaticKeepAlives: true,
                    cacheExtent: 1000,
                    itemBuilder: (context, index) {
                      if (index == _messages.length && _isTyping) {
                        return ChatMessageBubble(
                          key: const ValueKey('typing'),
                          message: ChatMessage(
                            text: '',
                            isUser: false,
                            timestamp: DateTime.now(),
                          ),
                          isTyping: true,
                        );
                      }
                      return ChatMessageBubble(
                        key: ValueKey(_messages[index].timestamp.toString()),
                        message: _messages[index],
                      );
                    },
                  ),
          ),

          // Input Area
          Container(
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.grey800 : AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: MediaQuery.of(context).padding.bottom + 12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.grey700 : AppColors.grey100,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(
                          color: isDarkMode
                              ? AppColors.grey400
                              : AppColors.grey600,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      style: TextStyle(
                        color: isDarkMode ? AppColors.white : AppColors.black,
                      ),
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryDark],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(LucideIcons.send, color: AppColors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
