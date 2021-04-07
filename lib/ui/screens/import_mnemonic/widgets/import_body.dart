import 'package:dam/ui/screens/import_mnemonic/cubit/export.dart';
import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Body of the "Import mnemonic" page.
class ImportMnemonicBody extends StatelessWidget {
  final void Function(int, String) onWordChanged;
  final void Function() onNext;

  const ImportMnemonicBody({
    Key? key,
    required this.onWordChanged,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: DesmosPlatform.isMobile
          ? EdgeInsets.only(left: 16, right: 16, bottom: 16)
          : EdgeInsets.symmetric(horizontal: 360, vertical: 160),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.importMnemonicPageTitle,
                style: DesmosTextStyles.title(context),
              ),
              SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.importMnemonicBody,
                style: DesmosTextStyles.thinBodyGrey(context),
              ),
              MnemonicInput(
                editable: true,
                onWordChanged: onWordChanged,
              ),
              BlocBuilder<ImportMnemonicCubit, ImportMnemonicState>(
                builder: (context, state) {
                  return Visibility(
                    visible: state.hasError,
                    child: Column(
                      children: [
                        SizedBox(height: 12),
                        Text(
                          AppLocalizations.of(context)!.mnemonicNotValidError,
                          style: DesmosTextStyles.error(context),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: DesmosPlatform.isMobile ? 64 : 80),
          BlocBuilder<ImportMnemonicCubit, ImportMnemonicState>(
            builder: (context, state) {
              final disableNext = !state.has24Words || state.hasError;
              return PrimaryButton(
                text: AppLocalizations.of(context)!.nextButtonText,
                onPressed: disableNext ? null : onNext,
              );
            },
          ),
        ],
      ),
    );
  }
}
