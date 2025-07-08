import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'index_provider.g.dart';

// @riverpod
// class Index extends _$Index {
//   @override
//   FutureOr<int?> build() {
//     return Future.value(null);
//   }

//   Future<void> setIndex(int index) async {
//     state = await AsyncValue.guard(() async {
//       return index;
//     });
//   }

//   Future<void> clearIndex() async {
//     state = await AsyncValue.guard(() async {
//       return null;
//     });
//   }
// }

@riverpod
class Index extends _$Index {
  @override
  int? build() {
    return null;
  }

  void setIndex(int? index) {
    state = index;
  }

  void clearIndex() {
    state = null;
  }
}
