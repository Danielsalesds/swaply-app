import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  late final String id;
  final String title;
  final String description;
  final String userId; // ID do usuário que possui o item
  //final double price;
  final String idMensagem;
  final String? imageUrl;
  final String? city;
  final DateTime? createdAt;

  ItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    //required this.price,
    required this.idMensagem,
    this.imageUrl,
    required this.city,
    this.createdAt
  });

  factory ItemModel.fromMap(String id, Map<String, dynamic> data) {
    return ItemModel(
      id: id,
      title: data['title'] ?? 'Sem título',
      description: data['description'] ?? 'Sem descrição',
      userId: data['userId'],
      //price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl']?? 'Sem imagem',
      idMensagem: data['idMensagem'],
      city: data['city'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
    );
  }
  /// Método para converter o `UserModel` para um Map (para salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'title': title,
      'description': description,
      'userId': userId,
      //'price': price,
      'imageUrl': imageUrl,
      'idMensagem': idMensagem,
      'city': city,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}
