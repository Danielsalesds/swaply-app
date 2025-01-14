import 'package:flutter/material.dart';
import 'package:swaply/services/auth-service.dart';
import 'package:swaply/ui/widgets/custom_text_form_field.dart';
import 'package:swaply/ui/widgets/custom_password_form_field.dart';
import 'package:swaply/ui/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:swaply/ui/widgets/error_message.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key, this.onTap});
  final void Function()? onTap;

  @override
  State<StatefulWidget> createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage>{
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  String? errorMessage;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passWordController.dispose();
  }
  //entrar com conta egistente 
  void signIn() async{
    final authService = Provider.of<AuthService>(context, listen: false);
    try{
      await authService.signIn(emailController.value.text, passWordController.value.text);
      setState(() {
        // Limpa a mensagem de erro após o login bem-sucedido
        errorMessage = null; 
      });
    }catch (e){
      setState(() {
        errorMessage = e.toString(); // Atualiza a mensagem de erro
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
          
          //formulario de loguin customizado
          CustomTextFormField(label: 'Email',controller:emailController),
          const SizedBox(height: 5),
          CustomPasswordFormField(labelText: "Senha", controller: passWordController),
          const SizedBox(height: 55),
          CustomButton(height: 75, width: 320, text: "Logar", onClick: signIn),
          GestureDetector(
            onTap: widget.onTap,
            child: Text(
              "Cadastre-se.",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          )
        ],
      ),
    );
  }
}