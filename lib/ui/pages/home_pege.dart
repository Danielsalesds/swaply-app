import 'package:flutter/material.dart';
import 'package:swaply/ui/widgets/custom_bottom_navigation_bar.dart';  // Importe o seu widget personalizado

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Índice do item selecionado no BottomNavigationBar
  int _selectedIndex = 0;  

  // Função que será chamada quando um item for selecionado
  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página Inicial')),
      body: Center(
        // Aqui você pode retornar diferentes widgets dependendo do item selecionado
        child: _getSelectedPage(),  
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
      ),
    );
  }

  // Função para exibir a tela correspondente ao item selecionado
  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return const Text('Página Inicial');
      case 1:
        return const Text('Buscar');
      case 2:
        return const Text('Anunciar');
      case 3:
        return const Text('Mais');
      case 4:
        return const Text('Mensagens');
      case 5:
        return const Text('Menu');
      default:
        return const Text('Página Inicial');
    }
  }
}