import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  //final String id; // ID único para a mensagem
  final String senderId; // ID do remetente
  final String senderEmail; // E-mail do remetente
  final String receiverId; // ID do destinatário
  final String message; // Conteúdo da mensagem
  final Timestamp timestamp; // Data e hora

  Message({
    //required this.id,
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });
  // Método para converter um Map em uma instância de Message
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] as String,
      senderEmail: map['senderEmail'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      timestamp: map['timestamp'] as Timestamp,
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
