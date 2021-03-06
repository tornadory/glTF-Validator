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

library gltf.extensions;

import 'package:gltf/src/hash.dart';
import 'package:gltf/src/base/gltf_property.dart';

import 'package:gltf/src/ext/KHR_materials_pbrSpecularGlossiness/khr_materials_pbr_specular_glossiness.dart';
import 'package:gltf/src/ext/cesium_rtc/cesium_rtc.dart';
import 'package:gltf/src/ext/web3d_quantized_attributes/web3d_quantized_attributes.dart';

export 'package:gltf/src/ext/cesium_rtc/cesium_rtc.dart';
export 'package:gltf/src/ext/web3d_quantized_attributes/web3d_quantized_attributes.dart';
export 'package:gltf/src/ext/KHR_materials_pbrSpecularGlossiness/khr_materials_pbr_specular_glossiness.dart';

abstract class Extension {
  String get name;

  Map<Type, ExtFuncs> get functions;

  // Sub-classes should be singletons instead of consts because of
  // https://github.com/dart-lang/sdk/issues/17207
}

class ExtFuncs {
  final FromMapFunction fromMap;
  final LinkFunction link;
  const ExtFuncs(this.fromMap, this.link);
}

class ExtensionTuple {
  final Type type;
  final String name;
  const ExtensionTuple(this.type, this.name);

  @override
  int get hashCode => hash2(type.hashCode, name.hashCode);

  @override
  bool operator ==(Object o) =>
      o is ExtensionTuple && name == o.name && type == o.type;
}

final List<Extension> defaultExtensions = <Extension>[
  new KhrMaterialsPbrSpecularGlossinessExtension(),
  new CesiumRtcExtension(),
  new Web3dQuantizedAttributesExtension()
];

// https://github.com/KhronosGroup/glTF/blob/master/extensions/Prefixes.md
const List<String> kReservedPrefixes = const <String>[
  'KHR_',
  'EXT_',
  'AVR_',
  'BLENDER_',
  'CESIUM_',
  'FB_',
  'GOOGLE_',
  'OWLII_',
  'WEB3D_'
];
