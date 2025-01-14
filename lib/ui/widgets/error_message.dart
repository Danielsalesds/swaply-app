import 'package:flutter/material.dart';

// Widget personalizada para exibir mensagens de erro com ícone de exclamação
class ErrorMessage extends StatelessWidget {
  final String message;

  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18.0), // Espaço externo nas laterais
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.red[50], // Cor de fundo suave
          borderRadius: BorderRadius.circular(12), // Bordas arredondadas
          border: Border.all(color: Colors.red[200]!), // Borda suave
        ),
        child: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded, // Ícone de exclamação
              color: Colors.red[300],
            ),
            const SizedBox(width: 8.0), // Espaço entre o ícone e a mensagem
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.red[800], // Cor do texto mais suave
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
