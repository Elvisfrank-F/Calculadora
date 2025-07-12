import 'package:flutter/material.dart';

class ButtonCustom extends StatefulWidget {

  final  texto;
  final VoidCallback onPressed;
  final int? Size;
  final Color? corBack, corText;

  const ButtonCustom({
  super.key, 
  required this.texto, 
  required this.onPressed,
  this.Size,
  this.corBack,
  this.corText
  });

  @override
  State<ButtonCustom> createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {

  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.5;
    });
  }

  void _onTapUp(TapUpDetails details){
    setState(() {
      _scale = 1.0;
    });
    widget.onPressed();
  }

  void _onTapCancel(){
    setState(() {
      _scale = 1.0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(

      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: Duration(milliseconds: 100),
        child:Container(
          margin: const EdgeInsets.all(5),
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              
              backgroundColor: widget.corBack ?? const Color.fromARGB(255, 56, 42, 42),       // Cor de fundo
              foregroundColor: widget.corText ?? Colors.white,            // Cor do texto
              elevation: 8,                              // Sombra
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100), // Cantos arredondados
              ),
            ),
            child: Text(
              widget.texto,
              style: TextStyle(fontSize: widget.Size?.toDouble() ?? 18.0),
            ),
          ),
        ))


    );
  }
}