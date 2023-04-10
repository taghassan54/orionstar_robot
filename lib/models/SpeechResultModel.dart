import 'dart:convert';

class ChatData {
  final String answerText;
  final bool answerTextPlay;
  final dynamic card;
  final String englishDomain;
  final String englishIntent;
  final String intent;
  final dynamic nlpData;
  final int queryType;
  final String sid;
  final dynamic slots;
  final int soundAngle;
  final String traceId;
  final String userText;

  ChatData({
    required this.answerText,
    required this.answerTextPlay,
    required this.card,
    required this.englishDomain,
    required this.englishIntent,
    required this.intent,
    required this.nlpData,
    required this.queryType,
    required this.sid,
    required this.slots,
    required this.soundAngle,
    required this.traceId,
    required this.userText,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      answerText: json['answerText'],
      answerTextPlay: json['answerTextPlay'],
      card: jsonDecode(json['card']),
      englishDomain: json['englishDomain'],
      englishIntent: json['englishIntent'],
      intent: json['intent'],
      nlpData: jsonDecode(json['nlpData']),
      queryType: json['queryType'],
      sid: json['sid'],
      slots: jsonDecode(json['slots']),
      soundAngle: json['soundAngle'],
      traceId: json['traceId'],
      userText: json['userText'],
    );
  }
}
