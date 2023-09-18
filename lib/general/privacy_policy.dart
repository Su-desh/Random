// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({super.key});

  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
      Uri.parse(
          'https://www.privacypolicies.com/live/2bb27d42-51f1-48e0-9453-c5032153559b'),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
