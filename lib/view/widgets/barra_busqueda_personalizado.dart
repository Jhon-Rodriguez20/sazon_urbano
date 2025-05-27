import 'package:flutter/material.dart';
import 'package:sazon_urbano/utils/app_estilos_texto.dart';

class BarraBusquedaPersonalizado extends StatelessWidget {
  final void Function(String) onChanged;
  final String? hintText;

  const BarraBusquedaPersonalizado({
    super.key,
    required this.onChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: onChanged,
        style: AppEstilosTexto.withColor(
          AppEstilosTexto.buttonMedium,
          Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppEstilosTexto.withColor(
            AppEstilosTexto.buttonMedium,
            isDark ? Colors.grey[400]! : Colors.grey[600]!,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          filled: true,
          fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark ? Colors.grey[400]! : Colors.grey[600]!,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}