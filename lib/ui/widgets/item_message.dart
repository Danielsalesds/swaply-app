import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:swaply/model/message_model.dart';

class MessageItem extends StatefulWidget {
  final Message message; // modelo Message
  final String currentUserId; // ID do usuário atual
  final String chatPartnerId; // ID do outro usuário na conversa

  const MessageItem({
    super.key,
    required this.message,
    required this.currentUserId,
    required this.chatPartnerId,
  });

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  @override
  Widget build(BuildContext context) {
    // Verifica se a mensagem foi enviada pelo usuário atual
    var isSender = widget.message.senderId == widget.currentUserId;

    // Verifica se a mensagem pertence à conversa (entre currentUserId e chatPartnerId)
    var isValidConversation = (widget.message.senderId == widget.currentUserId &&
            widget.message.receiverId == widget.chatPartnerId) ||
        (widget.message.senderId == widget.chatPartnerId &&
            widget.message.receiverId == widget.currentUserId);

    // Se a mensagem não pertence à conversa, retorna um widget vazio
    if (!isValidConversation) {
      return const SizedBox.shrink();
    }

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
