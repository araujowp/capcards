import 'dart:convert';

import 'package:capcards/components/cap_button.dart';
import 'package:capcards/page/cap_scaffold.dart';
import 'package:capcards/repository/card/card_dto.dart';
import 'package:capcards/repository/card/card_dto_new.dart';
import 'package:capcards/repository/card/card_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CardPage extends StatefulWidget {
  final CardDTO cardDTO;
  const CardPage({super.key, required this.cardDTO});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  late TextEditingController textControllerFront;
  late TextEditingController textControllerBack;
  String? frontImageBase64;
  String? backImageBase64;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    textControllerFront = TextEditingController(
      text: widget.cardDTO.frontDescription,
    );
    textControllerBack = TextEditingController(
      text: widget.cardDTO.backDescription,
    );
    frontImageBase64 = widget.cardDTO.frontImage;
    backImageBase64 = widget.cardDTO.backImage;
  }

  @override
  void dispose() {
    textControllerFront.dispose();
    textControllerBack.dispose();
    super.dispose();
  }

  cancel() async {
    Navigator.pop(context);
  }

  save() async {
    if (textControllerFront.text.trim().isEmpty ||
        textControllerBack.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Frente e verso obrigatórios'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (widget.cardDTO.id == 0) {
      CardDTONew card = CardDTONew(
        frontDescription: textControllerFront.text,
        backDescription: textControllerBack.text,
        deckId: widget.cardDTO.deckId,
        frontImage: frontImageBase64,
        backImage: backImageBase64,
      );
      CardRepository.save(card);
    } else {
      CardDTO card = CardDTO(
        id: widget.cardDTO.id,
        frontDescription: textControllerFront.text,
        backDescription: textControllerBack.text,
        deckId: widget.cardDTO.deckId,
        revisionDate: widget.cardDTO.revisionDate,
        frontImage: frontImageBase64,
        backImage: backImageBase64,
      );
      CardRepository.update(card);
    }
    cancel();
  }

  Future<void> _pickImage(bool isFront, ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 70,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile == null) return;

      final bytes = await pickedFile.readAsBytes();
      final base64String = base64Encode(bytes);

      setState(() {
        if (isFront) {
          frontImageBase64 = base64String;
        } else {
          backImageBase64 = base64String;
        }
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao capturar imagem: $e')));
    }
  }

  void _showImageSourceOptions(bool isFront) {
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
                _pickImage(isFront, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Escolher da galeria'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(isFront, ImageSource.gallery);
              },
            ),
            if ((isFront && frontImageBase64 != null) ||
                (!isFront && backImageBase64 != null))
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Remover imagem'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    if (isFront) {
                      frontImageBase64 = null;
                    } else {
                      backImageBase64 = null;
                    }
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(String? base64Image, String label, bool isFront) {
    final hasImage = base64Image != null && base64Image.isNotEmpty;

    return GestureDetector(
      onTap: () => _showImageSourceOptions(isFront),
      child: Container(
        height: 180,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: hasImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.memory(
                  base64Decode(base64Image),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _placeholder(label),
                ),
              )
            : _placeholder(label),
      ),
    );
  }

  Widget _placeholder(String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.add_a_photo, size: 48, color: Colors.grey),
        const SizedBox(height: 8),
        Text(
          'Adicionar imagem - $label',
          style: const TextStyle(color: Colors.grey),
        ),
        const Text(
          'Toque para tirar foto ou escolher',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CapScaffold(
      appBarText: "Edite Cartão",
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: textControllerFront,
                decoration: const InputDecoration(label: Text("Frente")),
              ),
            ),
            _buildImagePreview(frontImageBase64, "Frente", true),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: textControllerBack,
                decoration: const InputDecoration(label: Text("Verso")),
              ),
            ),
            _buildImagePreview(backImageBase64, "verso", false),
            CapButton(label: "Salvar", icon: Icons.save, onTap: save),
            CapButton(label: "Cancelar", icon: Icons.cancel, onTap: cancel),
          ],
        ),
      ),
    );
  }
}
