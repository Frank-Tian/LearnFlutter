class BaseResponse<T> {
  T extra;
}

class StartLiveResponse<T> extends BaseResponse<T> {
  int code;
  String message;
  StartLiveResponse.fromJson(Map<String, dynamic> json)
      : code = json['Code'],
        message = json['Message'];
}

////////////////////////////////////////////////////////////
/// Example
////////////////////////////////////////////////////////////

class DemoStartExtra {
  String someKey;
  num someNum;

  DemoStartExtra({this.someKey, this.someNum});
  factory DemoStartExtra.fromJson(Map<String, dynamic> json) {
    return DemoStartExtra(
      someNum: json['someNum'] as num,
      someKey: json['someKey'] as String,
    );
  }
}

class DemoStartLiveResponse<T> extends StartLiveResponse<T> {
  DemoStartLiveResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    this.extra = DemoStartExtra.fromJson(json["extra"]) as T;
  }
}

void main() {
  final DemoStartLiveResponse<DemoStartExtra> s =
      DemoStartLiveResponse.fromJson({
    "extra": {"someKey": "2", "someNum": 12},
    "Code": 42,
    "Message": "World",
  });
  print(s.code);
  print(s.message);
  print("${s.extra.someKey} - type: ${s.extra.runtimeType}");
}
