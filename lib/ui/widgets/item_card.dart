import 'package:flutter/material.dart';
import 'package:swaply/model/item_model.dart';
import 'package:intl/intl.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  final VoidCallback onTap;

  const ItemCard({
    super.key, 
    required this.item, 
    required this.onTap // Callback para quando o card for clicado
    });  

  // Construtor que recebe o objeto ItemModel e uma função onTap

  @override
  Widget build(BuildContext context) {

    // Formata a data
    final formattedDate = item.createdAt != null
        ? DateFormat('dd/MM/yyyy').format(item.createdAt!)
        : 'Data não disponível';

    return InkWell(
      onTap: onTap,  // Ação ao clicar no card
      splashColor: Colors.orange.withOpacity(0.3),  // Efeito de splash ao clicar
      highlightColor: Colors.orange.withOpacity(0.1),  // Efeito de highlight ao manter pressionado 
      //------------------------------
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem no topo do Card
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                  ? Image.network(
                      item.imageUrl!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 100),
                    )
                  : Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 70),
                  // Localização e Data alinhados à direita
                  Align(
                    alignment: Alignment.bottomRight, // Alinha à direita
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              item.city ?? 'Localização não informada',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Data de cadastro
                       Row(
                          children: [
                            const SizedBox(width: 4), // Pode adicionar um SizedBox se quiser um espaçamento
                            Text(
                              formattedDate,
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )

    );
  }
}
