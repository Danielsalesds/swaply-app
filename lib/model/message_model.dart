import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  //final String id; // ID único para a mensagem
  final String senderId; // ID do remetente
  final String itemId; //ID 
  final String senderEmail; // E-mail do remetente
  final String receiverId; // ID do destinatário
  final String  chatId;
  final String message; // Conteúdo da mensagem
  final Timestamp timestamp; // Data e hora

  Message({
    //required this.id,
    required this.itemId,
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.chatId,
    required this.message,
    required this.timestamp,
  });
 
  // Método para converter um Map em uma instância de Message
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      itemId: map['itemId'] as String,
      senderId: map['senderId'] as String,
      senderEmail: map['senderEmail'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      timestamp: map['timestamp'] as Timestamp, 
      chatId: map['chatId'] as String,
      //itemId: '',
    );
  }
 
  //converte uma instancia em um map
  Map<String, dynamic> toMap() {
    return {
      
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'chatId': chatId,
      'message': message,
      'itemId': itemId,
      'timestamp': timestamp,
    };
  }
}
