import 'dart:async';

import 'package:macros/macros.dart';

macro class Enumerator implements ClassDeclarationsMacro {
  const Enumerator();

  @override
  Future<void> buildDeclarationsForClass(
    ClassDeclaration clazz,
    MemberDeclarationBuilder builder,
  ) async {
    final name = clazz.identifier.name;
    final fieldList = await builder.fieldsOf(clazz);
    // TODO(albin): Update condition
    final fields = fieldList.where((e) {
      return e.identifier.name != '_self' && e.identifier.name != 'values';
    }).toList();

    _buildBoolGetters(builder, fields);

    _buildFromNameConstructor(builder, name);
    _buildFromNameOrNullMethod(builder, name);

    _buildFromIndexConstructor(builder, name);
    _buildFromIndexOrNullMethod(builder, name);
  }

  void _buildFromIndexConstructor(
    MemberDeclarationBuilder builder,
    String name,
  ) {
    builder.declareInType(
      DeclarationCode.fromParts([
        '  factory $name.fromIndex(int index) {\n',
        '    return values.firstWhere(\n',
        '      (e) => e.index == index,\n',
        '    );\n',
        '  }\n',
      ]),
    );
  }

  void _buildFromIndexOrNullMethod(
    MemberDeclarationBuilder builder,
    String name,
  ) {
    builder.declareInType(
      DeclarationCode.fromParts([
        '  static $name? fromIndexOrNull(int? index) {\n',
        '    if (index == null) return null;\n',
        '    try {\n',
        '      return $name.fromIndex(index);\n',
        '    } catch (_) {\n',
        '      return null;\n',
        '    }\n',
        '  }\n',
      ]),
    );
  }

  void _buildFromNameOrNullMethod(
    MemberDeclarationBuilder builder,
    String name,
  ) {
    builder.declareInType(
      DeclarationCode.fromParts([
        '  static $name? fromNameOrNull(String? name) {\n',
        '    if (name == null) return null;\n',
        '    try {\n',
        '      return $name.fromName(name);\n',
        '    } catch (_) {\n',
        '      return null;\n',
        '    }\n',
        '  }\n',
      ]),
    );
  }

  void _buildFromNameConstructor(
    MemberDeclarationBuilder builder,
    String name,
  ) {
    builder.declareInType(
      DeclarationCode.fromParts([
        '  factory $name.fromName(String name) {\n',
        '    return values.firstWhere(\n',
        '      (e) => e.name == name,\n',
        '    );\n',
        '  }\n',
      ]),
    );
  }

  void _buildBoolGetters(
    MemberDeclarationBuilder builder,
    List<FieldDeclaration> fields,
  ) {
    builder.declareInType(
      DeclarationCode.fromParts([
        for (final f in fields) ...[
          '  bool get is${f.identifier.name.cap} => _self == ${f.identifier.name};\n\n',
        ],
      ]),
    );
  }
}

extension on Builder {
  void log(Object? message) {
    report(
      Diagnostic(
        DiagnosticMessage(message.toString()),
        Severity.info,
      ),
    );
  }
}

extension on String {
  String get cap => '${this[0].toUpperCase()}${substring(1)}';
}
