import 'package:flutter/material.dart';
import 'cadProduto.dart'; // Importando a página de cadastro de produto
import 'listaProdutos.dart'; // Importando a página de lista de produtos
import 'menu.dart'; // Importando a página do menu principal

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CadProduto()),
                );
              },
              child: Text('Cadastro de Produto'),
            ),
            SizedBox(height: 20), // Espaço entre os botões
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaProdutos()), // Substitua pelo seu arquivo de lista de produtos
                );
              },
              child: Text('Lista de Produtos'),
            ),
            
          ],
        ),
      ),
    );
  }
}
