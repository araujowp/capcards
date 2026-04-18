import 'package:capcards/components/cap_button.dart';
import 'package:capcards/components/cap_text_field.dart';
import 'package:capcards/page/cap_scaffold.dart';
import 'package:capcards/page/card/components/cap_image_picker.dart';
import 'package:capcards/repository/card/card_dto.dart';
import 'package:capcards/repository/card/card_dto_new.dart';
import 'package:capcards/repository/card/card_repository.dart';
import 'package:flutter/material.dart';

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

  void _onFrontImageChanged(String? base64) {
    setState(() => frontImageBase64 = base64);
  }

  void _onBackImageChanged(String? base64) {
    setState(() => backImageBase64 = base64);
  }

  @override
  Widget build(BuildContext context) {
    return CapScaffold(
      appBarText: "Edite Cartão",
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CapTextField(label: "Frente", controller: textControllerFront),
              CapImagePicker(
                initialImageBase64: frontImageBase64,
                label: "Frente",
                onImageSelected: _onFrontImageChanged,
              ),
              CapTextField(label: "Verso", controller: textControllerBack),
              CapImagePicker(
                initialImageBase64: backImageBase64,
                label: "Verso",
                onImageSelected: _onBackImageChanged,
              ),
              CapButton(label: "Salvar", icon: Icons.save, onTap: save),
              CapButton(label: "Cancelar", icon: Icons.cancel, onTap: cancel),
            ],
          ),
        ),
      ),
    );
  }
}
