import 'package:flutter/material.dart';

class ButtonCustom extends StatefulWidget {
  final String texto;
  final VoidCallback onPressed;
  final int? Size;
  final Color? corBack, corText;
  final bool? cond;
  final double? horizontal, vertical;

  const ButtonCustom({
    super.key,
    required this.texto,
    required this.onPressed,
    this.Size,
    this.corBack,
    this.corText,
    this.cond,
    this.horizontal,
    this.vertical
  });

  @override
  State<ButtonCustom> createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _animateDown() {
    setState(() {
      _scale = 0.7;
    });
  }

  void _animateUp() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _animateDown(),
      onPointerUp: (_) => _animateUp(),
      onPointerCancel: (_) => _animateUp(),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 80),
        child: Container(
          margin: const EdgeInsets.all(5),
          child: ElevatedButton(
            onPressed: () {
              _animateUp(); // Garante que volte ao normal ao clicar
              widget.onPressed();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  widget.corBack ?? const Color.fromARGB(255, 56, 42, 42),
              foregroundColor: widget.corText ?? Colors.white,
              elevation: 8,
              padding:  EdgeInsets.symmetric(horizontal: widget.horizontal ?? 30, vertical: widget.vertical ?? 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Text(
              widget.texto,
              style: TextStyle(fontSize: widget.Size?.toDouble() ?? 18.0),
            ),
          ),
        ),
      ),
    );
  }
}
