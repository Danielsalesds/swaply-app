import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swaply/ui/widgets/login_or_register_page.dart';

class RequireLogin extends StatelessWidget {
  final Widget loggedInScreen; // Tela para onde redirecionar se o usuário estiver logado
  final VoidCallback? onNotLoggedIn; // Ação adicional caso não esteja logado

  const RequireLogin({
    super.key,
    required this.loggedInScreen,
    this.onNotLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Executa uma ação adicional (opcional) se o usuário não estiver logado
      if (onNotLoggedIn != null) {
        onNotLoggedIn!();
      }

      // Redireciona para a página de login/cadastro
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()),
        );
      });
      // Retorna um widget vazio enquanto redireciona
      return const SizedBox.shrink(); 
    }

    // Redireciona para a tela do usuário logado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => loggedInScreen),
      );
    });
    // Retorna um widget vazio enquanto redireciona
    return const SizedBox.shrink(); 
  }
}
