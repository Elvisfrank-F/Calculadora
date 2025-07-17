import 'dart:math';

class Calcular {

//final String expressao;
 // const Calcular({required this.expressao});

  List<String> superSplit(String a){

    //array de string que será usado para separar as variaveis
    
    List<String> sepa = [" ", "+", "-","/","*", "^", "(", ")", "%"];
    List<String> retorno = [];
    String arma="";
 
  for(int i=0;i<a.length;i++){ 

    if( i == 0 && (a[i] == "-" || a[i] == "+")) {
      arma += a[i];
    }


    //verificar se é um operador

    else if(sepa.contains(a[i])) {
      //adicionar o numero, caso i!= 0 pois pode ser um parenteses
        if(i!=0 && arma != "" && arma != " ") retorno.add(arma);
        arma = "";
        //verificar se é um espaço, caso não é um operador, adicionar operador
        if(a[i] != " ") retorno.add(a[i]);
    }
    //caso não seja um operador, é um numero (se espera)
    else {
    arma+=a[i];

//caso o loop acabe, adicionar o restante 

   if(i == a.length-1) {
    
    retorno.add(arma);
   }
  }

    }
  return retorno;
  }

  num calcular(List<String> expressao){

     List<String> sepa = [" ", "+", "-","/","*", "^", "(", ")", "%"];

     List <bool> parens = [];
     bool paren = false;
     bool cond = false;



     //num sum=0;

     //List<String> repo =[];

     //procurar parenteses

    

     //potenciação

     int i=0;

     String ex = "";
     int cont = 0;

      while(i<expressao.length){
      if(expressao[i] == "(") {
        cont = 0;
        ex = "";
      paren = true;
      parens.add(paren);
      cond = true;
      }
      if(expressao[i] == ")"){
        print(ex);
        paren = false;
        cond = false;
        List<String> S = superSplit(ex);
        print("Split ainda na função: ");
        print(S);
        num r = calcular(S);
        print("valor calculado: $r");

       
       for(int a =0; a <= cont; a++){

        if(a == cont){
          expressao[i-a] =  r.toString();
          i=0;
         
       }
       else {
         expressao.removeAt(i-a);
       }
        }

      }

      if(cond){
      ex += cont>0? expressao[i]: "";
       cont++;
      }

      i++;
      
     }

     i=0;

     //porcentagem


     while(i<expressao.length){
      if(expressao[i] == "%") {
       
       num x = double.parse(expressao[i-1]);
      
 
       num sum = x/100;

      
       expressao.removeAt(i);
       expressao[i-1] = sum.toString();
       i=0;
      }
      
      else {
        i++;
      }
     }



     //potenciação


     while(i<expressao.length){
      if(expressao[i] == "^") {
       
       num x = double.parse(expressao[i-1]);
       num y = double.parse(expressao[i+1]);
 
       num sum = pow(x,y);

       print("potencia: $sum");

       expressao.removeAt(i+1);
       expressao.removeAt(i);
       expressao[i-1] = sum.toString();
       i=0;
      }
      
      else {
        i++;
      }
     }

     //multiplicação e divisao e porcentagem

    i =0;

   while(i< expressao.length) {
    
   if(expressao[i] == "*" || expressao[i] == "/"){
       num x = num.parse(expressao[i-1]);
       num y = num.parse(expressao[i+1]);

       num sum=0;

       if(expressao[i] == "*")  sum = x*y;
       
       if(expressao[i] == "/")  sum = x/y;
             
       //substitui pelo resuldo
       expressao.removeAt(i+1);
       expressao.removeAt(i);
       expressao[i-1] = sum.toString();

       i=0;
   } else {
    i++;
   }

   }

   i=0;

   while(i<expressao.length){

   if(expressao[i] == "+" || expressao[i] == "-"){


    num x = num.parse(expressao[i-1]);
    num y = num.parse(expressao[i+1]);

    num sum = (expressao[i] == "+")? (x+y) : (x-y);

    expressao.removeAt(i+1);
    expressao.removeAt(i);
    expressao[i-1] = sum.toString();

    i=0;
   }
   else {
    i++;
   }

   }

   return num.parse(expressao[0]);
  }

 
}

//  void main(){

 

//     String? a = stdin.readLineSync();

//      Calcular c = Calcular();

//     List<String> b = c.superSplit(a ?? " ");

//     print("Split no main: ");

//     print(b);

//     double x = c.calcular(b);

//     print("resultado: $x");

//     print(b);
//   }




