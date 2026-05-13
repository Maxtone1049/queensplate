import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// Your existing imports - adjust paths as needed
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
  WebViewController? _controller;
  bool isLoading = true;
  bool _isProcessingCancel = false;

  // URLs that indicate user cancelled payment
  final List<String> cancelIndicators = [
    'https://standard.paystack.co/close',
    'paystack.co/close',
    'cancel',
    'close',
  ];

  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      _handleWebPayment();
    } else {
      _initMobileWebView();
    }

    // Safety timeout
    Future.delayed(const Duration(seconds: 30), () {
      if (mounted && isLoading) {
        setState(() => isLoading = false);
      }
    });
  }

  // MOBILE: Initialize WebView
  void _initMobileWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() => isLoading = false);
            }
          },
          onPageStarted: (String url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => isLoading = false);
            _checkUrlForCancel(url);
          },
          onWebResourceError: (WebResourceError error) {
            setState(() => isLoading = false);
            debugPrint('WebView Error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  // Check if URL indicates cancel action
  void _checkUrlForCancel(String url) {
    final lowerUrl = url.toLowerCase();

    bool isCancel = cancelIndicators.any(
      (indicator) => lowerUrl.contains(indicator.toLowerCase()),
    );

    if (isCancel && !_isProcessingCancel) {
      _handleCancelFromPaystack();
    }
  }

  // Handle cancel action from Paystack
  void _handleCancelFromPaystack() {
    if (_isProcessingCancel) return;

    setState(() {
      _isProcessingCancel = true;
      isLoading = false;
    });

    debugPrint('Paystack payment cancelled by user');

    // Call the cancellation callback if provided
    widget.onPaymentCancelled?.call();

    // Immediately pop back to original screen
    if (mounted) {
      // Show brief feedback before popping
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Payment cancelled"),
          backgroundColor: Colors.orange,
          duration: Duration(milliseconds: 800),
        ),
      );

      // Pop after a short delay to show the SnackBar
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) {
          PageRouter.pop();
        }
      });
    }
  }

  // WEB: Handle payment in browser
  Future<void> _handleWebPayment() async {
    setState(() => isLoading = true);

    final Uri url = Uri.parse(widget.paymentUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);

      // Show dialog when user returns to app
      _showReturnDialog();
    } else {
      setState(() => isLoading = false);
      _handleError('Could not open payment page');
    }
  }

  void _showReturnDialog() {
    setState(() => isLoading = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Payment Status'),
        content: const Text('What would you like to do?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _handleCancelFromPaystack();
            },
            child: const Text(
              'Cancel Payment',
              style: TextStyle(color: Colors.red),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onPaymentSuccess(widget.orderId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00A651),
            ),
            child: const Text('Payment Completed'),
          ),
        ],
      ),
    );
  }

  void _handleError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
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
                onTap: _handleCancelFromPaystack, // User taps back button
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
        child: kIsWeb ? _buildWebUI() : _buildMobileUI(),
      ),
    );
  }

  Widget _buildWebUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.open_in_browser, size: 64, color: Color(0xFF00A651)),
          const SizedBox(height: 24),
          TextView(
            config: TextViewConfig(
              text: "Opening Paystack in browser...",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          if (isLoading)
            const Column(
              children: [
                CircularProgressIndicator(color: Color(0xFF00A651)),
                SizedBox(height: 16),
                Text("Please wait..."),
              ],
            )
          else
            TextButton(
              onPressed: _handleCancelFromPaystack,
              child: const Text(
                "Cancel Payment",
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMobileUI() {
    return Stack(
      children: [
        if (_controller != null) WebViewWidget(controller: _controller!),
        if (isLoading && !_isProcessingCancel)
          Container(
            color: Colors.white,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFF00A651)),
                  SizedBox(height: 16),
                  Text("Connecting to Paystack..."),
                ],
              ),
            ),
          ),
        if (_isProcessingCancel)
          Container(
            color: Colors.white,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cancel_outlined, size: 48, color: Colors.orange),
                  SizedBox(height: 16),
                  Text("Cancelling payment..."),
                ],
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller?.clearCache();
    super.dispose();
  }
}
