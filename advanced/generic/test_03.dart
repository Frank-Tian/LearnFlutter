class StartLiveResponse<T> {
  int code;
  String message;
  T extra;
  StartLiveResponse();

  void fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    message = json['Message'];
  }
}

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
  String a;

  @override
  void fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    this.extra = DemoStartExtra.fromJson(json["extra"]) as T;
  }
}

class API {
  Future<T> startLive<T extends StartLiveResponse>([T t]) async {
    Map<String, dynamic> result = {
      "Code": 1,
      "Message": "xxx",
      "extra": {"someKey": "2", "someNum": 12},
    };
    if (t == null) {
      t = StartLiveResponse<dynamic>() as T;
    }
    t.fromJson(result);
    return t;
  }
}

// example
void example() async {
  DemoStartLiveResponse<DemoStartExtra> res = await API()
      .startLive<DemoStartLiveResponse>(
          DemoStartLiveResponse<DemoStartExtra>());
  print(res.runtimeType);
  print(res.code);
  var key = res.extra.someKey;
  print(key);
}

void example1() async {
  var a = DemoStartLiveResponse<DemoStartExtra>();
  API().startLive<DemoStartLiveResponse<DemoStartExtra>>(a).then((value) {
    print(value.code);
    print(value.extra.someKey);
  });
}

void example2() async {
  API().startLive().then((value) {
    print(value.code);
  });
}

void example3() async {
  API().startLive(StartLiveResponse()).then((value) {
    print(value.code);
  });
}

void main() {
  example();
  example1();
  example2();
  example3();
}
