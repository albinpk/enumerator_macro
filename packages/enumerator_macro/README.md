# Enumerator Macro for `enum`

The `Enumerator` macro simplifies working with Dart enums by automatically generating useful methods such as enum value getters, utility methods for name and index lookups, and more.

With `Enumerator`, you can:

- Automatically create getters for each enum value (prefixed with `is`).
- Easily check if an enum value is part of a set of values.
- Get enum values from their string names or integer indices.

> **Note**:
> This package uses Dart's [macros](https://dart.dev/language/macros) (currently in beta), which injects code at compile time, making your enums more powerful and easier to work with.

## Features

When you annotate your enum with `@Enumerator`, the following methods are generated:

1. **Getters for Each Enum Value**: Getters are created dynamically for all enum values, prefixed with `is`. For example, if your enum contains a value called `something`, a getter `isSomething` will be generated.
2. **`isIn` Method**: Check if an enum value exists in a set of enum values.
3. **`fromName` and `fromNameOrNull`**: Get enum values from their string names.
4. **`fromIndex` and `fromIndexOrNull`**: Get enum values by their index.

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  enumerator_macro: ^0.0.1-dev.1
```

**Note**: Make sure to use a Dart SDK version that supports macros in beta.

Then, run:

```bash
dart pub get
```

## Usage

### 1. Annotate Your Enum with `@Enumerator`

To use the macro, simply annotate your enum with `@Enumerator`:

```dart
import 'package:enumerator_macro/enumerator_macro.dart';

@Enumerator()
enum MyEnum {
  one,
  two,
  something;
}
```

### 2. Generated Methods

By adding `@Enumerator`, the following methods and properties will automatically be available in your enum:

#### Getters

For each enum value, a corresponding getter is generated. The getter is prefixed with `is`:

```dart
void main() {
  final myEnum = MyEnum.one;

  print(myEnum.isOne);       // true
  print(myEnum.isTwo);       // false
  print(myEnum.isSomething); // false
}
```

#### `isIn` Method

You can check if an enum value exists in a set of other enum values:

```dart
void main() {
  final myEnum = MyEnum.one;

  print(myEnum.isIn({MyEnum.one, MyEnum.two})); // true
  print(myEnum.isIn({MyEnum.two, MyEnum.something})); // false
}
```

#### `fromName` and `fromNameOrNull`

You can get enum values from their string names:

```dart
void main() {
  final myEnum = MyEnum.fromName('one');
  print(myEnum); // MyEnum.one

  final myEnumOrNull = MyEnum.fromNameOrNull('unknown');
  print(myEnumOrNull); // null
}
```

#### `fromIndex` and `fromIndexOrNull`

You can also get enum values by their index:

```dart
void main() {
  final myEnum = MyEnum.fromIndex(1);
  print(myEnum); // MyEnum.two

  final myEnumOrNull = MyEnum.fromIndexOrNull(4);
  print(myEnumOrNull); // null
}
```

### 3. Full Example

```dart
import 'package:enumerator_macro/enumerator_macro.dart';

@Enumerator()
enum MyEnum {
  one,
  two,
  something;
}

void main(List<String> args) {
  final myEnum = MyEnum.one;

  // Getters
  print(myEnum.isOne);       // true
  print(myEnum.isTwo);       // false
  print(myEnum.isSomething); // false

  // isIn method
  print(myEnum.isIn({MyEnum.one, MyEnum.two})); // true

  // Get enum from name
  final MyEnum one = MyEnum.fromName('one');
  print(one); // MyEnum.one

  final MyEnum? oneOrNull = MyEnum.fromNameOrNull('unknown');
  print(oneOrNull); // null

  // Get enum from index
  final MyEnum two = MyEnum.fromIndex(1);
  print(two); // MyEnum.two

  final MyEnum? somethingOrNull = MyEnum.fromIndexOrNull(2);
  print(somethingOrNull); // MyEnum.something
}
```
