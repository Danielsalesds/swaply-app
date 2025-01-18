import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swaply/services/auth-service.dart';
import 'package:provider/provider.dart';
import 'package:swaply/services/firestore_service.dart';
import 'package:swaply/ui/widgets/error_message.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_password_form_field.dart';
import '../widgets/custom_text_form_field.dart';
import 'package:swaply/model/user_model.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key, this.onTap});
  final void Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final repSenhaController = TextEditingController();
  String? errorMessage;


  void signUp() async{
    if(senhaController.value.text != repSenhaController.value.text){
      setState(() {
        errorMessage = 'Certifique-se de que os campos de senha sejam iguais.';
      });
      return;
    }
    final AuthService authService = Provider.of<AuthService>(context, listen:false);
    final FirestoreService firebaseFirestore = FirestoreService();
    try {
      UserCredential credential = await authService.createUserAccount(emailController.value.text, senhaController.value.text);

      // Crie o UserModel com os dados necessários
      final userModel = UserModel(
        id: credential.user!.uid,
        name: '',
        email: emailController.value.text,
        photoUrl: credential.user?.photoURL,
        idMensagem: '',
        idItens: []
      );
      await firebaseFirestore.addUserModel(credential.user!.uid, userModel);
      // Limpa a mensagem de erro após o login bem-sucedido
      errorMessage = null;
    }on Exception catch (e) {
       setState(() {
          // Atualiza a mensagem de erro
          errorMessage = e.toString();
          // Remover o prefixo 'Exception:' da mensagem
          if (errorMessage!.startsWith('Exception:')) {
            // Remover os 9 primeiros caracteres "Exception:"
            errorMessage = errorMessage?.substring(10); 
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (errorMessage != null) ErrorMessage(message: errorMessage!),
          // Logo na parte superior
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Image.asset('assets/swaply-logo.png', height: 100),
          ),
          CustomTextFormField(label: 'Email',controller:emailController),
          const SizedBox(height: 5),
          CustomPasswordFormField(labelText: "Senha", controller: senhaController),
          const SizedBox(height: 5),
          CustomPasswordFormField(labelText: "Confirmar Senha", controller: repSenhaController),
          const SizedBox(height: 55),
          CustomButton(height: 75, width: 320, text: "Cadastrar", onClick: signUp),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: widget.onTap,
            child: Text(
              "Entrar agora.",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          )
        ]

      ),
    );
  }


}