import 'package:flutter/material.dart';
import 'package:swaply/model/item_model.dart';
import 'package:intl/intl.dart';

class ItemCardUser extends StatelessWidget {
  final ItemModel item;
  final VoidCallback onTap;

  const ItemCardUser({
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
        splashColor: const Color(0xFFE0E0E0).withOpacity(0.3), // Cinza claro translúcido
        highlightColor: const Color(0xFFBDBDBD).withOpacity(0.5), // Efeito ao manter pressionado
        borderRadius: BorderRadius.circular(12), // Garante que o splash siga o formato arredondado do card
        child: Card(
          color: Colors.transparent, // Fundo transparente
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: Colors.grey, // Cor da borda
              width: 1.0, // Largura da borda
            ),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Imagem no lado esquerdo
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                      ? Image.network(
                          item.imageUrl!,
                          width: 100,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 50),
                        )
                      : Container(
                          width: 100,
                          height: 80,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                // Informações do lado direito
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Título
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      // Localização
                      /*Row(
                        children: [
                          const Icon(Icons.location_on, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              item.city ?? 'Localização não informada',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      */
                      const SizedBox(height: 8),
                      // Data
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
