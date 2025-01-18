import 'package:flutter/material.dart';

// Widget personalizada para exibir mensagens de sucesso com ícone de check
class SuccessMessage extends StatelessWidget {
  final String message;

  const SuccessMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18.0), // Espaço externo nas laterais
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.green[50], // Cor de fundo suave verde
          borderRadius: BorderRadius.circular(12), // Bordas arredondadas
          border: Border.all(color: Colors.green[200]!), // Borda suave verde
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outline, // Ícone de check
              color: Colors.green[300],
            ),
            const SizedBox(width: 8.0), // Espaço entre o ícone e a mensagem
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.green[800], // Cor do texto mais suave
                  fontWeight: FontWeight.w500,
                ),
                softWrap: true, // Permite quebra de linha
              ),
            ),
          ],
        ),
      ),
    );
  }
}
