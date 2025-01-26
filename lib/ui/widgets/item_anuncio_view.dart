import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatar a data
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swaply/model/item_model.dart';
import 'package:swaply/ui/pages/chat_page.dart';
import 'package:swaply/ui/widgets/image_validator.dart'; // Modelo do Item

class ItemAnuncioView extends StatelessWidget {
  final ItemModel item;
  final VoidCallback onLikePressed;
  final VoidCallback onMessagePressed;

  const ItemAnuncioView({
    super.key,
    required this.item,
    required this.onLikePressed,
    required this.onMessagePressed,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatted = item.createdAt != null
        ? DateFormat('dd/MM/yyyy').format(item.createdAt!)
        : 'Data não disponível';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anúncio'),
        backgroundColor: const Color(0xFFFFA726), // Cor personalizada para o AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16), // Espaçamento ao redor do conteúdo
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ImageValidator(imageUrl: item.imageUrl),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              height: 32,
            ),
            const SizedBox(height: 16),
            // Título
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // Descrição
            Text(
              item.description,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
            ),
            const SizedBox(height: 200),
            // Cidade
            if (item.city != null)
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.grey, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    item.city!,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            const SizedBox(height: 12),
            // Data de cadastro
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                const SizedBox(width: 8),
                Text(
                  dateFormatted,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: onLikePressed,
              icon: const Icon(FontAwesomeIcons.heart, color: Color(0xFFFFA726)),
              label: const Text('Gostei'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFFFA726),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ChatPage(item: item,),
                ),);
              },
              icon: const Icon(FontAwesomeIcons.comment, color: Colors.blue),
              label: const Text('Conversa'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
