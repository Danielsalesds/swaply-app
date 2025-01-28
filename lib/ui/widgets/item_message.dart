import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swaply/model/message_model.dart';
import 'package:swaply/services/auth-service.dart';
import 'package:swaply/services/firestore_service.dart';

class MessageItem extends StatefulWidget {
  final Message message; // modelo Message
  final String currentUserId; // ID do usuário atual
  final String chatPartnerId; // ID do outro usuário na conversa
  final String itemId;

  const MessageItem({
    super.key,
    required this.itemId,
    required this.message,
    required this.currentUserId,
    required this.chatPartnerId,
  });

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
    late final FirestoreService firebaseFirestore = FirestoreService();
    late final AuthService authService;
 @override
  void initState() {
    super.initState();
    authService = Provider.of<AuthService>(context, listen:false);
  }
  @override
  Widget build(BuildContext context) {
    // Verifica se a mensagem foi enviada pelo usuário atual
    var isSender = widget.currentUserId == widget.message.senderId;
    print("Sender ID: ${widget.message.senderId}");
    print("Current User ID: ${widget.currentUserId}");


   

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // Borda de espaçamento no lado oposto do remetente
          if (!isSender) const SizedBox(width: 50),
          // Bubble da mensagem
          Flexible(
            child: BubbleNormal(
              text: widget.message.message,
              isSender: isSender,
              color: isSender
                  ? const Color(0xFFFFA929) // Laranja suave para mensagem enviada
                  : const Color(0xFFC8E6C9), // Cinza claro para mensagem recebida
              textStyle: TextStyle(
                color: isSender
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : const Color.fromARGB(255, 0, 0, 0),
              ),
              padding: const EdgeInsets.all(0),
            ),
          ),
          // Borda de espaçamento no lado oposto do remetente
          if (isSender) const SizedBox(width: 50),
        ],
      ),
    );
  }
}
