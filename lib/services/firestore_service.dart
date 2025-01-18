import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swaply/model/item_model.dart';
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

}