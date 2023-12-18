import 'package:arche/abc/typed.dart';
import 'package:yaml/yaml.dart';

class YamlSerializer<K, V> implements MapSerializer<K, V, String> {
  @override
  Map<K, V> decode(String data) {
    return loadYaml(data);
  }

  @override
  String encode(Map<K, V> object) {
    throw UnimplementedError();
  }
}
