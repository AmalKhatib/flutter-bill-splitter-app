import 'package:flutter/material.dart';
import 'package:starter_flutter_app/utils/hexColor.dart';

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {

  double
      _billAmount = 0;
  int _personCounter = 1, _tipPercentage = 0;
  Color _purple = HexColor("#6908D6");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       margin: EdgeInsets.only(top: MediaQuery
            .of(context)
            .size
            .height * 0.1),
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              height: 150,
              decoration: BoxDecoration(
                  color: _purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.0)
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Total per person",
                        style: TextStyle(fontSize: 15.0, color: _purple)),
                    Padding(padding: EdgeInsets.only(top: 12.0),
                        child: Text("\$${calculateTotalPerPerson(_personCounter, _billAmount, _tipPercentage)}",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 35.0,
                                color: _purple))
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.blueGrey.shade100, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: <Widget>[
                  InkWell(
                    child: TextField(
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true),
                      cursorColor: _purple,
                      style: TextStyle(color: _purple),
                      decoration: InputDecoration(
                          prefixText: "bill amount",
                          prefixIcon: Icon(Icons.attach_money, color: _purple,)
                      ),
                      onChanged: (value) {
                        try {
                          setState(() {
                            _billAmount = double.parse(value);
                          });
                        } catch (exception) {
                          setState(() {
                            _billAmount = 0.0;
                          });
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Split",
                          style: TextStyle(color: Colors.grey.shade700)),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if(_personCounter > 0)
                                  _personCounter--;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: _purple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Center(
                                child: Text("-", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                    color: _purple),),
                              ),
                            ),
                          ),

                          Text("$_personCounter", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                              color: _purple)),

                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: _purple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.0)
                              ),
                              child: Center(
                                child: Text("+", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                    color: _purple)),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Tip", style: TextStyle(color: Colors.grey
                          .shade700)),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("\$${calculateTotalTip(
                            _personCounter, _billAmount, _tipPercentage)
                            .toStringAsFixed(2) }", style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0, color: _purple)),
                      ),

                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("$_tipPercentage%", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                          color: _purple)),
                      Slider(
                          min: 0.0,
                          max: 100.0,
                          divisions: 10,
                          activeColor: _purple,
                          inactiveColor: Colors.grey.shade200,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              _tipPercentage = newValue.round();
                            });
                          })
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

  calculateTotalPerPerson(int splitBy, double totalBill, int totalTip) {
    if(splitBy > 0){
      var totalPerPerson = (calculateTotalTip(splitBy, totalBill, totalTip) + totalBill) / splitBy;
      return totalPerPerson.toStringAsFixed(2);
    }else
      return 0.0;

  }

  calculateTotalTip(int splitBy, double totalBill, int tipPercent) {
    double totalTip = 0.0;

    if (totalBill < 0 || totalBill
        .toString()
        .isEmpty) {
      final snack = SnackBar(
          content: Text("Must fill the bill with a positive value!"));
      Scaffold.of(context).showSnackBar(snack);
    } else {
      totalTip = (totalBill * tipPercent) / 100;
    }

    return totalTip;
  }
}
