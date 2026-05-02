import 'dart:convert';
import 'package:capcards/components/cap_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CapImagePicker extends StatefulWidget {
  final String? initialImageBase64;
  final String label;
  final ValueChanged<String?> onImageSelected;

  const CapImagePicker({
    super.key,
    this.initialImageBase64,
    required this.label,
    required this.onImageSelected,
  });

  @override
  State<CapImagePicker> createState() => _CapImagePickerState();
}

class _CapImagePickerState extends State<CapImagePicker> {
  late String? _currentImageBase64;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _currentImageBase64 = widget.initialImageBase64;
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 50,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile == null) return;

      final bytes = await pickedFile.readAsBytes();
      final base64String = base64Encode(bytes);

      setState(() => _currentImageBase64 = base64String);
      widget.onImageSelected(base64String);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao capturar imagem: $e')));
    }
  }

  void _removeImage() {
    setState(() => _currentImageBase64 = null);
    widget.onImageSelected(null);
  }

  void _showOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tirar foto com a câmera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Escolher da galeria'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            if (_currentImageBase64 != null)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Remover imagem'),
                onTap: () {
                  Navigator.pop(context);
                  _removeImage();
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showOptions,
      child: CapImageViewer(
        imageBase64: _currentImageBase64,
        label: widget.label,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
