import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';

void main() => runApp(const MaterialApp(
      home: CRMApp(),
      debugShowCheckedModeBanner: false,
    ));

class CRMApp extends StatefulWidget {
  const CRMApp({super.key});

  @override
  State<CRMApp> createState() => _CRMAppState();
}

class _CRMAppState extends State<CRMApp> {
  Iterable<CallLogEntry> _callLogs = [];

  void _getCallLogs() async {
    try {
      Iterable<CallLogEntry> entries = await CallLog.get();
      setState(() {
        _callLogs = entries;
      });
    } catch (e) {
      // التعامل مع الإذن إذا لم يُمنح
    }
  }

  @override
  void initState() {
    super.initState();
    _getCallLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart CRM - المكالمات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _getCallLogs,
          )
        ],
      ),
      body: _callLogs.isEmpty
          ? const Center(child: Text('جاري تحميل المكالمات أو لا توجد أرقام...'))
          : ListView.builder(
              itemCount: _callLogs.length,
              itemBuilder: (context, index) {
                var entry = _callLogs.elementAt(index);
                return ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(entry.name ?? entry.number ?? 'مجهول'),
                  subtitle: Text('الرقم: ${entry.number}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // خيارات تسجيل العميل
                    },
                    child: const Text('تسجيل'),
                  ),
                );
              },
            ),
    );
  }
}
