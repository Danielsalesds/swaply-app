import 'package:flutter/material.dart';
import 'package:swaply/model/item_model.dart';
import 'package:swaply/services/firestore_service.dart';
import 'package:swaply/ui/widgets/item_card.dart';

class InitialHome extends StatefulWidget {
  const InitialHome({super.key});

  @override
  _InitialHomeState createState() => _InitialHomeState();
}

class _InitialHomeState extends State<InitialHome> {
  final FirestoreService firestoreService = FirestoreService();
  final List<ItemModel> listItemAll = [];
  //carregar lista de itens ao iniciar a widget
  @override
  void initState() {
    super.initState();
    fetchItems(); // Chama o método para carregar os itens
    print('Lista e itens: $listItemAll');
  }
  //metodo para iniciar a widget
  Future <void> fetchItems () async{
    try {
      final listItem = await firestoreService.getAllItems();
      setState(() {
        listItemAll.addAll(listItem);
      });
      
      print('Lista e itens dentro do metodo: $listItemAll');
    } catch (e) {
      print('Erro ao carregar itens: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFA726),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo de busca e botão de notificação
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Buscar',
                          prefixIcon: Icon(Icons.search, color: const Color(0xFF000000)),
                          //filled: true,
                          //fillColor: const Color.fromARGB(255, 196, 114, 114),
                          // Borda quando o TextField não está focado
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(color: Color(0xFF000000), width: 0.5), // Preta e fina
                          ),
                          // Borda quando o TextField está focado
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(color: Color(0xFFFFA726), width: 0.5), // Laranja e fina
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.notifications, color: Color(0xFF000000)),
                      onPressed: () {
                        // Ação do botão de notificação
                      },
                    ),
                  ],
                ),
              ),

              // Informação de localização
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Icon(Icons.location_on, color: Color(0xFF000000)),
                    SizedBox(width: 8),
                    Text(
                      "Localização: Nova Parnamirim, RN",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
                height: 32,
              ),

              // Conteúdo da página
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(), // Impede o scroll do GridView
                shrinkWrap: true, // Ajusta o tamanho do GridView ao conteúdo
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Número de itens por linha (2 no caso)
                  crossAxisSpacing: 8, // Espaçamento horizontal entre os itens
                  mainAxisSpacing: 8, // Espaçamento vertical entre os itens
                  childAspectRatio: 2/3, // Proporção dos itens (ajuste conforme necessário)
                ),
                itemCount: listItemAll.length, // Número total de itens
                itemBuilder: (context, index) {
                  final item = listItemAll[index];
                  return ItemCard(
                    item: item, // Passa o item para o card
                    onTap: () {
                      print('Item clicado: ${item.title}');
                    },
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
