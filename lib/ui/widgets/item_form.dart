import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:swaply/model/item_model.dart';
import 'package:swaply/services/firestore_service.dart';
import 'package:swaply/ui/widgets/success_message.dart';

class ItemForm extends StatefulWidget {
  const ItemForm({super.key});

  @override
  
  _ItemFormState createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService firestoreService = FirestoreService();

  // Controladores para os campos
  final TextEditingController _titleController = TextEditingController();
  //final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];

  // Selecionar imagem da galeria ou câmera
  void _selectImages() async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(child: Text('Escolha uma imagem')),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(ImageSource.camera),
                child: const Text('Câmera'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
                child: const Text('Galeria'),
              ),
            ],
          ),
        ],
      ),
    );

    if (source != null) {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedImages = [File(pickedFile.path)];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nenhuma imagem selecionada.")),
        );
      }
    }
  }

  // Salvar dados no Firestore
  Future<void> _saveItem() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Criar um mapa com os dados do formulário diretamente
        Map<String, dynamic> itemData = {
          'title': _titleController.text,
          'description': _descriptionController.text,
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'imageUrl': 'https://example.com/fake-image-url.jpg', // Coloque a URL da imagem se necessário
          'city': _cityController.text,
          'idMensagem': '', // Se necessário, inclua um valor
          'createdAt': FieldValue.serverTimestamp(), // Adicionando data de criação
        };

        // Adicionar no Firestore
        await FirebaseFirestore.instance.collection('itens').add(itemData);

        // Exibir uma mensagem de sucesso
        const SuccessMessage(message: 'Item cadastrado com sucesso!');

        // Limpar os campos do formulário após o envio
        _titleController.clear();
        _descriptionController.clear();
        _cityController.clear();
        setState(() {
          _selectedImages = [];
        });
      } catch (e) {
        // Tratar erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar item: $e')),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserir Itens"),
        backgroundColor: const Color(0xFFFFA726),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView.builder(
            itemCount: 1, // Apenas um item para todo o formulário
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      floatingLabelStyle: TextStyle(color: Color(0xFFFF9800)),
                      labelStyle: TextStyle(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 107, 105, 102)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 231, 161, 55), width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o título';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                      floatingLabelStyle: TextStyle(color: Color(0xFFFF9800)),
                      labelStyle: TextStyle(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 107, 105, 102)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 231, 161, 55), width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a descrição';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'Cidade',
                      floatingLabelStyle: TextStyle(color: Color(0xFFFF9800)),
                      labelStyle: TextStyle(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 107, 105, 102)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 231, 161, 55), width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a cidade';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _selectImages,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFFF9800)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _selectedImages.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _selectedImages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.file(
                                    _selectedImages[index],
                                    fit: BoxFit.cover,
                                    width: 100,
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Text(
                                'Clique para adicionar imagens',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: _saveItem,
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }


}
