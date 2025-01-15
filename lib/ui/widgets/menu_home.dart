import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swaply/services/auth-service.dart';
import 'package:swaply/ui/pages/user_profile_page.dart';

class MenuPage extends StatelessWidget {
  MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Obter o usuário autenticado
    final user = FirebaseAuth.instance.currentUser;
    // Pegar informações do usuário
    final userPhotoUrl = user?.photoURL;
    final userEmail = user?.email ?? "Email não disponível";
    // Defina as opções do menu dentro do `build`, para que o `context` esteja acessível
    final List<MenuOption> menuOptions = [
      MenuOption(
        icon: Icons.person,
        title: 'Minha Conta',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfilePage(
                userPhotoUrl: userPhotoUrl,
                userEmail: userEmail,
                onLogout: () {
                  final authService =
                      Provider.of<AuthService>(context, listen: false);
                  authService.signOut();
                },
              ),
            ),
          );
        },
      ),
      MenuOption(
        icon: Icons.ads_click,
        title: 'Meus Anúncios',
        onTap: () => print('Meus Anúncios'),
      ),
      MenuOption(
        icon: Icons.info,
        title: 'Sobre',
        onTap: () => print('Sobre'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: menuOptions.length,
        itemBuilder: (context, index) {
          final option = menuOptions[index];
          return ListTile(
            tileColor: Colors.white,
            leading: Icon(option.icon, color: Colors.blue), // Ícone à esquerda
            title: Text(
              option.title,
              style: const TextStyle(fontSize: 16),
            ),
            trailing:
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey), // Seta ">" à direita
            onTap: option.onTap,
          );
        },
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
