import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Web only
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:queen_plate_delivery/Common/Image/ImageView.dart';
import 'package:queen_plate_delivery/Common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/Common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/Common/TextView/TextView.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/Body/BodyWidget.dart';
import 'package:queen_plate_delivery/common/Body/Model/BodyConfig.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';

class PaystackWebView extends StatefulWidget {
  final String paymentUrl;
  final Function(String reference) onPaymentSuccess;
  final VoidCallback? onPaymentCancelled;
  final String orderId;

  const PaystackWebView({
    super.key,
    required this.paymentUrl,
    required this.orderId,
    required this.onPaymentSuccess,
    this.onPaymentCancelled,
  });

  @override
  State<PaystackWebView> createState() => _PaystackWebViewState();
}

class _PaystackWebViewState extends State<PaystackWebView> {
  WebViewController? mobileController;
  bool isLoading = true;
  String? _iframeViewId;

  // Cancel detection URLs
  final List<String> cancelUrls = [
    'https://standard.paystack.co/close',
    // Add your custom cancel_action URL here if you set it in metadata
    // e.g., 'https://yourdomain.com/cancel',
  ];

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      _initMobileWebView();
    } else {
      _initWebIframe();
    }

    // Safety timeout: hide loader after 25 seconds even if callbacks fail
    Future.delayed(const Duration(seconds: 25), () {
      if (mounted && isLoading) {
        setState(() => isLoading = false);
      }
    });
  }

  void _initMobileWebView() {
    mobileController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Optional: you can show progress % if you want
            if (progress == 100) {
              setState(() => isLoading = false);
            }
          },
          onPageStarted: (String url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => isLoading = false);
            _handleUrlChange(url);
          },
          onWebResourceError: (WebResourceError error) {
            setState(() => isLoading = false);
            debugPrint('WebView Error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _initWebIframe() {
    _iframeViewId = 'paystack-iframe-${DateTime.now().millisecondsSinceEpoch}';
    ui_web.platformViewRegistry.registerViewFactory(_iframeViewId!, (
      int viewId,
    ) {
      final iframe = html.IFrameElement()
        ..src = widget.paymentUrl
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allow = 'payment; encrypted-media';
      return iframe;
    });

    // On web, hide loader after a short delay (iframe loading is harder to track)
    Future.delayed(const Duration(seconds: 8), () {
      if (mounted && isLoading) setState(() => isLoading = false);
    });
  }

  void _handleUrlChange(String url) {
    final lowerUrl = url.toLowerCase();

    // SUCCESS
    if (lowerUrl.contains("success") ||
        lowerUrl.contains("reference=") ||
        lowerUrl.contains("trxref=") ||
        lowerUrl.contains("status=success")) {
      final uri = Uri.parse(url);
      final reference =
          uri.queryParameters['reference'] ??
          uri.queryParameters['trxref'] ??
          "success";

      if (reference.isNotEmpty) {
        widget.onPaymentSuccess(reference);
        return;
      }
    }

    // CANCEL
    final isCancel =
        cancelUrls.any((c) => lowerUrl.startsWith(c.toLowerCase())) ||
        lowerUrl.contains("cancel") ||
        lowerUrl.contains("close");

    if (isCancel) {
      _handlePaymentCancelled();
    }
  }

  void _handlePaymentCancelled() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("You've cancelled the payment."),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 3),
      ),
    );

    widget.onPaymentCancelled?.call();

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) PageRouter.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      config: BodyConfig(
        backgroundColor: AppColors.background,
        leadingWidget: Row(
          children: [
            ImageView(
              imageConfig: ImageConfig(
                imageURL: AppImage.circlebackarrow,
                imageType: ImageType.svg,
                onTap: () => PageRouter.pop(),
              ),
            ),
            const Spacer(),
            TextView(
              config: TextViewConfig(
                text: "Complete Payment",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
          ],
        ),
        child: Stack(
          children: [
            // Mobile WebView
            if (!kIsWeb && mobileController != null)
              WebViewWidget(controller: mobileController!),

            // Web Iframe
            if (kIsWeb && _iframeViewId != null)
              HtmlElementView(viewType: _iframeViewId!),

            // Loading Overlay
            if (isLoading)
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Color(0xFF00A651)),
                    SizedBox(height: 16),
                    Text("Connecting to Paystack..."),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    mobileController?.clearCache();
    super.dispose();
  }
}
