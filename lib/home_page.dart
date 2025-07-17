import 'package:flutter/material.dart';
import 'button_custom.dart';
import 'calcular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String expres="";
  double dist =10.0;
  int pos =0;
  Calcular c = Calcular();
  bool resulto = false;
  bool paren = false;
  bool numer = false;
  num result=0;
  bool porcentagem = false; //analizar se op orcetagem foi clicado para colocar o vezes caso nao seja colocado

  List <bool> parens =[];

  TextEditingController _controller = TextEditingController();

  void digitar(String a) {
  setState(() {
    paren = false;
    resulto = false;
    numer = parens.isEmpty ? true : false;

    if(expres.length >0) {

    if(expres[expres.length-1] == "%"){
      a = "*" + a;
    }
  }

    if (expres.length > 2 && pos <= expres.length) {
      expres = expres.substring(0, pos) + a + expres.substring(pos);
      pos = pos + 1;
    } else {
      expres += a;
      pos = expres.length;
    }

    // Primeiro atualiza o texto
    _controller.text = expres;

    // Depois atualiza o cursor (e só se o offset for válido)
    if (pos <= expres.length) {
      _controller.selection = TextSelection.collapsed(offset: pos);
    }
  });
}


  void digitar_Paren(String a){
    
  List<String> oper = ["*","/","^","+","-"];

    if(a == '()'){

      if(expres !="" && parens.isEmpty && !oper.contains(a) && !oper.contains(expres[expres.length-1])){
       a="*(";
        parens.add(paren);

      }
      else if(parens.isEmpty){
        a="(";
        parens.add(paren);
        print("2");
      }
     
     else if(paren){
      a = '(';
      parens.add(paren);
      print("3");
     }else if(!paren && parens.isNotEmpty){
      a = ')';
      parens.removeLast();
      print("4");
     }

    }
  
     setState(() {
       paren = false; 
      resulto = false;
      expres += a;
      _controller.text = expres;
      pos=expres.length;

    });

  }

  void digitarOper(String a){

    List<String> oper = ["*","/","^","+","-", "%"];

    if(expres.length-1>=0){

    if(oper.contains(expres[expres.length-1]) || expres[expres.length-1] == '('){
      a='';
    }
    }

    if(expres.length == 0 && (a != "-" && a != "+")) {
      a='';
    }

    if(a == "%") {
      porcentagem = true;
    }
    else {
      porcentagem = false;
    }
  
    setState(() {
    paren = false;
    resulto = false;
    numer = parens.isEmpty ? true : false;

if(pos-1>=0 && pos < expres.length) {
    if(oper.contains(expres[pos-1])  || oper.contains(expres[pos])){
      a="";
    }
}

    if (expres.length > 2 && pos <= expres.length) {
      expres = expres.substring(0, pos) + a + expres.substring(pos);
      pos = pos + 1;
    } else {
      expres += a;
      pos = expres.length;
    }

    // Primeiro atualiza o texto
    _controller.text = expres;

    // Depois atualiza o cursor (e só se o offset for válido)
    if (pos <= expres.length) {
      _controller.selection = TextSelection.collapsed(offset: pos);
    }
  });

  }

  void _iniciarParen(){
    setState(() {
       parens.clear();
    paren = false;
    });
  }

 void _apagar() {
  if (expres.isEmpty || pos == 0) return;

  setState(() {

  if(expres[expres.length-1] == ')'){
    paren = false;
  }
   

     if(resulto){
      expres = "";
      _controller.text = expres; 
    }
    else {
    expres = expres.substring(0, pos - 1) + expres.substring(pos);
    pos = pos - 1;

    _controller.text = expres;
    _controller.selection = TextSelection.collapsed(offset: pos);
    }

    int cont=0, conta=0;
    for(int i=0;i<expres.length;i++){
        if(expres[i] == '('){
          print("abre encontrado em: $i");
          cont++;
        }
        if(expres[i] == ')'){
          print("feche encontrado em: $i");
          conta++;
        }
    }

    parens.clear();

    for(int i=0;i<(cont-conta);i++){
     parens.add(paren);
     print("parem $i");
    }

   
  });
}

void resultCont(){
  
}

   
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea (
        child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          
            SizedBox(height: 40,),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textAlign: TextAlign.right,
                    //textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 40),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),

                     onTap: (){

              setState(() {
               pos =  _controller.selection.baseOffset;
            print("posi: $pos");
              });
            
            },
            
                  ),
                )
              ,

         Row(
          mainAxisAlignment: MainAxisAlignment.end,
           children: [
            
             GestureDetector(child: Icon(Icons.backspace), onTap: _apagar),
             SizedBox(width: 15,),
           ],
         ) ,
         SizedBox(height: 10,),
        Container(
          
          color: Colors.grey[800],
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 1,
            height: 1,
          
          )


          ),

       Container(
      //  color: Colors.grey,
        child:    SizedBox(
            width: MediaQuery.of(context).size.width*0.8,
            height: 40,
          
            //child: Center( child: Text(expres, style:TextStyle(fontSize: 30))),
        
          )),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonCustom(texto: '()', corBack: const Color.fromARGB(255, 97, 88, 88), onPressed: (){
                digitar_Paren('()');
              }),

              SizedBox(width: dist),
            
              ButtonCustom(texto: '^', Size: 30, vertical: 15, corBack: const Color.fromARGB(255, 97, 88, 88), onPressed: (){ digitarOper('^');}),

              SizedBox(width: dist),

              ButtonCustom(texto: '%', Size: 30, horizontal: 25, vertical: 15,corBack: const Color.fromARGB(255, 97, 88, 88), onPressed: (){ digitarOper('%');}),

              SizedBox(width: dist),

              
              ButtonCustom(texto: '÷', Size: 30, horizontal: 25, vertical: 15,corBack: const Color.fromARGB(255, 97, 88, 88), onPressed: (){ digitarOper('/');})
            ],
          ),

          Padding(
            padding: EdgeInsets.all(2),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonCustom(texto: '7', onPressed: (){
                digitar('7');
              }),

              SizedBox(width: dist),
            
              ButtonCustom(texto: '8', onPressed: (){ digitar('8');}),

              SizedBox(width: dist),

              ButtonCustom(texto: '9', onPressed: (){ digitar('9');}),

              SizedBox(width: dist),

              ButtonCustom(texto: 'x', Size: 30, horizontal: 25, vertical: 15,corBack: const Color.fromARGB(255, 97, 88, 88), onPressed: (){ digitarOper('*');}),
            ],
          )),
          Padding(
            padding: EdgeInsets.all(2),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonCustom(texto: '4', onPressed: (){ digitar('4');})

              ,

              SizedBox(width: dist),
              ButtonCustom(texto: '5', onPressed: (){ digitar('5');}),

              SizedBox(width: dist),

              ButtonCustom(texto: '6', onPressed: (){ digitar('6');}),

              SizedBox(width: dist),
               
              ButtonCustom(texto: '-', Size: 40, horizontal: 25, vertical: 8,corBack: const Color.fromARGB(255, 97, 88, 88), onPressed: (){ digitarOper('-');}),

            ],
          )),

          Padding(
            padding: EdgeInsets.all(2),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonCustom(texto: '1', onPressed: (){ digitar('1');}),

              SizedBox(width: dist),
              
              ButtonCustom(texto: '2', onPressed: (){ digitar('2');}),
              SizedBox(width: dist),

              ButtonCustom(texto: '3', onPressed: (){ digitar('3');}),
              SizedBox(width: dist),

              ButtonCustom(texto: '+', Size: 30, horizontal: 25, vertical: 15,corBack: const Color.fromARGB(255, 97, 88, 88), onPressed: (){ digitarOper('+');}),

            ],
          )),
          Padding(
            padding: EdgeInsets.all(2),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonCustom(texto: 'C', corBack: const Color.fromARGB(255, 207, 8, 8), onPressed: (){
                setState(() {
                  _iniciarParen();
                   expres = "";
                   _controller.text = expres;
                });

                
               
              }),

              SizedBox(width: dist),
              
              ButtonCustom(texto: '0', onPressed: (){ digitar('0');}),

              SizedBox(width: dist),

              ButtonCustom(texto: '.', onPressed: (){ digitar('.');}),

              SizedBox(width: dist),

              ButtonCustom(texto: '=', vertical: 10, Size: 30, corBack: Colors.green,onPressed: (){
                setState(() {
                  _iniciarParen();
                  result = c.calcular(c.superSplit(expres));
                  expres = result.toString();
                  _controller.text = expres;
                  resulto = true;
                });
              }),

            ],
          )),

          //SizedBox(height: 100),
        ],

        
      )


    ));
  }
}