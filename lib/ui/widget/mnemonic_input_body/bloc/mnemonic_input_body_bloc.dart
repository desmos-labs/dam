import 'package:bloc/bloc.dart';
import 'package:dam/ui/export.dart';

import 'mnemonic_input_body_state.dart';
import 'mnemonic_input_body_event.dart';

/// Cubit of the "Import mnemonic" page.
class MnemonicInputBodyBloc
    extends Bloc<MnemonicInputBodyEvent, MnemonicInputBodyState> {
  MnemonicInputBodyBloc(List<String>? mnemonicCheck)
      : super(MnemonicInputBodyState.initial(mnemonicCheck));

  @override
  Stream<MnemonicInputBodyState> mapEventToState(
    MnemonicInputBodyEvent e,
  ) async* {
    if (e is WordChanged) {
      yield* _mapWordChangedToState(e);
    } else if (e is ChangeAccountsNumber) {
      yield* _mapChangeAccountsNumberToState(e);
    } else if (e is ShowsLoadingBar) {
      yield* _mapStartLoadingToState();
    }
  }

  Stream<MnemonicInputBodyState> _mapWordChangedToState(WordChanged e) async* {
    final words = Map<int, String>.from(state.mnemonicWords);
    words[e.index] = e.word;
    yield state.copy(
      mnemonicWords: words,
      creatingAddress: false,
    );
  }

  Stream<MnemonicInputBodyState> _mapChangeAccountsNumberToState(
    ChangeAccountsNumber e,
  ) async* {
    yield state.copy(accountsNumber: e.number);
  }

  Stream<MnemonicInputBodyState> _mapStartLoadingToState() async* {
    yield state.copy(loading: true);
  }
}
