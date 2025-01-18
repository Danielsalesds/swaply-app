import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swaply/ui/widgets/routes.dart';

class UserProfilePage extends StatefulWidget {

  final VoidCallback onLogout; // Callback para o botão de logout

  const UserProfilePage({
    super.key,
    required this.onLogout,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    _checkUserSession();
  }

  Future<void> _checkUserSession() async {
    // Obtenha o usuário atual
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      // Se não houver usuário logado, redirecione para a página de login
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // Se o usuário estiver logado, atualize o estado
      setState(() {
        user = currentUser;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    

  final String? userPhotoUrl = user?.photoURL; // URL da foto do usuário, pode ser null
  final String userEmail = user?.email??'Emil não disponivel'; // Email do usuário

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do Usuário"),
        backgroundColor: const Color(0xFFFFA726),
        
      ),
      body: Container(
        color: Colors.white, // Fundo branco
        child: Column(
          children: [
            // Foto do usuário
            Container(
              margin: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 60, // Tamanho da imagem
                backgroundColor: Colors.grey.shade200, // Cor de fundo padrão
                backgroundImage:
                    userPhotoUrl != null ? NetworkImage(userPhotoUrl) : null,
                child: userPhotoUrl == null
                    ? const Icon(Icons.person, size: 60, color: Colors.grey)
                    : null, // Ícone de perfil padrão se não houver imagem
              ),
            ),

            // Linha de separação
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),

            // Informações do usuário
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.email, color: Color(0xFF000000)), // Ícone do email
                  const SizedBox(width: 16),
                  Text(
                    userEmail,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(), // Empurra o botão de logout para o final da página

            // Botão de logout
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  
                   setState(() {
                    user = null; // Limpa a variável user para simular o logout
                  });
                  Navigator.pushReplacementNamed(context, ConfigRoutes.home);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF212121),
                  minimumSize: const Size(double.infinity, 50), // Largura total
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
