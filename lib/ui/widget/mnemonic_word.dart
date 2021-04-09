import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';

/// Represents the input of a single mnemonic phrase word.
class MnemonicWordInput extends StatelessWidget {
  final int index;
  final bool editable;

  final String? word;
  final void Function(int, String)? onWordChanged;

  MnemonicWordInput({
    Key? key,
    required this.index,
    required this.editable,
    this.word,
    this.onWordChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: editable,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      controller: TextEditingController()..text = word ?? '',
      onChanged: (value) => onWordChanged?.call(index, value),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            top: 12,
            right: Directionality.of(context) == ui.TextDirection.ltr ? 8 : 0,
            left: Directionality.of(context) == ui.TextDirection.rtl ? 8 : 0,
          ),
          child: Text(
            index.toString(),
            style: DesmosTextStyles.smallBody(context),
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      ),
    );
  }
}
