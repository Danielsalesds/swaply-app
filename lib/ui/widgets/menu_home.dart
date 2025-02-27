import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swaply/services/auth-service.dart';
import 'package:swaply/ui/pages/user_profile_page.dart';
import 'package:swaply/ui/widgets/list_anuncio_user.dart';
import 'package:swaply/ui/widgets/routes.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    // Obter o usuário autenticado
    final user = FirebaseAuth.instance.currentUser;
    final authService = Provider.of<AuthService>(context, listen: false);
    // Pegar informações do usuário
    final userPhotoUrl = user?.photoURL;
    final userEmail = user?.email ?? "Email não disponível";
    //  opções do menu dentro do `build`, para que o `context` esteja acessível
    final List<MenuOption> menuOptions = [
      MenuOption(
        icon: Icons.person,
        title: 'Minha Conta',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfilePage(
                onLogout: () {
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> const ListAnuncioUser(),),
          );
        },
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
        backgroundColor: const Color(0xFFFFA726),
      ),
      body: Container(
        padding: const EdgeInsets.all(0), // Para adicionar espaçamento interno ao Container
        color: Colors.white,
        child: ListView.builder(
          itemCount: menuOptions.length,
          itemBuilder: (context, index) {
            final option = menuOptions[index];
            return ListTile(
              tileColor: Colors.white,
              leading: Icon(option.icon, color: const Color(0xFF000000)), // Ícone à esquerda
              title: Text(
                option.title,
                style: const TextStyle(fontSize: 16),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ), // Seta ">" à direita
              onTap: option.onTap,
            );
          },
        ),
      )

    );
  }
}

class MenuOption {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  MenuOption({required this.icon, required this.title, required this.onTap});
}
