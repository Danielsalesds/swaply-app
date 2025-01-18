import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Cor de destaque do ícone selecionado
        selectedItemColor: const Color(0xFFFF9800), 
        // Cor dos ícones não selecionados
        unselectedItemColor: Colors.grey, 
        currentIndex: selectedIndex,
        onTap: onItemSelected,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Anúncio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Mais',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mensagens',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}