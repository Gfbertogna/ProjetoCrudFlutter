import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditarProduto extends StatefulWidget {
  final String produtoId;

  EditarProduto({required this.produtoId});

  @override
  _EditarProdutoState createState() => _EditarProdutoState();
}

class _EditarProdutoState extends State<EditarProduto> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _quantidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getProduto();
  }

  Future<void> _getProduto() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('livros').doc(widget.produtoId).get();
    _nomeController.text = doc['nome'];
    _precoController.text = doc['preco'].toString();
    _quantidadeController.text = doc['quantidade'].toString();
  }

  void _updateProduto() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection('livros').doc(widget.produtoId).update({
        'nome': _nomeController.text,
        'preco': double.parse(_precoController.text),
        'quantidade': int.parse(_quantidadeController.text),
      }).then((_) {
        Navigator.pop(context); // Volta para a lista de produtos
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome do Produto'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o nome do produto.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precoController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o preço.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantidadeController,
                decoration: InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira a quantidade.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProduto,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
