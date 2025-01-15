import 'package:firebase_auth/firebase_auth.dart';


//Serviço de authentication do app com FireBase
class AuthService{
  final FirebaseAuth auth = FirebaseAuth.instance;
  //Criar usuario com email e senha
  Future<UserCredential> createUserAccount (String email, String password) async {
    try{
      UserCredential credential = await  auth
        .createUserWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      //throw Exception(e.message);
      // Verificar o código do erro e mostrar a mensagem correspondente
      print(e.code);
      switch(e.code){
        case 'invalid-email':
          throw Exception('E-mail invalido. Informe um e-mail valído.');
        case 'weak-password':
          throw Exception('A senha é muito fraca.');
        case 'email-already-in-use':
          throw Exception('Este e-mail já está cadastrado. Tente outro e-mail.');
        case 'channel-error':
          throw Exception('Campos vazios. Preencha e tente novamente.');
        default :
          throw Exception('Ocorreu um erro desconhecido: ${e.message}');
      }
    }
  }
  //Fazer login com email e senha 
  Future<UserCredential> signIn (String email, String password) async {
    try{
      UserCredential credential = await auth
        .signInWithEmailAndPassword(email: email, password: password);
        return credential;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch(e.code){
        case 'invalid-credential':
          throw Exception('Credenciais inválidas. Usuario não cadastrado ou senha invalida.');
        case 'wrong-password':
          throw Exception('Senha incorreta. Verifique sua senha.');
        case 'user-disabled':
          throw Exception('Sua conta foi desativada. Contate o administrador.');
        case 'invalid-email':
          throw Exception('E-mail invalido. Tente novamente');
        case 'channel-error':
          throw Exception('Campos vazios. Preencha e tente novamente.');
        default:
          throw Exception('Ocorreu um erro desconhecido: ${e.message}');
      }
    }
  }
  //Recuperar conta pelo email
  Future <void> restPassword (String email) async {
    try {

    }on FirebaseAuthException catch (e){
      switch (e.code) {
        case 'user-not-found':
          throw Exception('Nenhuma conta encontrada com esse e-mail. Verifique o e-mail fornecido.');
        case 'invalid-email':
          throw Exception('O e-mail fornecido é inválido.');
        default:
          throw Exception('Erro desconhecido ao tentar enviar o e-mail de recuperação: ${e.message}');
      }
    }catch (e){throw Exception('Erro ao enviar e-mail de recuperação: $e');}
  }
   String getCurrentUser(){
    return auth.currentUser!.uid;
  }
  String? getCurrentUserEmail(){
    return auth.currentUser!.email;
  }
  Future<void> signOut() async{
    return await auth.signOut();
  }
}