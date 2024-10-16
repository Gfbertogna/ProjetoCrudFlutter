import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetocrud/ListaProdutos.dart';

class CadProduto extends StatefulWidget {
  @override
  _CadProdutoState createState() => _CadProdutoState();
}

class _CadProdutoState extends State<CadProduto> {
  final _formKey = GlobalKey<FormState>();
  String? _nome;
  double? _preco;
  int? _quantidade;
  String? _descricao;
  String? _imagem;

  // Referência do Firestore
  final CollectionReference livros = FirebaseFirestore.instance.collection('livros');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Produto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (value) => _nome = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (value) => _preco = double.tryParse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (value) => _quantidade = int.tryParse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (value) => _descricao = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Imagem URL'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                onSaved: (value) => _imagem = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _cadastrarProduto,
                child: Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _cadastrarProduto() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Adicionando o produto ao Firestore
      await livros.add({
        'nome': _nome,
        'preco': _preco,
        'quantidade': _quantidade,
        'descricao': _descricao,
        'imagem': _imagem,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Produto cadastrado!')));
      _formKey.currentState!.reset();

      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ListaProdutos()),
    );
    }
  }
}
