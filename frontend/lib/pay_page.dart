import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PayPage extends StatefulWidget {
  final String url;

  const PayPage({super.key, required this.url});

  @override
  State<PayPage> createState() => _nameState();
}

class _nameState extends State<PayPage> {
  late final WebViewController webViewController;
  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..loadRequest(
        Uri.parse(widget.url),
        method: LoadRequestMethod.get,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Web Page"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: WebViewWidget(
          controller: webViewController,
        ),
      ),
    );
  }
}
