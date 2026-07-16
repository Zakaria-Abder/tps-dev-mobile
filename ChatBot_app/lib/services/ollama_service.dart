import 'dart:convert';
import 'package:http/http.dart' as http;

class OllamaService {
  static const String baseUrl = "http://localhost:11434";

  Future<String> sendMessage(String prompt) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/generate"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "llama3.2",
        "prompt": prompt,
        "stream": false,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["response"];
    } else {
      throw Exception(response.body);
    }
  }
}