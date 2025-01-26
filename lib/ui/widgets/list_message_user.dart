import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swaply/model/message_model.dart';
import 'package:swaply/services/firestore_service.dart';

class MessageListWidget extends StatefulWidget {
  MessageListWidget({super.key});

  @override
  State<MessageListWidget> createState() => _MessageListWidgetState();
}

class _MessageListWidgetState extends State<MessageListWidget> {
  final List<Message> listMessageUser = [];
  final currentUser = FirebaseAuth.instance.currentUser;
  final FirestoreService firestoreService = FirestoreService();

  User? user;

  @override
  void initState() {
    super.initState();
    fetchMessageUser();
  }

  Future<void> fetchMessageUser() async {
    try {
      setState(() {
        user = currentUser;
      });
      final listMessage = firestoreService.getUserConversations(user!.uid);
      setState(() {
        listMessageUser.addAll(listMessage as Iterable<Message>);
      });
    } catch (e) {
      throw Exception('Erro ao carregar Itens do Usuario.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversas"),
          backgroundColor: const Color(0xFFFFA726),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getUserConversations(user!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar mensagens: ${snapshot.error}"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Nenhuma conversa encontrada."));
          }

          final messages = snapshot.data!.docs;

          // Agrupa por senderId para obter conversas únicas
          final conversations = <String, Map<String, dynamic>>{};
          for (var doc in messages) {
            final data = doc.data() as Map<String, dynamic>;
            final senderId = data['senderId'] ?? '';
            if (!conversations.containsKey(senderId)) {
              conversations[senderId] = data;
            }
          }

          return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final senderId = conversations.keys.elementAt(index);
              final conversationData = conversations[senderId]!;
              final senderEmail = conversationData['senderEmail'] ?? "Usuário desconhecido";
              final itemImage = conversationData['itemImage'] ?? ''; // URL da imagem, se existir
              final itemName = conversationData['itemName'] ?? 'Item não identificado';

              return GestureDetector(
                onTap: () {
                  // Ao clicar no card, navega para o chat
                  print("Conversa com:$senderEmail");
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color.fromARGB(179, 71, 71, 71), // Cor da borda
                      width: 1, // Espessura da borda
                    ),
                  ),
                  color: Colors.transparent, // Fundo transparente
                  elevation: 0, // Leve elevação
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    children: [
                      // Imagem do item (ou padrão)
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: itemImage.isNotEmpty
                                ? NetworkImage(itemImage)
                                : const AssetImage('assets/item_default.jpg') as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Texto com o email do remetente
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              senderEmail,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              itemName,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(179, 155, 154, 154),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white70,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
