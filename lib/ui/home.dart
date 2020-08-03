import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _amountPerson = 1;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.purple[50],
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.purple[100].withOpacity(0.6),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Total Per Person',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.purple[800],
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '\$ ${calculateTotalPerPerson(_billAmount, _amountPerson, _tipPercentage)}',
                      style: TextStyle(
                        fontSize: 29.0,
                        color: Colors.purple[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.purple[400],
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.purple[500]),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount",
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (e) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Split',
                        style: TextStyle(color: Colors.grey, fontSize: 17.0),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_amountPerson > 1) {
                                  _amountPerson--;
                                } else {
                                  // do nothing
                                }
                              });
                            },
                            child: Container(
                                width: 40.0,
                                height: 40.0,
                                margin: EdgeInsets.all(10.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.purple[100].withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 23.0,
                                      color: Colors.purple[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          ),
                          Text(
                            '$_amountPerson',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.purple[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _amountPerson++;
                              });
                            },
                            child: Container(
                                width: 40.0,
                                height: 40.0,
                                margin: EdgeInsets.all(10.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.purple[100].withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                      fontSize: 23.0,
                                      color: Colors.purple[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Tip',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          '\$'+'${(calculateTotalTip(_billAmount,_amountPerson,_tipPercentage)).toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.purple[700],
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '$_tipPercentage%',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.purple[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Slider(
                        min: 0,
                        max: 100,
                        inactiveColor: Colors.grey,
                        divisions: 10,
                        value: _tipPercentage.toDouble(),
                        onChanged: (double newValue) {
                          setState(() {
                            _tipPercentage = newValue.round();
                          });
                        },
                        activeColor: Colors.purple[700],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount == null || billAmount < 0 || billAmount.toString().isEmpty) {
      // do nothing
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }

  calculateTotalPerPerson(double billAmount,  int splitBy , int tipPercentage) {
    var totalPerPerson = (calculateTotalTip(billAmount, splitBy,tipPercentage) + billAmount) / splitBy;
    return totalPerPerson.toStringAsFixed(2); // to choose just two decimal
  }
}
