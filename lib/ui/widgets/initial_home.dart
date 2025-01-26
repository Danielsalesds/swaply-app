import 'package:flutter/material.dart';
import 'package:swaply/model/item_model.dart';
import 'package:swaply/services/firestore_service.dart';
import 'package:swaply/ui/widgets/item_anuncio_view.dart';
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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Buscar',
                          prefixIcon: Icon(Icons.search, color: const Color(0xFF000000)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(color: Color(0xFF000000), width: 0.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(color: Color(0xFFFFA726), width: 0.5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.notifications, color: Color(0xFF000000)),
                      onPressed: () {
                        print('Notificado');
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
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
            ),
            const SliverToBoxAdapter(
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                height: 32,
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2 / 3,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final item = listItemAll[index];
                  return ItemCard(
                    item: item,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ItemAnuncioView(
                          item: item,
                          onLikePressed: () {  print('Gostei!');}, 
                          onMessagePressed: () { print('Mensagem!'); }, 
                          ),
                        ));
                    },
                  );
                },
                childCount: listItemAll.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
