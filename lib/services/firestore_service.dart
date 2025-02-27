import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swaply/model/item_model.dart';
import 'package:swaply/model/message_model.dart';
import 'package:swaply/model/user_model.dart';


class FirestoreService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //final NotificationService _notificationService = NotificationService();

  Future<void> addUser(String id,String email) async {
    await FirebaseFirestore.instance.collection('users').doc(id).set({
    'email': email,
    'uid': id,
    'createdAt': FieldValue.serverTimestamp(),
    });
  }
  Future<void> addUserModel(String id, UserModel userModel) async {
    await FirebaseFirestore.instance.collection('users').doc(id).set(userModel.toMap());
  }
  Future<void> getUser(String id) async {
    final DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('users').doc(id).get();
    if (userDoc.exists) {
    print(userDoc.data());
    }
  }
  //Obter Todos os Documentos de uma Coleção
  Future<void> getAllUsers() async {
    final QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('users').get();
    for (var doc in querySnapshot.docs) {
    print(doc.data());
    }
  }
  //Atualizar Campos Específicos
 /// Atualiza os dados do usuário no Firestore utilizando o UserModel
  Future<void> updateUserModel(UserModel userModel) async {
    try {
      await _firestore.collection('users').doc(userModel.id).update(userModel.toMap());
    } catch (e) {
      throw Exception("Erro ao atualizar o usuário: $e");
    }
  }

  //Retorna lista de itens que atualiza automaticamente quando a coleção no Firestore muda.
  Stream<DocumentSnapshot> getDocuments(String colecao, String id){
    return _firestore.collection(colecao).doc(id).snapshots();
  }
  //atualiza um documento existente no Firestore de acordo com id
  Future<void> updateDocument(String colecao, String id, Map<String, dynamic> updates)async{
    await _firestore.collection(colecao).doc(id).update(updates);
  }
  //Escuta uma coleção para mudanças em tempo real e retorna todos os documentos da coleção.
  Stream<QuerySnapshot> getAll(String colecao) {
    return _firestore.collection(colecao).snapshots();
  }
  //Retorna o valor de um campo específico dentro desse documento de uma coleção no fireBase
  Future<String> getData(String colecao,String id, String campo) async {
    final DocumentSnapshot userDoc =
    await _firestore.collection(colecao).doc(id).get();
    return userDoc.get(campo).toString();
  }
  //Busca um documento específico pela chave (ID) e retorna um campo mantendo seu tipo original no Firestore
  Future<dynamic> getData2(String colecao,String id, String campo) async {
    final DocumentSnapshot userDoc =
    await _firestore.collection(colecao).doc(id).get();
    return userDoc.get(campo);
  }

  //-------------ITENS------------------
  //Salvar Item no banco
  Future<void> addItem(ItemModel itemModel) async {
    try {
      await FirebaseFirestore.instance.collection('itens').add(itemModel.toMap());
    } catch (e) {
      throw Exception("Erro ao atualizar o usuário: $e");
    }
  }
  //buscar todos os itens no banco
  Future<List<ItemModel>> getAllItems() async {
  try {
    // Busca todos os documentos da coleção "itens"
    final querySnapshot = await FirebaseFirestore.instance.collection('itens').get();
    // Converte os documentos para uma lista de objetos ItemModel
    return querySnapshot.docs.map(
      (doc) => ItemModel.fromMap(doc.id, doc.data())).toList();
    } catch (e) {
      throw Exception("Erro ao buscar itens: $e");
    }
  }
  //buscar lista de itens por id especifico
  Future <List<ItemModel>> getItemsId (String userId) async {
    try{
      final querySnapShot = await _firestore.collection('itens').where('userId' ,isEqualTo: userId).get();
      if (querySnapShot.docs.isEmpty) {
      // Caso a consulta não encontre itens, você pode lançar uma exceção
      throw Exception('Nenhum item encontrado para o usuário.');
      }
      return querySnapShot.docs.map(
        (doc)=> ItemModel.fromMap(doc.id, doc.data())
      ).toList();
      //tratar lista vazia

    }catch (e){
      throw Exception('Erro buscar itens do usuario.$e');
    }
  }
  //buscar unico item por id
  Future<ItemModel> getItemById(String itemId) async {
  try {
    // Busca o documento na coleção 'itens' pelo ID informado
    final docSnapshot = await _firestore.collection('itens').doc(itemId).get();

    // Verifica se o documento existe
    if (!docSnapshot.exists) {
      throw Exception('Item com o ID $itemId não encontrado.');
    }

    // Converte o documento encontrado para o modelo ItemModel
    return ItemModel.fromMap(docSnapshot.id, docSnapshot.data()!);
  } catch (e) {
    // Lança uma exceção caso algo dê errado
    throw Exception('Erro ao buscar o item pelo ID. Detalhes: $e');
  }
}

  //Cadastrar conversas
  Future<void> sendMessage(String message, String itemId, String idUserItem, String chatId) async {
    final String senderId = _firebaseAuth.currentUser!.uid;
    final String senderEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    Message newMessage = Message(
      senderId: senderId,
      senderEmail: senderEmail,
      chatId: chatId,
      message: message,
      timestamp: timestamp, 
      receiverId: idUserItem,
      itemId: itemId, 
    );

    await _firestore.collection("messages").add(newMessage.toMap());
    print("Mensagem enviada com sucesso.$chatId");
    
  }
  //Buscar todas as menssagens
  Stream<QuerySnapshot> getMessages() {
    return _firestore
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
  //buscar messages filtrando por user logado, dono do item e id do item
  Stream<QuerySnapshot> getMessagesForItemAndUsers(
    String itemId, String otherUserId, String currentUserId) {
      
    return FirebaseFirestore.instance
      .collection('messages')
     // .where('itemId', isEqualTo: itemId)
      .where('senderId', whereIn: [otherUserId, currentUserId])  // Filtra por ambos os usuários
      .where('receiverId', whereIn: [currentUserId, otherUserId])// filtrar por ambos os usuários
      .orderBy('timestamp', descending: true) // Para ordenar pela data
      .snapshots();
}
//Buscar message combinadas de 2 usuarios
Stream<List<QueryDocumentSnapshot>> combineMessagesStreams(
  String itemId, 
  String otherUserId
) {
  final String currentUserId = _firebaseAuth.currentUser!.uid;
  final messagesFromCurrentUser = FirebaseFirestore.instance
      .collection('messages')
      .where('itemId', isEqualTo: itemId)
      .where('senderId', isEqualTo: currentUserId)
      .where('receiverId', isEqualTo: otherUserId)
      .snapshots();

  final messagesFromOtherUser = FirebaseFirestore.instance
      .collection('messages')
      .where('itemId', isEqualTo: itemId)
      .where('senderId', isEqualTo: otherUserId)
      .where('receiverId', isEqualTo: currentUserId)
      .snapshots();

  return Rx.combineLatest2<QuerySnapshot, QuerySnapshot, List<QueryDocumentSnapshot>>(
    messagesFromCurrentUser,
    messagesFromOtherUser,
    (snapshot1, snapshot2) {
      // Combina todos os documentos
      final combinedDocs = [...snapshot1.docs, ...snapshot2.docs];
      // Ordena os documentos pela data
      combinedDocs.sort((a, b) {
        final timestampA = a['timestamp'] as Timestamp;
        final timestampB = b['timestamp'] as Timestamp;
        return timestampB.compareTo(timestampA);
      });
      return combinedDocs;
    },
  );
}

//---------------------------------------

 //buscar por chatId
 Stream<QuerySnapshot> getMessagesChat( String chatId) {

  print(">>>>>>>>>>>ChatId: $chatId");

  return _firestore
      .collection("messages")
      .where("chatId", isEqualTo: chatId) // Filtra por conversa específica
      .orderBy("timestamp", descending: true) // Ordena por data, do mais recente ao mais antigo
      .snapshots();
}

  //filtrar mensagens especificar do item
  Stream<QuerySnapshot> getMessagesItem(String chatPartnerId, String itemId ) {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    print(">>>>>>>>>>>chatPartnerId/idtem: $chatPartnerId");
    print(">>>>>>>>>>>idtem: $itemId");
    print(">>>>>>>>>>>currentUserId: $currentUserId");
    return _firestore
        .collection("messages")
        .where("itemId", whereIn: [itemId,])//todas referente ao id
        .where("senderId", whereIn: [currentUserId, chatPartnerId]) // Enviadas por qualquer dos dois
        .where("receiverId", whereIn: [currentUserId, chatPartnerId]) // Recebidas por qualquer dos dois
        .orderBy("timestamp", descending: true)
        .snapshots();
  }
  //teste
  

  // Exemplo ao enviar uma mensagem

  //Buscar as Mensagens do user logado
   Stream<QuerySnapshot> getUserConversations(String userId) {
    return _firestore
        .collection('messages')
        .where('receiverId', isEqualTo: userId) // Filtra mensagens onde o userId é o destinatário
        .snapshots();
  }
  /*
  Future<void> deleteCollection(String collectionPath) async {
    var collection = FirebaseFirestore.instance.collection(collectionPath);
    var snapshot = await collection.get();

    // Deleta cada documento dentro da coleção
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }

    print('Coleção $collectionPath excluída.');
  }*/


}