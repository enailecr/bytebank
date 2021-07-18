import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'lista.dart';

class UltimasTransferencias extends StatelessWidget {
  final _titulo = 'Últimas transferências';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          _titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        Consumer<Transferencias>(builder: (context, transferencias, child) {
          final _ultimasTransferencias =
              transferencias.transferencias.reversed.toList();
          final _quantidade = _ultimasTransferencias.length;
          if (_quantidade == 0) {
            return SemTransferenciaCadastrada();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _quantidade < 3 ? _quantidade : 2,
            shrinkWrap: true,
            itemBuilder: (context, indice) {
              return ItemTransferencia(_ultimasTransferencias[indice]);
            },
          );
        }),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ListaTransferencia()));
          },
          child: Text('Transferências'),
        ),
      ],
    );
  }
}

class SemTransferenciaCadastrada extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Você ainda não cadastrou nenhuma transferência',
            textAlign: TextAlign.center,
          )),
    );
  }
}
