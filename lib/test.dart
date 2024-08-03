import 'package:appdemo/provider/connect_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<ConnectProvider>(context);
    provider.addListener(_showConnectivityDialog);
  }

  @override
  void dispose() {
    final provider = Provider.of<ConnectProvider>(context, listen: false);
    provider.removeListener(_showConnectivityDialog);
    super.dispose();
  }

  void _showConnectivityDialog() {
    final connectivityResult = context.read<ConnectProvider>().messConnect;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Kết nối đã thay đổi'),
        content: Text('Kết nối hiện tại: $connectivityResult'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final connectivityResult = context.watch<ConnectProvider>().messConnect;

    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Center(
        child: Text(
          'Kết nối hiện tại: $connectivityResult',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
