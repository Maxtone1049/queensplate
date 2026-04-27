import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:queen_plate_delivery/common/AppUtils/app_ui_components.dart';

import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';
import 'package:image/image.dart' as img_lib;

class AppHelpers {
  static void copy(String text) async {
    if (text.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: text));
      // await HapticFeedback.heavyImpact();
      AppUiComponents.triggerNotification('Copied to clipboard');
      return;
    } else {
      throw ('Please enter a valid text');
    }
  }

  static Future<void> launchURL(
    Uri uri, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    try {
      await launchUrl(uri, mode: mode);
    } catch (e) {
      throw 'Could not launch URL: $e';
    }
  }

  /// Main method called from your "Share Receipt" button
  /// Shows a simple choice: Image (PNG) or PDF
  static Future<void> shareReceipt(
    BuildContext context,
    Future<Uint8List?> Function() captureFunction,
  ) async {
    final choice = await showModalBottomSheet<String?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Share Receipt As",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.image, color: Colors.blue, size: 32),
                title: const Text("Image (PNG)"),
                subtitle: const Text("Quick share, smaller file"),
                onTap: () => Navigator.pop(context, "image"),
              ),
              ListTile(
                leading: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.red,
                  size: 32,
                ),
                title: const Text("PDF Document"),
                subtitle: const Text("Printable, professional look"),
                onTap: () => Navigator.pop(context, "pdf"),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        );
      },
    );

    if (choice == null) return;

    // Show brief loading (optional but improves UX)
    AppUiComponents.triggerNotification("Preparing...");

    final rawBytes = await captureFunction();
    if (rawBytes == null || rawBytes.isEmpty) {
      AppUiComponents.triggerNotification("Failed to capture receipt");
      return;
    }

    Uint8List processedBytes = rawBytes;

    // Optional fast pre-compress for both image & pdf
    processedBytes = await _compressImageIfLarge(rawBytes);

    if (choice == "image") {
      await _shareAsImage(processedBytes);
    } else {
      await _shareAsPdfFast(processedBytes);
    }
  }

  /// Quick resize + compress if image is very large
  static Future<Uint8List> _compressImageIfLarge(Uint8List bytes) async {
    try {
      final image = img_lib.decodeImage(bytes);
      if (image == null) return bytes;

      // Resize only if very large (receipts usually < 1200px width)
      if (image.width > 900) {
        final resized = img_lib.copyResize(
          image,
          width: 800,
          interpolation: img_lib.Interpolation.average,
        );
        return Uint8List.fromList(
          img_lib.encodePng(resized, level: 5),
        ); // level 5 = fast + good quality
      }

      // Just recompress png a bit
      return Uint8List.fromList(img_lib.encodePng(image, level: 6));
    } catch (_) {
      return bytes; // fallback
    }
  }

  static Future<void> _shareAsImage(Uint8List bytes) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final path = '${tempDir.path}/WePay-Receipt.png';
      final file = File(path)..writeAsBytesSync(bytes);
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          previewThumbnail: XFile(file.path),
          text: 'Transaction Receipt',
          subject: 'Receipt',
        ),
      );
      // await Share.shareXFiles(
      //   [XFile(file.path)],
      //   text: 'Transaction Receipt',
      //   subject: 'Receipt',
      // );
    } catch (e) {
      AppUiComponents.triggerNotification("Error sharing image");
    }
  }

  static Future<void> _shareAsPdfFast(Uint8List pngBytes) async {
    try {
      final pdf = pw.Document();

      final imageProvider = pw.MemoryImage(pngBytes);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(imageProvider, fit: pw.BoxFit.contain),
            );
          },
        ),
      );

      final pdfBytes = await pdf.save();

      final tempDir = await getTemporaryDirectory();
      final path =
          '${tempDir.path}/WePay${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File(path)..writeAsBytesSync(pdfBytes);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          previewThumbnail: XFile(file.path),
          text: 'Transaction Receipt (PDF)',
          subject: 'Receipt',
        ),
      );
      // await Share.shareXFiles(
      //   [XFile(file.path)],
      //   text: 'Transaction Receipt (PDF)',
      //   subject: 'Receipt PDF',
      // );
    } catch (e) {
      AppUiComponents.triggerNotification("Error creating PDF");
    }
  }

  static double getDeviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height.h;

  static double getDeviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width.w;

  static void share({
    required BuildContext context,
    required String title,
    String? subject,
  }) async {
    final box = context.findRenderObject() as RenderBox?;

    await SharePlus.instance.share(
      ShareParams(
        text: title,
        title: title,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      ),
    );
  }

  static Future<PackageInfo> appsInfo() async =>
      await PackageInfo.fromPlatform();

  static Future<Directory> findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory!;
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  static String generateKey(int length) => String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
    ),
  );
}
