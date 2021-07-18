import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioDeposito extends StatelessWidget {
  final _tituloAppBar = 'Receber depósito';
  final _dicaCampoValor = '0.00';
  final _rotuloCampoValor = 'Valor';
  final _textoBotaoConfirmar = 'Confirmar';
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Editor(
                controlador: _controladorCampoValor,
                rotulo: _rotuloCampoValor,
                dica: _dicaCampoValor,
                icone: Icons.monetization_on,
              ),
              ElevatedButton(
                onPressed: () => _criaDeposito(context),
                child: Text(_textoBotaoConfirmar),
              ),
            ],
          ),
        ));
  }

  _criaDeposito(context) {
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (_validaDeposito(valor)) {
      _atualizaEstado(context, valor);
      Navigator.pop(context);
    }
  }

  _validaDeposito(valor) {
    print('VALOR $valor');
    final _campoPreenchido = valor != null;
    return _campoPreenchido;
  }

  _atualizaEstado(context, valor) {
    Provider.of<Saldo>(context, listen: false).adiciona(valor);
  }
}
