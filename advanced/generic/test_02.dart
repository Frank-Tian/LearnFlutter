class BaseResponse<T> {
  T extra;
  BaseResponse.fromJson(Map<String, dynamic> json) {
    extra = this.extraFromJson(json["extra"]);
  }

  // ignore: missing_return
  T extraFromJson(Map json) {
    UnimplementedError("implemented in subclass!");
  }

  // ignore: missing_return
  Map jsonFromExtra(T extra) {
    UnimplementedError("implemented in subclass!");
  }
}

class StartLiveResponse<T> extends BaseResponse<T> {
  int code;
  String message;
  StartLiveResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    code = json['Code'];
    message = json['Message'];
  }
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
      : super.fromJson(json) {}

  @override
  T extraFromJson(Map json) {
    return DemoStartExtra.fromJson(json) as T;
  }

  @override
  Map jsonFromExtra(T extra) {
    return super.jsonFromExtra(extra);
  }
}

void main() {
  final DemoStartLiveResponse<DemoStartExtra> s =
      DemoStartLiveResponse.fromJson({
    "extra": {"someKey": "2", "someNum": 12},
    "Code": 42,
    "Message": "World"
  });
  print(s.code);
  print(s.message);
  print("${s.extra.someKey} - type: ${s.extra.runtimeType}");
}
