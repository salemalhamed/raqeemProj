import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> askQuestion(String question) async {
  final url = Uri.parse('http://your_server_ip:8000/ask/');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'question': question}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("Response: ${data['response']}");
  } else {
    print("Failed to get response: ${response.statusCode}");
  }
}
