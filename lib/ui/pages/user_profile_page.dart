import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final String? userPhotoUrl; // URL da foto do usuário, pode ser null
  final String userEmail; // Email do usuário
  final VoidCallback onLogout; // Callback para o botão de logout

  const UserProfilePage({
    super.key,
    this.userPhotoUrl,
    required this.userEmail,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do Usuário"),
        backgroundColor: Colors.blue,
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
                    userPhotoUrl != null ? NetworkImage(userPhotoUrl!) : null,
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
                  const Icon(Icons.email, color: Colors.blue), // Ícone do email
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
                onPressed: onLogout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
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
