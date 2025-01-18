import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swaply/ui/widgets/custom_bottom_navigation_bar.dart';
import 'package:swaply/ui/widgets/initial_home.dart';
import 'package:swaply/ui/widgets/login_or_register_page.dart';
import 'package:swaply/ui/widgets/menu_home.dart';
import 'package:swaply/ui/widgets/section_cadastro_item.dart';  // Importe o seu widget personalizado

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
      //appBar: AppBar(title: const Text('Página Inicial')),
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
        return InitialHome();
      case 1:
        return const Text('Buscar');
      case 2:
        return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final User? user = snapshot.data;
                    return user == null ? const LoginOrRegisterPage() : const SectionCadastroItem();
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
                
              );
      case 3:
        return const Text('Mais');
      case 4:
        return const Text('Mensagens');
      case 5:
        return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final User? user = snapshot.data;
                    return user == null ? const LoginOrRegisterPage() : const MenuPage();
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              );
      default:
        return const Text('Página Inicial');
    }
  }
}
