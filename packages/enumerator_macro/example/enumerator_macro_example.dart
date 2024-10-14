// ignore_for_file: unused_local_variable

import 'package:enumerator_macro/enumerator_macro.dart';

// NOTE: Due to an issue with macros on Enum types this package
// is currently implemented using an enum-like class as a workaround.
// https://github.com/dart-lang/sdk/issues/56305

// Mock enum value.
class Value extends MyEnum {
  const Value(this.index);

  final int index;

  String get name => index.toString();
}

// Mock enum.
@Enumerator()
abstract class MyEnum {
  // enum value
  static const _self = one;

  // enum values
  static const one = Value(1);
  static const two = Value(2);
  static const three = Value(3);

  static final values = <Value>[one, two, three];
}

void main(List<String> args) {
  final myEnum = MyEnum.one;

  // Getters
  myEnum.isOne; // true
  myEnum.isTwo; // false
  myEnum.isThree; // false

  myEnum.isIn({MyEnum.one, MyEnum.two}); // true

  // Get enum from name
  final MyEnum one = MyEnum.fromName('one');
  final MyEnum? oneOrNull = MyEnum.fromNameOrNull('one');

  // Get enum from index
  final MyEnum two = MyEnum.fromIndex(1);
  final MyEnum? twoOrNull = MyEnum.fromIndexOrNull(2);
}
