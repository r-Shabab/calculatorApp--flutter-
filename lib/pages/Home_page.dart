import 'package:flutter/material.dart';
import 'package:my_calculator/widgets/CalculatorButton.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page>  {
  String expression = '';
  String calculationResult = '';

  double evaluateExpression(String expression) {
    // Use a stack to keep track of the current bracket level
    List<String> stack = [];
    String innerExpression = '';

    // Use a list to keep track of the numbers and operators in the current bracket level
    List<String> tokens = [];

    for (int i = 0; i < expression.length; i++) {
      if (stack.isNotEmpty) {
        if (expression[i] != ')') {
          innerExpression += expression[i];
        } else {
          stack.removeLast();
          if (stack.isEmpty) {
            // Recursively evaluate the result of the inner bracket
            tokens.add(evaluateExpression(innerExpression).toString());
            innerExpression = '';
          }
        }
      } else if (int.tryParse(expression[i]) != null || expression[i] == '.') {
        // Parse numbers
        if (tokens.isEmpty || !(tokens.last is String && int.tryParse(tokens.last) != null)) {
          tokens.add(expression[i]);
        } else {
          tokens.last += expression[i];
        }
      } else if (expression[i] == '(') {
        stack.add("(");
      } else {
        // Parse operators
        tokens.add(expression[i]);
      }
    }

    // Evaluate the result of the current bracket level
    double leftOperand = double.parse(tokens[0]);
    for (int i = 1; i < tokens.length; i += 2) {
      String operator = tokens[i];
      if(operator=='%') {
        return leftOperand /=100;

      }
      double rightOperand = double.parse(tokens[i + 1]);
      if (operator == '+') {
        leftOperand += rightOperand;
      } else if (operator == '-') {
        leftOperand -= rightOperand;
      } else if (operator == '*') {
        leftOperand *= rightOperand;
      } else if (operator == '/') {
        leftOperand /= rightOperand;
      }
    }

    return leftOperand;
  }

  void onEqualButtonClick() {
    setState(() {
      calculationResult = evaluateExpression(expression).toString();
    });
  }

  void onBackspaceButtonClick() {
    setState(() {
      expression = expression.substring(0, expression.length - 1);
    });
  }

  void onClearButtonClick() {
    setState(() {
      expression = '';
      calculationResult = '';
    });
  }

  void onButtonClick(String buttonText) {
    setState(() {
      expression = expression + buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 0x15, 0x43, 0x5a),
        child: Column(
          children: [
            // title and display
            Container(
              width: double.infinity,
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // title
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                    ),
                    child: const Text(
                      "Calculator",
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 50,
                    ),
                    child: Text(
                      expression,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 50),
                    child: Text(
                      calculationResult,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.black87,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CalculatorButton(text: 'V', onTap: null),
                          CalculatorButton(text: '(', onTap: () => onButtonClick('(')),
                          CalculatorButton(text: '1', onTap: () => onButtonClick('1')),
                          CalculatorButton(text: '4', onTap: () => onButtonClick('4')),
                          CalculatorButton(text: '7', onTap: () => onButtonClick('7')),
                          CalculatorButton(text: '0', onTap: () => onButtonClick('0')),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CalculatorButton(text: 'C', onTap: onClearButtonClick),
                          CalculatorButton(text: ')', onTap: () => onButtonClick(')')),
                          CalculatorButton(text: '2', onTap: () => onButtonClick('2')),
                          CalculatorButton(text: '5', onTap: () => onButtonClick('5')),
                          CalculatorButton(text: '8', onTap: () => onButtonClick('8')),
                          CalculatorButton(text: '00', onTap: () => onButtonClick('00')),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CalculatorButton(text: 'X', onTap: null),
                          CalculatorButton(text: '%', onTap: () => onButtonClick('%')),
                          CalculatorButton(text: '3', onTap: () => onButtonClick('3')),
                          CalculatorButton(text: '6', onTap: () => onButtonClick('6')),
                          CalculatorButton(text: '9', onTap: () => onButtonClick('9')),
                          CalculatorButton(text: '.', onTap: () => onButtonClick('.')),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CalculatorButton(text: '/', onTap: () => onButtonClick('/')),
                          CalculatorButton(text: '*', onTap: () => onButtonClick('*')),
                          CalculatorButton(text: '-', onTap: () => onButtonClick('-')),
                          CalculatorButton(text: '+', onTap: () => onButtonClick('+')), // Spacing
                          Container(
                            height: 200, // Double the height of other buttons
                            child: CalculatorButton(
                              text: '=', onTap: () => onEqualButtonClick(),
                              backgroundColor: Color(0xFF56A7C5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
