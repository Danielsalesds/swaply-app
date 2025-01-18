import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id; // ID do usuário no Firestore
  final String name; // Nome do usuário
  final String email; // Email do usuário
  final String? photoUrl; // URL da foto do usuário (opcional)
  final String idMensagem; // ID relacionado ao sistema de mensagens
  final List<String> idItens; // Lista de IDs de itens relacionados ao usuário
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.idMensagem,
    required this.idItens,
    this.createdAt
  });

  /// Método para criar um `UserModel` a partir de um documento do Firestore
  factory UserModel.fromMap(String id, Map<String, dynamic> data) {
    return UserModel(
      id: id,
      name: data['name'] ?? 'Sem nome',
      email: data['email'] ?? 'Sem email',
      photoUrl: data['photoUrl'],
      idMensagem: data['idMensagem'] ?? '',
      idItens: List<String>.from(data['idItens'] ?? []), // Converte para lista de strings
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Método para converter o `UserModel` para um Map (para salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name.isNotEmpty ? name : '', // Define um valor padrão vazio
      'email': email,
      'photoUrl': photoUrl ?? '', // Define uma string vazia se for null
      'idMensagem': idMensagem.isNotEmpty ? idMensagem : '', // Valor padrão
      'idItens': idItens.isNotEmpty ? idItens : [], // Lista vazia se não houver itens
      'createdAt': FieldValue.serverTimestamp(), // Timestamp para controle de criação
    };
  }
}
