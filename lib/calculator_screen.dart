import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController textOne = TextEditingController();
  TextEditingController textTwo = TextEditingController();
  TextEditingController textThree = TextEditingController();
  bool checkOne = false, checkTwo = false, checkThree = false;
  double result = 0;

  Widget customTextInput(bool checkState, TextEditingController textController,
      ValueChanged<bool> foo) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            enabled: checkState,
            controller: textController,
          ),
        ),
        Expanded(
          flex: 1,
          child: CheckboxListTile(
            value: checkState,
            onChanged: foo,
          ),
        ),
      ],
    );
  }

  Widget operationButton(String symbol) {
    return Container(
      margin: EdgeInsets.all(3),
      child: RaisedButton(
        onPressed: () {
          double a, b, c, d;
          if (checkOne ? (checkTwo || checkThree) : (checkTwo && checkThree)) {
            a = checkOne
                ? double.parse(textOne.text.isNotEmpty ? textOne.text : '0')
                : 0;
            b = checkTwo
                ? double.parse(textTwo.text.isNotEmpty ? textTwo.text : '0')
                : 0;
            c = checkThree
                ? double.parse(textThree.text.isNotEmpty ? textThree.text : '0')
                : 0;
            switch (symbol) {
              case '+':
                d = a + b + c;
                break;
              case '-':
                d = a - b - c;
                break;
              case '*':
                a = checkOne ? a : 1;
                b = checkTwo ? b : 1;
                c = checkThree ? c : 1;
                d = a * b * c;
                break;
              case '/':
                if (checkOne && checkTwo && !checkThree) {
                  d = a / b;
                }
                if (!checkOne && checkTwo && checkThree) {
                  d = b / c;
                }
                if (checkOne && !checkTwo && checkThree) {
                  d = a / c;
                }
                if (checkOne && checkTwo && checkThree) {
                  d = a / b / c;
                }
                break;
              default:
            }
            result = d;
            setState(() {});
          } else {
            Fluttertoast.showToast(
                msg: "Checklist aktif hanya 1 mohon aktifkan 1 lagi.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            setState(() {});
            return false;
          }
        },
        child: Text(symbol),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              customTextInput(
                checkOne,
                textOne,
                (bool value) {
                  checkOne = value;
                  setState(() {});
                },
              ),
              customTextInput(
                checkTwo,
                textTwo,
                (bool value) {
                  checkTwo = value;
                  setState(() {});
                },
              ),
              customTextInput(
                checkThree,
                textThree,
                (bool value) {
                  checkThree = value;
                  setState(() {});
                },
              ),
              Row(
                children: [
                  operationButton('+'),
                  operationButton('-'),
                  operationButton('*'),
                  operationButton('/'),
                ],
              ),
              Divider(),
              Text(
                'Hasil = $result',
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
