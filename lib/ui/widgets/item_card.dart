import 'package:flutter/material.dart';
import 'package:swaply/model/item_model.dart';
import 'package:intl/intl.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;
  final VoidCallback onTap;

  const ItemCard({
    super.key,
    required this.item,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    // Formata a data
    final formattedDate = item.createdAt != null
        ? DateFormat('dd/MM/yyyy').format(item.createdAt!)
        : 'Data não disponível';

    return Material(
      color: Colors.transparent, // Torna o material invisível, mas mantém os efeitos visuais
      child: InkWell(
        onTap: onTap, // Ação ao clicar no card
        splashColor: const Color(0xFFE0E0E0).withOpacity(0.3), //  Cinza claro translúcido
        highlightColor:const Color(0xFFBDBDBD).withOpacity(0.5), // Cinza médio com efeito metálico // Efeito ao manter pressionado
        borderRadius: BorderRadius.circular(12), // Garante que o splash siga o formato arredondado do card
        child: Card(
          //color: const Color.fromARGB(255, 255, 255, 255),
          color: Colors.transparent, // Fundo transparente
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: Colors.grey, // Cor da borda
              width: 1.0, // Largura da borda
            ),
            
          ),
          elevation: 0,
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
                              const Icon(Icons.location_on,
                                  size: 16, color: Colors.grey),
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
                              const SizedBox(
                                  width:
                                      4), // Pode adicionar um SizedBox se quiser um espaçamento
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
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
        ),
      ),
    );
  }
}
