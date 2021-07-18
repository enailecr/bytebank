import 'package:flutter/material.dart';

class Saldo extends ChangeNotifier {
  double valor;

  Saldo(this.valor);

  void adiciona(double valor) {
    this.valor += valor;

    //obrigatorio p/atualizar campo na tela
    notifyListeners();
  }

  void subtrai(double valor) {
    this.valor -= valor;

    notifyListeners();
  }

  @override
  String toString() {
    return 'R\$ $valor';
  }
}
