import 'dart:collection';

// Function to calculate the result of an arithmetic expression
double calculateExpression(String expression) {
  // Replace `:` with `/` for division
  expression = expression.replaceAll(':', '/');

  // Convert infix expression to Reverse Polish Notation (RPN)
  List<String> rpn = _infixToRPN(expression);

  // Evaluate the RPN expression
  return _evaluateRPN(rpn);
}

// Operator precedence
int _precedence(String op) {
  if (op == '+' || op == '-') return 1;
  if (op == '*' || op == '/') return 2;
  return 0;
}

// Check if a string is an operator
bool _isOperator(String s) {
  return s == '+' || s == '-' || s == '*' || s == '/';
}

// Convert infix expression to Reverse Polish Notation (RPN)
List<String> _infixToRPN(String expression) {
  List<String> output = [];
  Queue<String> operators = Queue<String>();
  String numberBuffer = '';

  for (int i = 0; i < expression.length; i++) {
    String ch = expression[i];

    // If the character is a digit or a decimal point, build the number
    if (RegExp(r'\d|\.', unicode: true).hasMatch(ch)) {
      numberBuffer += ch;
    } else {
      // If there's a number in the buffer, add it to the output
      if (numberBuffer.isNotEmpty) {
        output.add(numberBuffer);
        numberBuffer = '';
      }

      if (ch == '(') {
        operators.addFirst(ch);
      } else if (ch == ')') {
        while (operators.isNotEmpty && operators.first != '(') {
          output.add(operators.removeFirst());
        }
        operators.removeFirst(); // Remove the '('
      } else if (_isOperator(ch)) {
        while (operators.isNotEmpty &&
            _isOperator(operators.first) &&
            _precedence(operators.first) >= _precedence(ch)) {
          output.add(operators.removeFirst());
        }
        operators.addFirst(ch);
      }
    }
  }

  // If there's a number in the buffer at the end, add it to the output
  if (numberBuffer.isNotEmpty) {
    output.add(numberBuffer);
  }

  // Pop all remaining operators onto the output
  while (operators.isNotEmpty) {
    output.add(operators.removeFirst());
  }

  return output;
}

// Evaluate Reverse Polish Notation (RPN) expression
double _evaluateRPN(List<String> rpn) {
  Queue<double> stack = Queue<double>();

  for (String token in rpn) {
    if (_isOperator(token)) {
      double b = stack.removeFirst();
      double a = stack.removeFirst();

      switch (token) {
        case '+':
          stack.addFirst(a + b);
          break;
        case '-':
          stack.addFirst(a - b);
          break;
        case '*':
          stack.addFirst(a * b);
          break;
        case '/':
          stack.addFirst(a / b);
          break;
      }
    } else {
      // Convert the number and push it to the stack
      stack.addFirst(double.parse(token));
    }
  }

  return stack.removeFirst();
}

void main() {
  String expression =
      "7 + 2 : 4 * (7 + 9 : 3) : 12 * 2 + 1 + (4 + (2 + 3 * 2 + (7 * 2)))";
  double result = calculateExpression(expression);
  print("Result: $result");
}
