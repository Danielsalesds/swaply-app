import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swaply/services/auth-service.dart';
import 'package:swaply/ui/widgets/routes.dart'; // Supondo que existe uma página de formulário de itens

class SectionCadastroItem extends StatefulWidget {
  const SectionCadastroItem({super.key});

  @override
  State<SectionCadastroItem> createState() => _SectionCadastro();
}

class _SectionCadastro extends State<SectionCadastroItem> {
  @override
  Widget build(BuildContext context) {
    // Obter o usuário autenticado
    final user = FirebaseAuth.instance.currentUser;
    final authService = Provider.of<AuthService>(context, listen: false);

    // Defina as opções do menu dentro do `build`, para que o `context` esteja acessível
    final List<MenuOption> menuOptions = [
      MenuOption(
        icon: Icons.book,
        title: 'Livros',
        onTap: () {
          Navigator.pushNamed(
            context,
            ConfigRoutes.itemForm,
          );
        },
      ),
      MenuOption(
        icon: Icons.category,
        title: 'Objetos em geral',
        onTap: () {
          Navigator.pushNamed(
            context,
            ConfigRoutes.itemForm,
          );
        },
      ),
      MenuOption(
        icon: Icons.devices_other,
        title: 'Celulares, computadores, eletrônicos em geral',
        onTap: () {
          Navigator.pushNamed(
            context,
            ConfigRoutes.itemForm,
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserir Item"),
        backgroundColor: const Color(0xFFFFA726),
      ),
      body: Container(
        padding: const EdgeInsets.all(0),
        color: Colors.white,
        child: ListView.builder(
          itemCount: menuOptions.length,
          itemBuilder: (context, index) {
            final option = menuOptions[index];
            return ListTile(
              tileColor: Colors.white,
              leading: Icon(option.icon, color: const Color(0xFF000000)),
              title: Text(
                option.title,
                style: const TextStyle(fontSize: 16),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              onTap: option.onTap,
            );
          },
        ),
      ),
    );
  }
}

class MenuOption {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  MenuOption({required this.icon, required this.title, required this.onTap});
}
