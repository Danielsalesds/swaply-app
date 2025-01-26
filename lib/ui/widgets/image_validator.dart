import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageValidator extends StatefulWidget {
  final String? imageUrl;

  const ImageValidator({super.key, required this.imageUrl});

  @override
  State<ImageValidator> createState() => _ImageValidatorState();
}

class _ImageValidatorState extends State<ImageValidator> {
  bool _isValidUrl = false;

  @override
  void initState() {
    super.initState();
    _validateUrl(widget.imageUrl);
  }

  Future<void> _validateUrl(String? url) async {
    if (url == null || url.isEmpty) {
      setState(() {
        _isValidUrl = false;
      });
      return;
    }

    try {
      final response = await http.head(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          _isValidUrl = true;
        });
      } else {
        setState(() {
          _isValidUrl = false;
        });
      }
    } catch (e) {
      setState(() {
        _isValidUrl = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: _isValidUrl
          ? Image.network(
              widget.imageUrl!,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            )
          : Image.asset(
              'assets/item_default.jpg', // Imagem padrão
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
    );
  }
}
