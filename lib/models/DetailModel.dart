import 'dart:convert';
/// sn : "writing_f19a6f3a-bfb3-4149-8bde-c58b6f1f121d"
/// query : "take me to Amody"
/// asrText : "take me to Amody"
/// english_domain : "guide"
/// domain : "guide"
/// intent : "guide"
/// slots : {"destination":[{"slot_id":0,"slot_type":"NORMAL","text":"Amody","value":"Amody","dict_name":"UNKNOWN"}]}
/// source : "google_dialogflow_api"
/// skill_response : {"version":"1.0.1","response":{}}
/// skill_nlu : true
/// current_time : "2023-03-02 09:41:05"
/// semantics_flag : 1
/// debug_info : {}
/// nlpData : {"misc":{}}
/// cmd_dispatch_level : "0"
/// agent : "third_nlp"

Detail detailModelFromJson(String str) => Detail.fromJson(json.decode(str));
String detailModelToJson(Detail data) => json.encode(data.toJson());
class Detail {
  Detail({
      String? sn, 
      String? query, 
      String? asrText, 
      String? englishDomain, 
      String? domain, 
      String? intent, 
      Slots? slots, 
      String? source, 
      SkillResponse? skillResponse, 
      bool? skillNlu, 
      String? currentTime, 
      num? semanticsFlag, 
      dynamic debugInfo, 
      NlpData? nlpData, 
      String? cmdDispatchLevel, 
      String? agent,}){
    _sn = sn;
    _query = query;
    _asrText = asrText;
    _englishDomain = englishDomain;
    _domain = domain;
    _intent = intent;
    _slots = slots;
    _source = source;
    _skillResponse = skillResponse;
    _skillNlu = skillNlu;
    _currentTime = currentTime;
    _semanticsFlag = semanticsFlag;
    _debugInfo = debugInfo;
    _nlpData = nlpData;
    _cmdDispatchLevel = cmdDispatchLevel;
    _agent = agent;
}

  Detail.fromJson(dynamic json) {
    _sn = json['sn'];
    _query = json['query'];
    _asrText = json['asrText'];
    _englishDomain = json['english_domain'];
    _domain = json['domain'];
    _intent = json['intent'];
    _slots = json['slots'] != null ? Slots.fromJson(json['slots']) : null;
    _source = json['source'];
    _skillResponse = json['skill_response'] != null ? SkillResponse.fromJson(json['skill_response']) : null;
    _skillNlu = json['skill_nlu'];
    _currentTime = json['current_time'];
    _semanticsFlag = json['semantics_flag'];
    _debugInfo = json['debug_info'];
    _nlpData = json['nlpData'] != null ? NlpData.fromJson(json['nlpData']) : null;
    _cmdDispatchLevel = json['cmd_dispatch_level'];
    _agent = json['agent'];
  }
  String? _sn;
  String? _query;
  String? _asrText;
  String? _englishDomain;
  String? _domain;
  String? _intent;
  Slots? _slots;
  String? _source;
  SkillResponse? _skillResponse;
  bool? _skillNlu;
  String? _currentTime;
  num? _semanticsFlag;
  dynamic _debugInfo;
  NlpData? _nlpData;
  String? _cmdDispatchLevel;
  String? _agent;
Detail copyWith({  String? sn,
  String? query,
  String? asrText,
  String? englishDomain,
  String? domain,
  String? intent,
  Slots? slots,
  String? source,
  SkillResponse? skillResponse,
  bool? skillNlu,
  String? currentTime,
  num? semanticsFlag,
  dynamic debugInfo,
  NlpData? nlpData,
  String? cmdDispatchLevel,
  String? agent,
}) => Detail(  sn: sn ?? _sn,
  query: query ?? _query,
  asrText: asrText ?? _asrText,
  englishDomain: englishDomain ?? _englishDomain,
  domain: domain ?? _domain,
  intent: intent ?? _intent,
  slots: slots ?? _slots,
  source: source ?? _source,
  skillResponse: skillResponse ?? _skillResponse,
  skillNlu: skillNlu ?? _skillNlu,
  currentTime: currentTime ?? _currentTime,
  semanticsFlag: semanticsFlag ?? _semanticsFlag,
  debugInfo: debugInfo ?? _debugInfo,
  nlpData: nlpData ?? _nlpData,
  cmdDispatchLevel: cmdDispatchLevel ?? _cmdDispatchLevel,
  agent: agent ?? _agent,
);
  String? get sn => _sn;
  String? get query => _query;
  String? get asrText => _asrText;
  String? get englishDomain => _englishDomain;
  String? get domain => _domain;
  String? get intent => _intent;
  Slots? get slots => _slots;
  String? get source => _source;
  SkillResponse? get skillResponse => _skillResponse;
  bool? get skillNlu => _skillNlu;
  String? get currentTime => _currentTime;
  num? get semanticsFlag => _semanticsFlag;
  dynamic get debugInfo => _debugInfo;
  NlpData? get nlpData => _nlpData;
  String? get cmdDispatchLevel => _cmdDispatchLevel;
  String? get agent => _agent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sn'] = _sn;
    map['query'] = _query;
    map['asrText'] = _asrText;
    map['english_domain'] = _englishDomain;
    map['domain'] = _domain;
    map['intent'] = _intent;
    if (_slots != null) {
      map['slots'] = _slots?.toJson();
    }
    map['source'] = _source;
    if (_skillResponse != null) {
      map['skill_response'] = _skillResponse?.toJson();
    }
    map['skill_nlu'] = _skillNlu;
    map['current_time'] = _currentTime;
    map['semantics_flag'] = _semanticsFlag;
    map['debug_info'] = _debugInfo;
    if (_nlpData != null) {
      map['nlpData'] = _nlpData?.toJson();
    }
    map['cmd_dispatch_level'] = _cmdDispatchLevel;
    map['agent'] = _agent;
    return map;
  }

}

/// misc : {}

NlpData nlpDataFromJson(String str) => NlpData.fromJson(json.decode(str));
String nlpDataToJson(NlpData data) => json.encode(data.toJson());
class NlpData {
  NlpData({
      dynamic misc,}){
    _misc = misc;
}

  NlpData.fromJson(dynamic json) {
    _misc = json['misc'];
  }
  dynamic _misc;
NlpData copyWith({  dynamic misc,
}) => NlpData(  misc: misc ?? _misc,
);
  dynamic get misc => _misc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['misc'] = _misc;
    return map;
  }

}

/// version : "1.0.1"
/// response : {}

SkillResponse skillResponseFromJson(String str) => SkillResponse.fromJson(json.decode(str));
String skillResponseToJson(SkillResponse data) => json.encode(data.toJson());
class SkillResponse {
  SkillResponse({
      String? version, 
      dynamic response,}){
    _version = version;
    _response = response;
}

  SkillResponse.fromJson(dynamic json) {
    _version = json['version'];
    _response = json['response'];
  }
  String? _version;
  dynamic _response;
SkillResponse copyWith({  String? version,
  dynamic response,
}) => SkillResponse(  version: version ?? _version,
  response: response ?? _response,
);
  String? get version => _version;
  dynamic get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = _version;
    map['response'] = _response;
    return map;
  }

}

/// destination : [{"slot_id":0,"slot_type":"NORMAL","text":"Amody","value":"Amody","dict_name":"UNKNOWN"}]

Slots slotsFromJson(String str) => Slots.fromJson(json.decode(str));
String slotsToJson(Slots data) => json.encode(data.toJson());
class Slots {
  Slots({
      List<Destination>? destination,}){
    _destination = destination;
}

  Slots.fromJson(dynamic json) {
    if (json['destination'] != null) {
      _destination = [];
      json['destination'].forEach((v) {
        _destination?.add(Destination.fromJson(v));
      });
    }
  }
  List<Destination>? _destination;
Slots copyWith({  List<Destination>? destination,
}) => Slots(  destination: destination ?? _destination,
);
  List<Destination>? get destination => _destination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_destination != null) {
      map['destination'] = _destination?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// slot_id : 0
/// slot_type : "NORMAL"
/// text : "Amody"
/// value : "Amody"
/// dict_name : "UNKNOWN"

Destination destinationFromJson(String str) => Destination.fromJson(json.decode(str));
String destinationToJson(Destination data) => json.encode(data.toJson());
class Destination {
  Destination({
      num? slotId, 
      String? slotType, 
      String? text, 
      String? value, 
      String? dictName,}){
    _slotId = slotId;
    _slotType = slotType;
    _text = text;
    _value = value;
    _dictName = dictName;
}

  Destination.fromJson(dynamic json) {
    _slotId = json['slot_id'];
    _slotType = json['slot_type'];
    _text = json['text'];
    _value = json['value'];
    _dictName = json['dict_name'];
  }
  num? _slotId;
  String? _slotType;
  String? _text;
  String? _value;
  String? _dictName;
Destination copyWith({  num? slotId,
  String? slotType,
  String? text,
  String? value,
  String? dictName,
}) => Destination(  slotId: slotId ?? _slotId,
  slotType: slotType ?? _slotType,
  text: text ?? _text,
  value: value ?? _value,
  dictName: dictName ?? _dictName,
);
  num? get slotId => _slotId;
  String? get slotType => _slotType;
  String? get text => _text;
  String? get value => _value;
  String? get dictName => _dictName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slot_id'] = _slotId;
    map['slot_type'] = _slotType;
    map['text'] = _text;
    map['value'] = _value;
    map['dict_name'] = _dictName;
    return map;
  }

}