
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swaply/model/item_model.dart';
import 'package:swaply/services/firestore_service.dart';
import 'package:swaply/ui/widgets/item_card_user.dart';

class ListAnuncioUser extends StatefulWidget {
  const ListAnuncioUser ({super.key});

  @override
  ListAnuncioUserState createState () => ListAnuncioUserState();

}

class ListAnuncioUserState extends State<ListAnuncioUser>{
  final FirestoreService firestoreService = FirestoreService();
  final List<ItemModel> listItemAllUser = [];
  final currentUser = FirebaseAuth.instance.currentUser;
  User?user;
  
@override
void initState() {
  super.initState();
  fetchItemsUser();
}


  Future<void> fetchItemsUser () async{
    try{
      setState(() {
        user = currentUser;
      });
      final listItemUser = await firestoreService.getItemsId(user!.uid);
      setState(() {
        listItemAllUser.addAll(listItemUser);
      });
    }catch(e){
      throw Exception('Erro ao carregar Itens do Usuario.');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Anúncio"),
        backgroundColor: const Color(0xFFFFA726),
      ),
      body: ListView.builder(
        itemCount: listItemAllUser.length,
        itemBuilder: (BuildContext context, int index) {
          final itemUser = listItemAllUser[index];
          return ItemCardUser(
            item: itemUser, 
            onTap: (){
              print('Item clicado: ${itemUser.title}');
            }
          );
        },
        
      ),
    );
  }
  
}
/*
prototypeItem: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            //crossAxisCount: 2,
            //crossAxisSpacing: 8,
            //mainAxisSpacing: 8,
            //childAspectRatio: 2 / 3,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index){
              final itemUser = listItemAllUser[index];
                return ItemCardUser(
                item: itemUser, 
                onTap: (){
                  print('Item Clicado: ${itemUser.title}');
                }
              );
            },
          ),
        ), */ 