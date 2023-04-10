import 'dart:convert';

class RobotStatus {
  final String type;
  final int status;
  final String data;

  RobotStatus({required this.type, required this.status, required this.data});

  factory RobotStatus.fromJson(String jsonString) {
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return RobotStatus(
      type: jsonData['type'],
      status: int.parse("${jsonData['status'] ?? 0}"),
      data: jsonData['data'],
    );
  }
}