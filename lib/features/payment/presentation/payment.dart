import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/component_widget/reuse/snackbar.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            final uri = Uri.parse(request.url);

            // ✅ Log the full URL
            print('Navigating to: ${request.url}');

            // ✅ Extract and log query parameters (if any)
            if (uri.queryParameters.isNotEmpty) {
              print('Query Parameters:');
              uri.queryParameters.forEach((key, value) {
                print('$key: $value');
              });
              if(uri.queryParameters["init"] != null && uri.queryParameters["init"]=="true"){
                SnackbarDemo();
               // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              }
            }

            return NavigationDecision.navigate; // Allow navigation
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebView"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
