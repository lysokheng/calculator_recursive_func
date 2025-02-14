double evaluate(String expression) {
  // Remove all whitespace from the expression
  expression = expression.replaceAll(' ', '');

  // Base case: if the expression is a single number, parse and return it
  double? number = double.tryParse(expression);
  if (number != null) {
    return number;
  }

  // Helper function to find the main operator considering precedence
  int findMainOperator(String expr) {
    int parenthesesCount = 0;
    for (int i = expr.length - 1; i >= 0; i--) {
      if (expr[i] == ')') parenthesesCount++;
      if (expr[i] == '(') parenthesesCount--;
      if (parenthesesCount == 0) {
        if (expr[i] == '+' || expr[i] == '-') {
          return i;
        }
      }
    }
    parenthesesCount = 0;
    for (int i = expr.length - 1; i >= 0; i--) {
      if (expr[i] == ')') parenthesesCount++;
      if (expr[i] == '(') parenthesesCount--;
      if (parenthesesCount == 0) {
        if (expr[i] == '*' || expr[i] == '/') {
          return i;
        }
      }
    }
    return -1;
  }

  // Find the main operator in the expression
  int operatorIndex = findMainOperator(expression);
  if (operatorIndex == -1) {
    // Handle expressions enclosed in parentheses
    if (expression.startsWith('(') && expression.endsWith(')')) {
      return evaluate(expression.substring(1, expression.length - 1));
    }
    throw FormatException('Invalid expression');
  }

  // Split the expression into left and right parts
  String leftExpr = expression.substring(0, operatorIndex);
  String rightExpr = expression.substring(operatorIndex + 1);
  String operator = expression[operatorIndex];

  // Recursively evaluate the left and right parts
  double leftValue = evaluate(leftExpr);
  double rightValue = evaluate(rightExpr);

  // Perform the operation
  switch (operator) {
    case '+':
      return leftValue + rightValue;
    case '-':
      return leftValue - rightValue;
    case '*':
      return leftValue * rightValue;
    case '/':
      return leftValue / rightValue;
    default:
      throw FormatException('Unknown operator');
  }
}

void main() {
  String expression = '(1 + 2) * 10 - 6 / (9 * (2 + 1))';
  double result = evaluate(expression);
  print('The result of "$expression" is $result');
}
