import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../services/ollama_service.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];

  final OllamaService _ollama = OllamaService();

  List<ChatMessage> get messages => _messages;

  bool _loading = false;

  bool get loading => _loading;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    _messages.add(
      ChatMessage(
        text: text,
        isUser: true,
      ),
    );

    _loading = true;
    notifyListeners();

    try {
      final answer = await _ollama.sendMessage(text);

      _messages.add(
        ChatMessage(
          text: answer,
          isUser: false,
        ),
      );
    } catch (e) {
      _messages.add(
        ChatMessage(
          text: "Erreur : $e",
          isUser: false,
        ),
      );
    }

    _loading = false;
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}