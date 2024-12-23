import 'dart:ffi';
import 'package:ffi/ffi.dart';

base class StringView extends Struct {
  external Pointer<Utf8> buf;
  @Uint64()
  external int len;
}

final DynamicLibrary nativeLib = DynamicLibrary.open('flutter_cpp_lib.dll');

final StringView Function() getString = nativeLib
    .lookup<NativeFunction<StringView Function()>>('get_string')
    .asFunction();

final void Function(StringView) freeStringView = nativeLib
    .lookup<NativeFunction<Void Function(StringView)>>('free_string')
    .asFunction();

String getCppString() {
  final StringView sv = getString();
  final String result = sv.buf.toDartString(length: sv.len);
  freeStringView(sv);
  return result;
}