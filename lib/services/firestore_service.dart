import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


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
  Future<void> updateUser(String id, Map<String, dynamic> updates) async {
    await FirebaseFirestore.instance.collection('users').doc(id).update(updates);
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
}