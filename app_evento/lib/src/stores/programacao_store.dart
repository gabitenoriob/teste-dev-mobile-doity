import 'package:app_evento/src/apis/programacao_api.dart';
import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/models/programacao_model.dart';
import 'package:flutter/material.dart';

class ProgramacaoStore {
  final IProgramacao programacao;

  // loading
  final ValueNotifier<bool> isloading = ValueNotifier<bool>(false);

  // state
  final ValueNotifier<List<Horarios>> state = ValueNotifier<List<Horarios>>([]);

  // erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProgramacaoStore({required this.programacao});

  // Método para atualizar o estado
  void updateState(List<Horarios> newState) {
    state.value = newState;
  }

  // Método para limpar o estado de erro
  void clearError() {
    erro.value = '';
  }

  Future<void> getHorarios() async {
    isloading.value = true;
    try {
      final result = await programacao.getHorarios();
      updateState(result);
      clearError();
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    } finally {
      isloading.value = false;
    }
  }
}
