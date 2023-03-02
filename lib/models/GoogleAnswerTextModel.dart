import 'dart:convert';

import 'package:orionstar_robot/models/DetailModel.dart';
/// answerText : "I'll certainly try my best. How can I help?"
/// answerTextPlay : true
/// card : {"text":"I'll certainly try my best. How can I help?"}
/// englishDomain : "chat"
/// englishIntent : "chat"
/// intent : "chat&chat"
/// nlpData : {"detail":[{"agent":"third_nlp","semantics_flag":1,"query":"what you can do for me","asrText":"what you can do for me","source":"google_dialogflow_api","intent":"chat","english_domain":"chat","debug_info":{},"slots":{},"cmd_dispatch_level":"0","domain":"chat","skill_response":{"response":{"outSpeech":{"text":"I'll certainly try my best. How can I help?","type":"text"}}},"sn":"ec609f44-0e0f-402c-a55c-eedf342a2e7c","skill_nlu":true,"actions":[[{"args":{"text":"I'll certainly try my best. How can I help?"},"action":"action.system.tts.play_tts"}]],"current_time":"2023-02-28 09:56:40","nlpData":{"misc":{"app":[]}}}],"misc":{"app":[]}}
/// queryType : -1
/// sid : "ec609f44-0e0f-402c-a55c-eedf342a2e7c"
/// skillData : "{}"
/// slots : "{}"
/// soundAngle : -1
/// traceId : "ec609f440e0f402c"
/// userText : "what you can do for me"

GoogleAnswerTextModel googleAnswerTextModelFromJson(String str) => GoogleAnswerTextModel.fromJson(json.decode(str));
String googleAnswerTextModelToJson(GoogleAnswerTextModel data) => json.encode(data.toJson());
class GoogleAnswerTextModel {
  GoogleAnswerTextModel({
      String? answerText, 
      bool? answerTextPlay, 
      Card? card, 
      String? englishDomain, 
      String? englishIntent, 
      String? intent, 
      NlpData? nlpData, 
      num? queryType, 
      String? sid, 
      String? skillData, 
      String? slots, 
      num? soundAngle, 
      String? traceId, 
      String? userText,}){
    _answerText = answerText;
    _answerTextPlay = answerTextPlay;
    _card = card;
    _englishDomain = englishDomain;
    _englishIntent = englishIntent;
    _intent = intent;
    _nlpData = nlpData;
    _queryType = queryType;
    _sid = sid;
    _skillData = skillData;
    _slots = slots;
    _soundAngle = soundAngle;
    _traceId = traceId;
    _userText = userText;
}

  GoogleAnswerTextModel.fromJson(dynamic json) {
    _answerText = json['answerText'];
    _answerTextPlay = json['answerTextPlay'];
    _card = json['card'] != null ? Card.fromJson(jsonDecode(json['card'])) : null;
    _englishDomain = json['englishDomain'];
    _englishIntent = json['englishIntent'];
    _intent = json['intent'];
    _nlpData = json['nlpData'] != null ? NlpData.fromJson(jsonDecode(json['nlpData'])) : null;
    _queryType = json['queryType'];
    _sid = json['sid'];
    _skillData = json['skillData'];
    _slots = json['slots'];
    _soundAngle = json['soundAngle'];
    _traceId = json['traceId'];
    _userText = json['userText'];
  }
  String? _answerText;
  bool? _answerTextPlay;
  Card? _card;
  String? _englishDomain;
  String? _englishIntent;
  String? _intent;
  NlpData? _nlpData;
  num? _queryType;
  String? _sid;
  String? _skillData;
  String? _slots;
  num? _soundAngle;
  String? _traceId;
  String? _userText;
GoogleAnswerTextModel copyWith({  String? answerText,
  bool? answerTextPlay,
  Card? card,
  String? englishDomain,
  String? englishIntent,
  String? intent,
  NlpData? nlpData,
  num? queryType,
  String? sid,
  String? skillData,
  String? slots,
  num? soundAngle,
  String? traceId,
  String? userText,
}) => GoogleAnswerTextModel(  answerText: answerText ?? _answerText,
  answerTextPlay: answerTextPlay ?? _answerTextPlay,
  card: card ?? _card,
  englishDomain: englishDomain ?? _englishDomain,
  englishIntent: englishIntent ?? _englishIntent,
  intent: intent ?? _intent,
  nlpData: nlpData ?? _nlpData,
  queryType: queryType ?? _queryType,
  sid: sid ?? _sid,
  skillData: skillData ?? _skillData,
  slots: slots ?? _slots,
  soundAngle: soundAngle ?? _soundAngle,
  traceId: traceId ?? _traceId,
  userText: userText ?? _userText,
);
  String? get answerText => _answerText;
  bool? get answerTextPlay => _answerTextPlay;
  Card? get card => _card;
  String? get englishDomain => _englishDomain;
  String? get englishIntent => _englishIntent;
  String? get intent => _intent;
  NlpData? get nlpData => _nlpData;
  num? get queryType => _queryType;
  String? get sid => _sid;
  String? get skillData => _skillData;
  String? get slots => _slots;
  num? get soundAngle => _soundAngle;
  String? get traceId => _traceId;
  String? get userText => _userText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['answerText'] = _answerText;
    map['answerTextPlay'] = _answerTextPlay;
    if (_card != null) {
      map['card'] = _card?.toJson();
    }
    map['englishDomain'] = _englishDomain;
    map['englishIntent'] = _englishIntent;
    map['intent'] = _intent;
    if (_nlpData != null) {
      map['nlpData'] = _nlpData?.toJson();
    }
    map['queryType'] = _queryType;
    map['sid'] = _sid;
    map['skillData'] = _skillData;
    map['slots'] = _slots;
    map['soundAngle'] = _soundAngle;
    map['traceId'] = _traceId;
    map['userText'] = _userText;
    return map;
  }

}

/// detail : [{"agent":"third_nlp","semantics_flag":1,"query":"what you can do for me","asrText":"what you can do for me","source":"google_dialogflow_api","intent":"chat","english_domain":"chat","debug_info":{},"slots":{},"cmd_dispatch_level":"0","domain":"chat","skill_response":{"response":{"outSpeech":{"text":"I'll certainly try my best. How can I help?","type":"text"}}},"sn":"ec609f44-0e0f-402c-a55c-eedf342a2e7c","skill_nlu":true,"actions":[[{"args":{"text":"I'll certainly try my best. How can I help?"},"action":"action.system.tts.play_tts"}]],"current_time":"2023-02-28 09:56:40","nlpData":{"misc":{"app":[]}}}]
/// misc : {"app":[]}

NlpData nlpDataFromJson(String str) => NlpData.fromJson(json.decode(str));
String nlpDataToJson(NlpData data) => json.encode(data.toJson());
class NlpData {
  NlpData({
      List<Detail>? detail, 
      Misc? misc,}){
    _detail = detail;
    _misc = misc;
}

  NlpData.fromJson(dynamic json) {
    if (json['detail'] != null) {
      _detail = [];
      json['detail'].forEach((v) {
        _detail?.add(Detail.fromJson(v));
      });
    }
    _misc = json['misc'] != null ? Misc.fromJson(json['misc']) : null;
  }
  List<Detail>? _detail;
  Misc? _misc;
NlpData copyWith({  List<Detail>? detail,
  Misc? misc,
}) => NlpData(  detail: detail ?? _detail,
  misc: misc ?? _misc,
);
  List<Detail>? get detail => _detail;
  Misc? get misc => _misc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_detail != null) {
      map['detail'] = _detail?.map((v) => v.toJson()).toList();
    }
    if (_misc != null) {
      map['misc'] = _misc?.toJson();
    }
    return map;
  }

}

/// app : []

Misc miscFromJson(String str) => Misc.fromJson(json.decode(str));
String miscToJson(Misc data) => json.encode(data.toJson());
class Misc {
  Misc({
      List<dynamic>? app,}){
    _app = app;
}

  Misc.fromJson(dynamic json) {
    if (json['app'] != null) {
      _app = [];
      json['app'].forEach((v) {
        // _app?.add(Dynamic.fromJson(v));
      });
    }
  }
  List<dynamic>? _app;
Misc copyWith({  List<dynamic>? app,
}) => Misc(  app: app ?? _app,
);
  List<dynamic>? get app => _app;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_app != null) {
      map['app'] = _app?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}



/// app : []


/// args : {"text":"I'll certainly try my best. How can I help?"}
/// action : "action.system.tts.play_tts"

Actions actionsFromJson(String str) => Actions.fromJson(json.decode(str));
String actionsToJson(Actions data) => json.encode(data.toJson());
class Actions {
  Actions({
      Args? args, 
      String? action,}){
    _args = args;
    _action = action;
}

  Actions.fromJson(dynamic json) {
    _args = json['args'] != null ? Args.fromJson(json['args']) : null;
    _action = json['action'];
  }
  Args? _args;
  String? _action;
Actions copyWith({  Args? args,
  String? action,
}) => Actions(  args: args ?? _args,
  action: action ?? _action,
);
  Args? get args => _args;
  String? get action => _action;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_args != null) {
      map['args'] = _args?.toJson();
    }
    map['action'] = _action;
    return map;
  }

}

/// text : "I'll certainly try my best. How can I help?"

Args argsFromJson(String str) => Args.fromJson(json.decode(str));
String argsToJson(Args data) => json.encode(data.toJson());
class Args {
  Args({
      String? text,}){
    _text = text;
}

  Args.fromJson(dynamic json) {
    _text = json['text'];
  }
  String? _text;
Args copyWith({  String? text,
}) => Args(  text: text ?? _text,
);
  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    return map;
  }

}

/// response : {"outSpeech":{"text":"I'll certainly try my best. How can I help?","type":"text"}}

SkillResponse skillResponseFromJson(String str) => SkillResponse.fromJson(json.decode(str));
String skillResponseToJson(SkillResponse data) => json.encode(data.toJson());
class SkillResponse {
  SkillResponse({
      Response? response,}){
    _response = response;
}

  SkillResponse.fromJson(dynamic json) {
    _response = json['response'] != null ? Response.fromJson(json['response']) : null;
  }
  Response? _response;
SkillResponse copyWith({  Response? response,
}) => SkillResponse(  response: response ?? _response,
);
  Response? get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_response != null) {
      map['response'] = _response?.toJson();
    }
    return map;
  }

}

/// outSpeech : {"text":"I'll certainly try my best. How can I help?","type":"text"}

Response responseFromJson(String str) => Response.fromJson(json.decode(str));
String responseToJson(Response data) => json.encode(data.toJson());
class Response {
  Response({
      OutSpeech? outSpeech,}){
    _outSpeech = outSpeech;
}

  Response.fromJson(dynamic json) {
    _outSpeech = json['outSpeech'] != null ? OutSpeech.fromJson(json['outSpeech']) : null;
  }
  OutSpeech? _outSpeech;
Response copyWith({  OutSpeech? outSpeech,
}) => Response(  outSpeech: outSpeech ?? _outSpeech,
);
  OutSpeech? get outSpeech => _outSpeech;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_outSpeech != null) {
      map['outSpeech'] = _outSpeech?.toJson();
    }
    return map;
  }

}

/// text : "I'll certainly try my best. How can I help?"
/// type : "text"

OutSpeech outSpeechFromJson(String str) => OutSpeech.fromJson(json.decode(str));
String outSpeechToJson(OutSpeech data) => json.encode(data.toJson());
class OutSpeech {
  OutSpeech({
      String? text, 
      String? type,}){
    _text = text;
    _type = type;
}

  OutSpeech.fromJson(dynamic json) {
    _text = json['text'];
    _type = json['type'];
  }
  String? _text;
  String? _type;
OutSpeech copyWith({  String? text,
  String? type,
}) => OutSpeech(  text: text ?? _text,
  type: type ?? _type,
);
  String? get text => _text;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['type'] = _type;
    return map;
  }

}

/// text : "I'll certainly try my best. How can I help?"

Card cardFromJson(String str) => Card.fromJson(json.decode(str));
String cardToJson(Card data) => json.encode(data.toJson());
class Card {
  Card({
      String? text,}){
    _text = text;
}

  Card.fromJson(dynamic json) {
    _text = json['text'];
  }
  String? _text;
Card copyWith({  String? text,
}) => Card(  text: text ?? _text,
);
  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    return map;
  }

}