import 'package:flutter/material.dart';

void main() {
  runApp(BytebanckApp());
}

class BytebanckApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Tranferência'),
      ),  
      body: Column(
        children: [
          Editor(controlador: _controladorCampoNumeroConta, rotulo: 'Número da conta', dica: '0000'),
          Editor(controlador: _controladorCampoValor, rotulo: 'Valor', dica: '0.00', icone: Icons.monetization_on),
          ElevatedButton(
            onPressed: () => _criaTranferencia(context),
            child: Text('Confirmar')
          )
        ],
      )
    );
  }

  void _criaTranferencia(context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {

  final TextEditingController? controlador ;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  Editor({ this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controlador,
              style: TextStyle(
                fontSize: 24.0,
              ),
              decoration: InputDecoration(
                labelText: rotulo,
                hintText: dica,
                icon: icone != null ? Icon(icone) : null,
              ),
              keyboardType: TextInputType.number,
            ),
          );
          
  }
}

class ListaTransferencia extends StatelessWidget {
  final List<Transferencia> _transferencias = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = _transferencias[indice];
          return ItemTransferencia(transferencia);
        },
        // children: [
        //   ItemTransferencia(Transferencia(100, 1000)),
        //   ItemTransferencia(Transferencia(200, 1000)),
        //   ItemTransferencia(Transferencia(300, 1000)),
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
            final Future future = Navigator.push(context, MaterialPageRoute(builder: (context) => FormularioTransferencia()));
            future.then((transferenciaRecebida) {
            debugPrint('$transferenciaRecebida');
            _transferencias.add(transferenciaRecebida);
          });
        }
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
