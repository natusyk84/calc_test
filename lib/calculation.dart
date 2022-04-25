import 'package:flutter/material.dart';
import 'calculator_button.dart';
import 'result_display.dart';

class Calculation extends StatefulWidget {
  const Calculation({Key? key}) : super(key: key);

  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  late double result;


  double width = 0;
  int? firstOperand;
  String? operator;
  int? secondOperand;

  @override
  void didChangeDependencies() {
    width = MediaQuery.of(context).size.width;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ResultDisplay(
        // text: '0',
        text: _getDisplayText(),
        result: 0.0,
      ),
      Row(
        children: [
          _getButton(text: '7', onTap: () => numberPressed(7)),
          _getButton(text: '8', onTap: () => numberPressed(8)),
          _getButton(text: '9', onTap: () => numberPressed(9)),
          _getButton(
              text: 'x',
              onTap: () => operatorPressed('*'),
              backgroundColor: const Color.fromRGBO(220, 220, 220, 1)),
        ],
      ),
      Row(
        children: [
          _getButton(text: '4', onTap: () => numberPressed(4)),
          _getButton(text: '5', onTap: () => numberPressed(5)),
          _getButton(text: '6', onTap: () => numberPressed(6)),
          _getButton(
              text: '/',
              onTap: () => operatorPressed('/'),
              backgroundColor: const Color.fromRGBO(220, 220, 220, 1)),
        ],
      ),
      Row(
        children: [
          _getButton(text: '1', onTap: () => numberPressed(1)),
          _getButton(text: '2', onTap: () => numberPressed(2)),
          _getButton(text: '3', onTap: () => numberPressed(3)),
          _getButton(
              text: '+',
              onTap: () => operatorPressed('+'),
              backgroundColor: const Color.fromRGBO(220, 220, 220, 1))
        ],
      ),
      Row(
        children: [
          _getButton(
              text: '=',
              onTap: calculateResult,
              backgroundColor: Colors.orange,
              textColor: Colors.white),
          _getButton(text: '0', onTap: () => numberPressed(0)),
          _getButton(
              text: 'C',
              onTap: clear,
              backgroundColor: const Color.fromRGBO(220, 220, 220, 1)),
          _getButton(
              text: '-',
              onTap: () => operatorPressed('-'),
              backgroundColor: const Color.fromRGBO(220, 220, 220, 1)),
        ],
      ),
    ]);
  }

  numberPressed(int number) {
    setState(() {
      if (result != 0.0) {
        result = 0.0;
        firstOperand = number;
        return;
      }
      if (firstOperand == null) {
        firstOperand = number;
        return;
      }
      if (operator == null) {
        firstOperand = int.parse('$firstOperand$number');
        return;
      }
      if (secondOperand == null) {
        secondOperand = number;
        return;
      }

      secondOperand = int.parse('$secondOperand$number');
    });
  }

  operatorPressed(String operator) {
    setState(() {
      firstOperand ??= 0;
      this.operator = operator;
    });
  }

  calculateResult() {
    if (operator == null || secondOperand == null) {
      return;
    }
    setState(() {
      switch (operator) {
        case '+':
          result = (firstOperand! + secondOperand!) as double;
          break;
        case '-':
          result = (firstOperand! - secondOperand!) as double;
          break;
        case '*':
          result = (firstOperand! * secondOperand!) as double;
          break;
        case '/':
          if (secondOperand == 0) {
            return;
          }
          result = (firstOperand! ~/ secondOperand!) as double;
          break;
      }

      firstOperand = result as int?;
      operator = null;
      secondOperand = null;
      result = 0.0;
    });
  }

  clear() {
    setState(() {
      result = 0.0;
      operator = null;
      secondOperand = null;
      firstOperand = null;
    });
  }

  String _getDisplayText() {
   //  if(result == 0.0) {
      return result.toString();
    // }
    // if (result != null) {
     // return '$result';
    // }
    //
    // if (secondOperand != null) {
    //   return '$firstOperand$operator$secondOperand';
    // }
    //
    // if (operator != null) {
    //   return '$firstOperand$operator';
    // }
    //
    // if (firstOperand != null) {
    //   return '$firstOperand';
    // }

   // return '0';
  }


  Widget _getButton(
      {required String text,
        required  onTap,
        Color backgroundColor = Colors.white,
        Color textColor = Colors.black}) {
    return CalculatorButton(
      label: text,
      onTap: onTap,
      //() => {},//onTap,
      size: 90,
      backgroundColor: backgroundColor,
      labelColor: textColor,
    );
  }

}

// class ResultDisplay extends StatelessWidget {
//   var text;
//   late final double result;
//
//   ResultDisplay({required this.text, required this.result});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         alignment: Alignment.centerRight,
//         padding: EdgeInsets.only(right: 24),
//         width: double.infinity,
//         height: 80,
//         color: Colors.black,
//         child: Text(
//           text,
//           style: TextStyle(color: Colors.white, fontSize: 34),
//         ));
//   }
//
// }

// Widget _getButton(
//     {required String text,
//       required  onTap,
//       Color backgroundColor = Colors.white,
//       Color textColor = Colors.black}) {
//   return CalculatorButton(
//     label: text,
//     onTap: onTap,
//     //() => {},//onTap,
//     size: 90,
//     backgroundColor: backgroundColor,
//     labelColor: textColor,
//   );
// }




