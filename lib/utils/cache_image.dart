import 'dart:typed_data';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatefulWidget {
  final String? imageUrl;
  final double? borderRadius;
  final double? height;
  final double? width;
  final bool showUserIconWhenError;
  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.borderRadius,
    this.height,
    this.width,
    this.showUserIconWhenError = false,
  }) : super(key: key);

  @override
  State<CustomNetworkImage> createState() => _CustomNetworkImageState();
}

class _CustomNetworkImageState extends State<CustomNetworkImage> {
  Uint8List? _imageBytes;
  bool _sslFallbackTried = false;

  bool get _hasValidUrl =>
      widget.imageUrl != null &&
          widget.imageUrl!.isNotEmpty &&
          widget.imageUrl!.startsWith("http");

  @override
  Widget build(BuildContext context) {
    if (!_hasValidUrl) return _fallbackWidget();

    if (_imageBytes != null) {
      return _rounded(
        Image.memory(
          _imageBytes!,
          height: widget.height,
          width: widget.width,
          fit: BoxFit.cover,
        ),
      );
    }

    return _rounded(
      CachedNetworkImage(
        imageUrl: widget.imageUrl!,
        height: widget.height,
        width: widget.width,
        fit: BoxFit.cover,
        placeholder: (_, __) => _shimmer(),
        errorWidget: (_, __, ___) {
          if (!_sslFallbackTried) {
            _sslFallbackTried = true;
            _loadSslBypass();
          }
          return _fallbackWidget();
        },
      ),
    );
  }

  Widget _fallbackWidget() {
    return _rounded(
      widget.showUserIconWhenError
          ? Container(
        height: widget.height,
        width: widget.width,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.user,
              size: (widget.height ?? 40) * 0.6,
              color: Colors.grey.shade600,
            ),
          )
          : Container(
          height: widget.height,
          width: widget.width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
        ),
        // Image.asset(
        ),
      // Image.asset(
      //   "assets/shopping-bag .png",
      //   height: widget.height,
      //   width: widget.width,
      //   fit: BoxFit.cover,
      //   color: Colors.grey.shade400,
      // ),
    );
  }

  Future<void> _loadSslBypass() async {
    try {
      final httpClient = HttpClient()
        ..badCertificateCallback = (_, __, ___) => true;
      final ioClient = IOClient(httpClient);

      final response = await ioClient.get(Uri.parse(widget.imageUrl!));
      if (response.statusCode == 200) {
        setState(() => _imageBytes = response.bodyBytes);
      }
    } catch (_) {}
  }

  Widget _rounded(Widget child) {
    if (widget.showUserIconWhenError) {
      return ClipOval(child: child);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
      child: child,
    );
  }


  Widget _shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: widget.height,
        width: widget.width,
        color: Colors.grey.shade300,
      ),
    );
  }
}
