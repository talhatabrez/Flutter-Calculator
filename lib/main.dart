// main.dart

import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(myApp());
}

class myApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage>{
    var userInput = '';
    var result = '';

    //button layout order
    final List<String> buttons = 
    ['AC', '+/-', '%', 'DEL',
    '7', '8', '9', '/',
    '4', '5', '6', 'x',
    '1', '2', '3', '-', 
    '0', '.', '=', '+',];

   @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      title: new Text('Calculator'),
      ),
      backgroundColor: Colors.amber[50],
      body: Column(
        children: <Widget>[

          //child for the input and the output
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // this contains the space where the input you give
                  // and the result of your input occurs
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userInput, style: TextStyle(fontSize: 18, color: Colors.white),),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(result, style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
          ),

          //this one is for the other buttons where
          //you need to either press the number or the
          //arithmetic symbol related to our operation
          //based on the index of the operation symbol
          //from our list we perform the set operations 
          //and as well as we give our styling          
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), 
                itemBuilder: (BuildContext context, int index){
                  
                  // button for clearing everything
                  if(index == 0){
                    return MyButton(
                      buttontapped: () {
                        setState(() => { userInput ='', result = '0', },);
                      },
                      buttonText: buttons[index],
                      color: Colors.grey,
                      textColor: Colors.white,
                    );
                  }

                  // button for +/-
                  else if(index == 1){
                    return MyButton(
                      buttonText: buttons[index],
                      color: Colors.grey,
                      textColor: Colors.white
                    );
                  }

                  //button for %
                  else if(index == 2){
                    return MyButton(
                      buttontapped: (){
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.grey,
                      textColor: Colors.white
                    );
                  }

                  //button for delete
                  else if(index == 3){
                    return MyButton(
                      buttontapped: (){
                        setState(() {
                          userInput = userInput.substring(0, userInput.length-1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.yellow,
                      textColor: Colors.white
                    );
                  }

                  //button for equal to 
                  else if(index == 18){
                    return MyButton(
                      buttontapped: (){
                        setState((){
                          equalTo();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.yellow,
                      textColor: Colors.white
                    );
                  }

                  //rest buttons
                  else {
                    return MyButton(
                      buttontapped: (){
                        setState((){
                          userInput += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index]) ? Colors.yellow : Colors.grey[400],
                      textColor: Colors.white,
                    );
                  }
                }
              ),
            ),
          ),
        
        ],
      ),
    );
  }

  bool isOperator(String s){
    if(s == '+' || s == '-' || s == 'x' || s == '/'){
      return true;
    } 
    return false;
  }

  void equalTo(){
    String finalInput = userInput;
    finalInput = userInput.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    result = eval.toString();
  }
}