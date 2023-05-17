import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(
    home: mainpage(),
    debugShowCheckedModeBanner: false,

  ));
}

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filepermission();
  }
  Future<void> filepermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await [
        Permission.storage,
      ].request();
    }
  }

  String? gender;
  bool mango = false;
  bool orange = false;
  bool banana = false;
  var items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,13,14,15,16];
  int mangocount = 1;
  int bananacount = 1;
  int orangecount = 1;

  double mangorate=0;
  double orangerate=0;
  double bananarate=0;

  String discount="apna gender select karo!";
  double totalrate = 0;

  totalbill(){
    setState(() {
      if(orange== true || mango==true || banana==true || orange== false || mango==false || banana==false){
        (mango==true?mangorate=50.0*mangocount:mangorate=0.0*mangocount);
        (orange==true?orangerate=25.0*orangecount:orangerate=0.0*orangecount);
        (banana==true?bananarate=15.0*bananacount:bananarate=0.0*bananacount);

        totalrate=mangorate+orangerate+bananarate;
        if(gender=="Male"){
          totalrate=mangorate+orangerate+bananarate;

        }
        if(gender=="Female"){
          double percentfind=totalrate*5/100;
          totalrate=totalrate-percentfind;
        }

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    double totalheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: totalheight * 0.1, bottom: totalheight * 0.03),
              child: Text(
                "Radio and Checkbox",
                style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: totalheight * 0.032,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: totalheight * 0.02),
              alignment: Alignment.centerLeft,
              child: Text(
                "Gender : ",
                style: TextStyle(fontSize: totalheight * 0.025,fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Radio(
                  value: "Male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                      discount="no discount for male, hahah..!";
                      totalbill();
                      print(gender);
                    });
                  },
                ),
                Text(
                  "Male",
                  style: TextStyle(fontSize: totalheight * 0.020),
                ),
                Radio(
                  value: "Female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                      discount="5% will be deducted from bill";
                      totalbill();
                      print(gender);
                    });
                  },
                ),
                Text(
                  "Female",
                  style: TextStyle(fontSize: totalheight * 0.020),
                ),
              ],
            ),
            SizedBox(
              height: totalheight * 0.015,
            ),
            Container(
              margin: EdgeInsets.only(left: totalheight * 0.02),
              child: Text(
                "Buy Items : ",
                style: TextStyle(fontSize: totalheight * 0.025,fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: totalheight * 0.02),
              child: Row(
                children: [
                  Checkbox(
                    value: mango,
                    onChanged: (value) {
                      setState(
                        () {
                          mango = value!;
                          print("mangocount== $mangocount");
                          totalbill();
                        },
                      );
                    },
                  ),
                  Text(
                    "Mango",
                    style: TextStyle(fontSize: totalheight * 0.020),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 110),
                    child: Text("₹50 == 1 quantity"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: totalheight * 0.02),
              child: Row(
                children: [
                  Checkbox(
                    value: orange,
                    onChanged: (value) {
                      setState(
                        () {
                          orange = value!;
                          print("orangecount==$orangecount");
                          totalbill();
                        },
                      );
                    },
                  ),
                  Text(
                    "Orange",
                    style: TextStyle(fontSize: totalheight * 0.020),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade50,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    width: 80,
                    margin: EdgeInsets.only(left: 10),
                    child: Center(
                      child: DropdownButton(
                        underline: Container(),
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Colors.lightBlue,
                        value: orangecount,
                        items: items.map(
                          (var items) {
                            return DropdownMenuItem(
                              child: Center(
                                child: Text("$items"),
                              ),
                              value: items,
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(
                            () {
                              orangecount = value!;
                              totalbill();
                              print("orangecount==$orangecount");
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text("₹25 == 1 quantity"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1,),
            Container(
              margin: EdgeInsets.only(left: totalheight * 0.017),
              child: Row(
                children: [
                  Checkbox(
                    value: banana,
                    onChanged: (value) {
                      setState(
                        () {
                          banana = value!;
                          print("bananacount==$bananacount");
                          totalbill();
                        },
                      );
                    },
                  ),
                  Text(
                    "Banana",
                    style: TextStyle(fontSize: totalheight * 0.020),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade50,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    width: 80,
                    margin: EdgeInsets.only(left: 10),
                    child: Center(
                      child: DropdownButton(
                        underline: Container(),
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Colors.lightBlue,
                        value: bananacount,
                        items: items.map(
                          (var items) {
                            return DropdownMenuItem(
                              child: Center(
                                child: Text("$items"),
                              ),
                              value: items,
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(
                            () {
                              bananacount = value!;
                              print("bananacount==$bananacount");
                              totalbill();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text("₹15 == 1 quantity"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: totalheight * .025,
                  left: totalheight * .015,
                  right: totalheight * .015),
              height: totalheight * .35,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Center(
                        child: Text(
                      "Total Payable Amount",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22),
                    ),),
                    SizedBox(height: totalheight*.01,),
                    Text("Mango   = ₹$mangorate",style: TextStyle(fontSize: 16),),
                    SizedBox(height: totalheight*.01,),
                    Text("Orange   = ₹$orangerate",style: TextStyle(fontSize: 16),),
                    SizedBox(height: totalheight*.01,),
                    Text("Banana  = ₹$bananarate",style: TextStyle(fontSize: 16),),
                    SizedBox(height: totalheight*.01,),
                    Text("Total Discount = $discount",style: TextStyle(fontSize: 16),),
                    SizedBox(height: totalheight*.01,),
                    Text("Total    = ₹$totalrate",style: TextStyle(fontSize: 20),),
                    SizedBox(height: totalheight*.01,),
                  ],
                ),
              ),
            ),
            SizedBox(height: totalheight*.05,),
            Center(
              child: Container(height: 45,width: 200,
                child: ElevatedButton(onPressed: () {
                  //
                }, child: Text("Generate and Send PDF"),),
              ),
            )
          ],
        ),
      ),
    );
  }
}