class TermConditionModel {
  TermConditionModel({
      bool? success, 
      Data? data,}){
    _success = success;
    _data = data;
}

  TermConditionModel.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _success;
  Data? _data;
TermConditionModel copyWith({  bool? success,
  Data? data,
}) => TermConditionModel(  success: success ?? _success,
  data: data ?? _data,
);
  bool? get success => _success;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      String? title, 
      String? content, 
      List<Sections>? sections, 
      String? lastUpdated,}){
    _title = title;
    _content = content;
    _sections = sections;
    _lastUpdated = lastUpdated;
}

  Data.fromJson(dynamic json) {
    _title = json['title'];
    _content = json['content'];
    if (json['sections'] != null) {
      _sections = [];
      json['sections'].forEach((v) {
        _sections?.add(Sections.fromJson(v));
      });
    }
    _lastUpdated = json['last_updated'];
  }
  String? _title;
  String? _content;
  List<Sections>? _sections;
  String? _lastUpdated;
Data copyWith({  String? title,
  String? content,
  List<Sections>? sections,
  String? lastUpdated,
}) => Data(  title: title ?? _title,
  content: content ?? _content,
  sections: sections ?? _sections,
  lastUpdated: lastUpdated ?? _lastUpdated,
);
  String? get title => _title;
  String? get content => _content;
  List<Sections>? get sections => _sections;
  String? get lastUpdated => _lastUpdated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['content'] = _content;
    if (_sections != null) {
      map['sections'] = _sections?.map((v) => v.toJson()).toList();
    }
    map['last_updated'] = _lastUpdated;
    return map;
  }

}

class Sections {
  Sections({
      String? heading, 
      String? text,}){
    _heading = heading;
    _text = text;
}

  Sections.fromJson(dynamic json) {
    _heading = json['heading'];
    _text = json['text'];
  }
  String? _heading;
  String? _text;
Sections copyWith({  String? heading,
  String? text,
}) => Sections(  heading: heading ?? _heading,
  text: text ?? _text,
);
  String? get heading => _heading;
  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['heading'] = _heading;
    map['text'] = _text;
    return map;
  }

}