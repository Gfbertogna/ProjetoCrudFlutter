import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetocrud/editarProduto.dart';

class ListaProdutos extends StatelessWidget {
  final CollectionReference produtos = FirebaseFirestore.instance.collection('livros');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Produtos')),
      body: StreamBuilder<QuerySnapshot>(
        stream: produtos.snapshots(), // Obtendo dados em tempo real
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar produtos'));
          }

          // Lista de documentos
          final produtosList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: produtosList.length,
            itemBuilder: (context, index) {
              final produto = produtosList[index];
              return ListTile(
                title: Text(produto['nome']),
                subtitle: Text('Preço: R\$${produto['preco']} - Quantidade: ${produto['quantidade']}'),
                leading: produto['imagem'] != null
                    ? Image.network(produto['imagem'], width: 50, fit: BoxFit.cover)
                    : null,
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'view',
                      child: Text('Ver Detalhes'),
                    ),
                    PopupMenuItem(
                      value: 'edit',
                      child: Text('Editar'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Deletar'),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'view') {
                      _viewProduct(context, produto);
                    } else if (value == 'edit') {
                      _editProduct(context, produto);
                    } else if (value == 'delete') {
                      _deleteProduct(produto.id);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _viewProduct(BuildContext context, QueryDocumentSnapshot produto) {
    // Navegar para a tela de detalhes do produto
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(produto['nome']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(produto['imagem']),
            SizedBox(height: 10),
            Text('Preço: R\$${produto['preco']}'),
            Text('Quantidade: ${produto['quantidade']}'),
            Text('Descrição: ${produto['descricao']}'), // Supondo que a descrição esteja no Firestore
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _editProduct(BuildContext context, QueryDocumentSnapshot produto) {
    // Aqui você pode implementar a lógica para editar o produto
    // Pode usar um Navigator para abrir um novo formulário de edição
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarProduto(produtoId: produto.id),
      ),
    );
  }

  void _deleteProduct(String produtoId) {
    // Lógica para deletar o produto
    produtos.doc(produtoId).delete().then((_) {
      print("Produto deletado com sucesso");
    }).catchError((error) {
      print("Falha ao deletar produto: $error");
    });
  }
}
