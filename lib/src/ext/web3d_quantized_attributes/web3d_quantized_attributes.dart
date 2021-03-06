/*
 * # Copyright (c) 2016-2017 The Khronos Group Inc.
 * # Copyright (c) 2016 Alexey Knyazev
 * #
 * # Licensed under the Apache License, Version 2.0 (the "License");
 * # you may not use this file except in compliance with the License.
 * # You may obtain a copy of the License at
 * #
 * #     http://www.apache.org/licenses/LICENSE-2.0
 * #
 * # Unless required by applicable law or agreed to in writing, software
 * # distributed under the License is distributed on an "AS IS" BASIS,
 * # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * # See the License for the specific language governing permissions and
 * # limitations under the License.
 */

library gltf.extensions.web3d_quantized_attributes;

import 'package:gltf/src/utils.dart';
import 'package:gltf/src/base/gltf_property.dart';
import 'package:gltf/src/ext/extensions.dart';

// WEB3D_quantized_attributes
const String WEB3D_QUANTIZED_ATTRIBUTES = 'WEB3D_quantized_attributes';
const String DECODE_MATRIX = 'decodeMatrix';
const String DECODED_MAX = 'decodedMax';
const String DECODED_MIN = 'decodedMin';

const List<String> WEB3D_QUANTIZED_ATTRIBUTES_MEMBERS = const <String>[
  DECODE_MATRIX,
  DECODED_MAX,
  DECODED_MIN
];

const List<int> MATRIX_LENGTHS = const <int>[4, 9, 16, 25];
const List<int> VECTOR_LENGTHS = const <int>[1, 2, 3, 4];

class Web3dQuantizedAttributes extends Stringable {
  final List<double> decodeMatrix;
  final List<double> decodedMin;
  final List<double> decodedMax;

  Web3dQuantizedAttributes._(
      this.decodeMatrix, this.decodedMin, this.decodedMax);

  @override
  String toString([_]) => super.toString({
        DECODE_MATRIX: decodeMatrix,
        DECODED_MIN: decodedMin,
        DECODED_MAX: decodedMax
      });

  static Web3dQuantizedAttributes fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate)
      checkMembers(map, WEB3D_QUANTIZED_ATTRIBUTES_MEMBERS, context);
    return new Web3dQuantizedAttributes._(
        getFloatList(map, DECODE_MATRIX, context,
            req: true, lengthsList: MATRIX_LENGTHS),
        getFloatList(map, DECODED_MIN, context,
            req: true, lengthsList: VECTOR_LENGTHS),
        getFloatList(map, DECODED_MAX, context,
            req: true, lengthsList: VECTOR_LENGTHS));
  }
}

class Web3dQuantizedAttributesExtension extends Extension {
  @override
  final String name = WEB3D_QUANTIZED_ATTRIBUTES;

  @override
  final Map<Type, ExtFuncs> functions = <Type, ExtFuncs>{
    Gltf: const ExtFuncs(Web3dQuantizedAttributes.fromMap, null)
  };

  factory Web3dQuantizedAttributesExtension() => _singleton;

  static final Web3dQuantizedAttributesExtension _singleton =
      new Web3dQuantizedAttributesExtension._();
  Web3dQuantizedAttributesExtension._();
}
