/// 异步支持
/// Dart 库中包含许多返回 Future 或 Stream 对象的函数.
/// 这些函数在设置完耗时任务（例如 I/O 曹组）后， 就立即返回了，不会等待耗任务完成。
/// 使用 async 和 await 关键字实现异步编程。 可以让你像编写同步代码一样实现异步操作。
///
/// 处理 Future
/// 可以通过下面两种方式，获得 Future 执行完成的结果：
/// 1、使用 async 和 await.
/// 2、使用 Future API
/// 使用 async 和 await 关键字的代码是异步的。 虽然看起来有点像同步代码
///

Future checkVersion() async {
  print("check Version ...");
  Future.delayed(Duration(seconds: 2)).then((v) {
    print("------ check -----");
  });
  print("check Version !!!");
}

void lookUpVersion1() async {
  print("check Version 1");

  /// await 会阻塞，checkVersion 同步执行完才会向下执行
  try {
    /// 要使用 await ， 代码必须在 异步函数（使用 async 标记的函数）中
    await checkVersion();
  } catch (e) {
    /// ...
  }
  print("check Version 2");
}

void lookUpVersion2() async {
  print("check Version 1");

  /// then 不会阻塞，直接向下执行
  checkVersion().then((v) {
    print("---- $v ---");
  });
  print("check Version 2");
}

/// 虽然异步函数可能会执行耗时的操作， 但它不会等待这些操作。
/// 相反，异步函数只有在遇到第一个 await 表达式（详情见）时才会执行。
///  也就是说，它返回一个 Future 对象， 仅在await表达式完成后才恢复执行。
String getVersion() => '1.0.0';

/// 如果函数没有返回有效值， 需要设置其返回类型为 Future<void>
Future<String> getVersionAsync() async => '1.0.0';

void test() {
  print(getVersion()); // 1.0.0
  print(getVersionAsync()); // Instance of 'Future<String>'
  getVersionAsync().then((v) {
    print("getVersionAsync: $v"); // getVersionAsync: 1.0.0
  });
}

void main() {
  //lookUpVersion1();
  //print("-------");
  //lookUpVersion2();

  test();
}
