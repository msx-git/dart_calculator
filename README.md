# Arithmetic Expression Calculator

This Dart project implements an arithmetic expression calculator that can evaluate expressions using basic mathematical operations such as addition (`+`), subtraction (`-`), multiplication (`*`), and division (`:`). The program supports expressions with parentheses and handles operator precedence by converting infix expressions to Reverse Polish Notation (RPN) before evaluation.

## Features

- **Operator Support**: The calculator supports the following operators:
  - `+` for addition
  - `-` for subtraction
  - `*` for multiplication
  - `:` for division (which is internally replaced by `/`)
  
- **Parentheses**: The calculator can correctly evaluate expressions that include parentheses to control operator precedence.
  
- **Infix to RPN Conversion**: The calculator converts infix arithmetic expressions to Reverse Polish Notation (RPN) before evaluating them, ensuring correct precedence and associativity.

## Example Usage

void main() {
  String expression = "7 + 2 : 4 * (7 + 9 : 3) : 12 * 2 + 1 + (4 + (2 + 3 * 2 + (7 * 2)))";
  double result = calculateExpression(expression);
  print("Result: $result");  // Output: Result: 26.666666666666668
}
