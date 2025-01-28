

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swaply/model/item_model.dart';
import 'package:swaply/model/message_model.dart';
import 'package:swaply/services/auth-service.dart';
import 'package:swaply/services/firestore_service.dart';
import 'package:swaply/ui/widgets/custom_text_form_message.dart';
import 'package:swaply/ui/widgets/item_message.dart';

class ChatPage extends StatefulWidget {
  final ItemModel item;
  const ChatPage({
    super.key, 
    required this.item
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();
  late final AuthService authService;
  late final FirestoreService firebaseFirestore = FirestoreService();
  final List<Message> listMassageUser = [];
  late String idChat;
  User?user;

  @override
  void initState() {
    super.initState();
    authService = Provider.of<AuthService>(context, listen:false);
    idChat = generateChatId(authService.auth.currentUser!.uid, widget.item.id, widget.item.userId);
  }
//Gerar ChatId
  String generateChatId(String currentUserId, String itemId, String partnerUserId) {
  // Cria uma lista com os IDs
  List<String> ids = [currentUserId, partnerUserId];
  // Ordena os IDs para garantir consistência
  ids.sort();
  // Gera o chatId baseado no itemId e nos IDs ordenados
  return '${itemId}_${ids.join("_")}';
}


  Future<void> sendMessage(String chatId) async {
    if (_messageController.text.isNotEmpty) {
      try {
         // Verificar se o currentUser está autenticado e obter o uid
        String currentUserId = authService.auth.currentUser?.uid ?? '';
        if (currentUserId.isEmpty) {
          // Se o usuário não estiver autenticado, você pode lidar com isso aqui
          print('Usuário não autenticado');
          
          return;
        }

        // Gerar o chatId com os IDs dos usuários
        
        // Chamando diretamente o método do FirestoreService
        await firebaseFirestore.sendMessage(
          _messageController.text, // Texto da mensagem
          widget.item.id,      // ID do  item 
          widget.item.userId, //usuario que cadastrou o item (receiverId)
          chatId
        );
        print('IDITEM: ${widget.item.id}');
        print('IDITEMUser: ${widget.item.userId}');
        print('ID_DO_CHAT: $chatId');

        _messageController.clear(); // Limpa o campo de texto após o envio
      } catch (e) {
        print("Erro ao enviar mensagem: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao enviar mensagem: $e")),
        );
      }
    }
  }
  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat",
        ),
        backgroundColor: const Color(0xFFFFA726),
      ),
      //corpo 
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: firebaseFirestore.getMessagesForItemAndUsers(widget.item.id, widget.item.userId, authService.auth.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text("Um erro ocorreu. ${snapshot.error}"); 
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("Nenhuma mensagem encontrada."));
                }
                return ListView(
                  reverse: true, // Mostra as mensagens mais recentes no final
                  children: snapshot.data!.docs.map((document) {
                      final message = Message.fromMap(document.data() as Map<String, dynamic>);  
                      
                      print(">>>>>>>>>>>enviado iduser${message.senderId}");
                      print(">>>>>>>>>>>enviado iduser${message.receiverId}");
                      return MessageItem(
                        
                        itemId: widget.item.id,
                        message: message,
                        currentUserId: authService.getCurrentUser(),
                        chatPartnerId: widget.item.userId,
                      );
                    }).toList(),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFormMessage(
                  labelText: "Digite...",
                  controller: _messageController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Color(0xFFFFA726),
                  child: IconButton(
                    onPressed: () {
                      sendMessage(idChat);
                    },
                      icon: const Icon(
                        Icons.send,
                        color: Color.fromARGB(255, 243, 243, 243),
                      ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
 }
}