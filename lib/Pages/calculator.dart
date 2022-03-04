import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:get/get.dart';

class CalculatorState extends StatelessWidget {
     RxString equation = '0'.obs ;
    var equationFontSize = 38.0.obs;
    var resultFontSize = 48.0.obs;
    RxString result = '0'.obs;
    RxString expression = "".obs;
  
  
  @override
  Widget build(BuildContext context) {
  

    buttonPressed(String buttonText) {

    if(buttonText == 'C'){
      equation.value = "0";
         result.value = "0";
        double equationFontSize = 38.0;
        double resultFontSize = 48.0;
    }else if(buttonText =='X'){
       double equationFontSize = 38.0;
        double resultFontSize = 48.0;
        equation.value = equation.value.substring(0, equation.value.length-1);
        
    }else if(buttonText == '='){
        double equationFontSize = 38.0;
        double resultFontSize = 48.0;

         expression.value = equation.value;
         expression.value =  expression.value.replaceAll('x','*');
         expression.value = expression.value.replaceAll('/', '/');

         try{
          Parser p = new Parser();
          Expression exp = p.parse(expression.value);
          ContextModel cm = ContextModel();
           result.value = '${exp.evaluate(EvaluationType.REAL,cm)}';
        }catch(e){
          result.value = "Error";
        }
      }else{
         equationFontSize.value = 48.0;
         resultFontSize.value = 38.0;
         if ( equation == "0"){
           equation.value = buttonText;
        }
         equation.value =  equation.value + buttonText;
      }


  ;
}


     
    Widget buildButton(String buttonText,double buttonHeight,Color buttonColor){
      return Container(
        height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
        color: buttonColor,
        child: FlatButton( shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: const BorderSide(
              color: Colors.white38,
              width: 1,
              style: BorderStyle.solid,
            )
        ),
        onPressed: () =>buttonPressed(buttonText),
         child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        ),
      );
    }



    return Scaffold(
      appBar:  AppBar(
        title: const Text('Simple calculator'),
      ),
      body: Obx((){
        return 
        Column(
        children: [
             Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation.value,style: TextStyle(fontSize:  equationFontSize.value)),
          ),

            Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text( result.value,style: TextStyle(fontSize:  resultFontSize.value)),
          ),

           const Expanded(
            child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width* .75,
                child: Table(children: [
                  TableRow(
                    children: [
                      buildButton("C", 1, Colors.blueAccent ),
                      buildButton("X", 1, Colors.greenAccent),
                      buildButton("/", 1, Colors.redAccent),
                    ]
                  ),
                     TableRow(
                        children: [
                          buildButton("7", 1, Colors.black ),
                          buildButton("8", 1, Colors.black ),
                          buildButton("9", 1, Colors.black ),
                        ]
                    ),

                       TableRow(
                        children: [
                          buildButton("4", 1, Colors.black ),
                          buildButton("5", 1, Colors.black ),
                          buildButton("6", 1, Colors.black ),
                        ]
                    ),

                       TableRow(
                        children: [
                          buildButton("1", 1, Colors.black ),
                          buildButton("2", 1, Colors.black ),
                          buildButton("3", 1, Colors.black ),
                        ]
                    ),
                       TableRow(
                        children: [
                          buildButton(".", 1, Colors.black ),
                          buildButton("0", 1, Colors.black ),
                          buildButton("00", 1, Colors.black ),
                        ]
                    ),
                ],),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                     TableRow(
                        children: [
                          buildButton("*",1,Colors.redAccent),
                        ]
                    ),
                    TableRow(
                       children: [
                          buildButton("-",1,Colors.blue),
                        ]
                    ),
                     TableRow(
                        children: [
                          buildButton("+",1,Colors.blue),
                        ]
                    ),
                      TableRow(
                        children: [
                          buildButton("/",1,Colors.blue),
                        ]
                    ),
                     TableRow(
                        children: [
                          buildButton("=",1,Colors.redAccent),
                        ]
                    )
                  ],
                  
                ),
                
              )
              

            ],
          )
        ],
      );
      }
      )
      
    );
  }
}