import 'package:flutter/material.dart';
import '../yijing_api.dart';

/// API测试页面
/// 用于验证YijingApi功能是否正常
class YijingApiTestPage extends StatefulWidget {
  const YijingApiTestPage({Key? key}) : super(key: key);

  @override
  State<YijingApiTestPage> createState() => _YijingApiTestPageState();
}

class _YijingApiTestPageState extends State<YijingApiTestPage> {
  final YijingApi _api = YijingApi();
  final List<String> _logs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initApi();
  }

  Future<void> _initApi() async {
    setState(() {
      _isLoading = true;
      _logs.add('初始化YijingApi...');
    });

    try {
      await _api.init();
      _addLog('✅ API初始化成功');
    } catch (e) {
      _addLog('❌ API初始化失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addLog(String message) {
    setState(() {
      _logs.insert(
          0, '[${DateTime.now().toString().substring(11, 19)}] $message');
    });
  }

  Future<void> _testGetAllGua() async {
    _addLog('开始测试: 获取所有卦象');
    final response = await _api.getAllGua();
    if (response.code == 200) {
      _addLog('✅ 成功获取 ${response.data?.length ?? 0} 个卦象');
    } else {
      _addLog('❌ 失败: ${response.error}');
    }
  }

  Future<void> _testGetGuaByBinary() async {
    _addLog('开始测试: 根据二进制获取乾卦(111111)');
    final response = await _api.getGuaByBinary('111111');
    if (response.code == 200 && response.data != null) {
      _addLog('✅ 成功获取: ${response.data!.fullname}');
      _addLog('   卦辞: ${response.data!.gua ?? "无"}');
    } else {
      _addLog('❌ 失败: ${response.error ?? "未找到"}');
    }
  }

  Future<void> _testSearchGua() async {
    _addLog('开始测试: 搜索"乾"');
    final response = await _api.searchGuaByName('乾');
    if (response.code == 200) {
      _addLog('✅ 找到 ${response.data?.length ?? 0} 个结果');
      for (final gua in response.data ?? []) {
        _addLog('   - ${gua.fullname}');
      }
    } else {
      _addLog('❌ 失败: ${response.error}');
    }
  }

  Future<void> _testGetYaoCi() async {
    _addLog('开始测试: 获取乾卦爻辞');
    final response = await _api.getYaoCi('111111');
    if (response.code == 200) {
      _addLog('✅ 成功获取 ${response.data?.length ?? 0} 爻');
      for (final yao in response.data ?? []) {
        _addLog('   ${yao.yaoName}: ${yao.yaoCi ?? "无"}');
      }
    } else {
      _addLog('❌ 失败: ${response.error}');
    }
  }

  Future<void> _testGetFullGuaData() async {
    _addLog('开始测试: 获取乾卦完整数据');
    final response = await _api.getFullGuaData('111111');
    if (response.code == 200 && response.data != null) {
      final data = response.data!;
      _addLog('✅ 成功获取完整数据');
      _addLog('   卦名: ${data.fullname}');
      _addLog('   卦辞: ${data.guaCi ?? "无"}');
      _addLog('   彖辞: ${data.tuanCi?.substring(0, 30) ?? "无"}...');
      _addLog('   象辞: ${data.xiangCi ?? "无"}');
      _addLog('   爻数: ${data.yaoCi?.length ?? 0}');
    } else {
      _addLog('❌ 失败: ${response.error ?? "未找到"}');
    }
  }

  Future<void> _testGetBooks() async {
    _addLog('开始测试: 获取所有注书');
    final response = await _api.getAllBooks();
    if (response.code == 200) {
      _addLog('✅ 成功获取 ${response.data?.length ?? 0} 本注书');
      for (final book in response.data ?? []) {
        _addLog('   - ${book.name} (${book.author})');
      }
    } else {
      _addLog('❌ 失败: ${response.error}');
    }
  }

  Future<void> _testGetGuaCount() async {
    _addLog('开始测试: 获取卦象数量');
    final response = await _api.getGuaCount();
    if (response.code == 200) {
      _addLog('✅ 卦象总数: ${response.data}');
    } else {
      _addLog('❌ 失败: ${response.error}');
    }
  }

  Future<void> _testIsValidBinary() async {
    _addLog('开始测试: 验证二进制编码');
    final response1 = await _api.isValidBinary('111111');
    _addLog('   "111111": ${response1.data == true ? "✅ 有效" : "❌ 无效"}');

    final response2 = await _api.isValidBinary('111112');
    _addLog('   "111112": ${response2.data == true ? "✅ 有效" : "❌ 无效"}');
  }

  void _clearLogs() {
    setState(() {
      _logs.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YijingApi 测试'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _clearLogs,
            tooltip: '清除日志',
          ),
        ],
      ),
      body: Column(
        children: [
          // 测试按钮区域
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[100],
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _testGetAllGua,
                  icon: const Icon(Icons.list),
                  label: const Text('所有卦象'),
                ),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _testGetGuaByBinary,
                  icon: const Icon(Icons.search),
                  label: const Text('乾卦详情'),
                ),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _testSearchGua,
                  icon: const Icon(Icons.find_in_page),
                  label: const Text('搜索乾'),
                ),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _testGetYaoCi,
                  icon: const Icon(Icons.text_fields),
                  label: const Text('爻辞'),
                ),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _testGetFullGuaData,
                  icon: const Icon(Icons.data_object),
                  label: const Text('完整数据'),
                ),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _testGetBooks,
                  icon: const Icon(Icons.book),
                  label: const Text('注书列表'),
                ),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _testGetGuaCount,
                  icon: const Icon(Icons.numbers),
                  label: const Text('卦象数量'),
                ),
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _testIsValidBinary,
                  icon: const Icon(Icons.check_circle),
                  label: const Text('验证编码'),
                ),
              ],
            ),
          ),

          // 加载指示器
          if (_isLoading) const LinearProgressIndicator(),

          // 日志区域
          Expanded(
            child: Container(
              color: Colors.black87,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  final log = _logs[index];
                  Color textColor = Colors.white;
                  if (log.contains('✅')) {
                    textColor = Colors.green;
                  } else if (log.contains('❌')) {
                    textColor = Colors.red;
                  } else if (log.contains('开始测试')) {
                    textColor = Colors.yellow;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      log,
                      style: TextStyle(
                        color: textColor,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _api.dispose();
    super.dispose();
  }
}
