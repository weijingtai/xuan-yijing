
// 移除gua_name_index_v1.json 中的 "易童子问”
// 并独立存储为一个json文件

import 'dart:convert';
import 'dart:io';

void main(){

  var file = File("D:\\Programme\\Flutter\\MyFlutter\\resources\\db\\yi_tong_zi_wen_v1.json");
  var content = file.readAsStringSync();
  // 从String转为Map
  var map = Map<String, dynamic>.from(jsonDecode(content));
  var tongZiWen = Map<String, dynamic>();
  // 从Map中取出数据
  for (var entry in map.entries) {
    var gua_name = entry.key;
    var tongziwen = entry.value[0]["zhu"] == null ? "无" : entry.value[0]["zhu"];
    tongZiWen[gua_name] = tongziwen;
  }
  var file2 = File("D:\\Programme\\Flutter\\MyFlutter\\resources\\db\\yi_tong_zi_wen_v1_1.json");
  file2.writeAsStringSync(json.encode(tongZiWen));

}
void convert_v1_to_v11(){
  // 读取数据
  var file = File("D:\\Programme\\Flutter\\MyFlutter\\resources\\db\\gua_name_index_v1.json");
  var content = file.readAsStringSync();
  // 从String转为Map
  var map = Map<String, dynamic>.from(jsonDecode(content));


  var without_tongZiWen = Map<String, dynamic>();
  var tongZiWen = Map<String, dynamic>();
  // 从Map中取出数据
  for (var entry in map.entries) {
    var gua_name = entry.key;
    var content = entry.value;
    var tmpMap = Map<String, dynamic>.from(content);
    var tongziwen = tmpMap.remove("易童子问");


    without_tongZiWen[gua_name] = tmpMap;
    tongZiWen[gua_name] = tongziwen;


  }
  var result_file = File("D:\\Programme\\Flutter\\MyFlutter\\resources\\db\\gua_name_index_v1_1.json");
  result_file.writeAsStringSync(json.encode(without_tongZiWen));
  var file2 = File("D:\\Programme\\Flutter\\MyFlutter\\resources\\db\\yi_tong_zi_wen_v1.json");
  file2.writeAsStringSync(json.encode(tongZiWen));

}