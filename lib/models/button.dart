import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }

}

class _MyHomePageState extends State<MyHomePage> {
  // needs to use print number and  operator
  dynamic text ='';
  double numOne = 0;
  double numTwo = 0;
  List<String> numbers = [];
  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';


  Widget buttons(String btnText,Color color,double height,double  width,double mtop,double mbottom,double mleft,double mright,double fontSize){
    // buttons build
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(left: mleft,top: mtop,right: mright,bottom: mbottom),
      decoration: BoxDecoration(
          border: Border.all(
              width: 0.5,
              color: Colors.black
          ),
          color: color
      ),
      child: TextButton(
        onPressed: (){
          calculation(btnText);
        },
        child: Text(btnText,style: TextStyle(fontSize: fontSize,color: Colors.white),),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // locke rotate
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF010808),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: SafeArea(
              child: Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin:EdgeInsets.only(top: 85.0,left: 10.0),
                        child:Text(text,style: TextStyle(color: Colors.white,fontSize: 50.0),) ,
                      ),
                    ),
                    //  > all buttons >
                    Row(
                      children: <Widget>[
                        buttons("c",Color(0xFF08151A),97.0,97.0,40.0,0.0,0.0,0.0,35.0,),
                        buttons("+/-",Color(0xFF08151A),97.0,97.0,40.0,0.0,0.0,0.0,30.0,),
                        buttons("%",Color(0xFF08151A),97.0,97.0,40.0,0.0,0.0,0.0,35.0,),
                        buttons("+",Color(0xFF093B3C),97.0,97.0,40.0,0.0,0.0,0.0,40.0,),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        buttons("1",Color(0xFF08151A),97.0,97.0,0.0,0.0,0.0,0.0,30.0,),
                        buttons("2",Color(0xFF08151A),97.0,97.0,0.0,0.0,0.0,0.0,30.0,),
                        buttons("3",Color(0xFF08151A),97.0,97.0,0.0,0.0,0.0,0.0,30.0,),
                        buttons("-",Color(0xFF093B3C),97.0,97.0,0.0,0.0,0.0,0.0,40.0,),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        buttons("4",Color(0xFF08151A),97.0,97.0,0.0,0.0,0.0,0.0,30.0,),
                        buttons("5",Color(0xFF08151A),97.0,97.0,0.0,0.0,0.0,0.0,30.0,),
                        buttons("6",Color(0xFF08151A),97.0,97.0,0.0,0.0,0.0,0.0,30.0,),
                        buttons("x",Color(0xFF093B3C),97.0,97.0,0.0,0.0,0.0,0.0,40.0,),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        buttons("7",Color(0xFF08151A),97.0,97.0,0.0,0.0,0.0,0.0,30.0,),
                        buttons("8",Color(0xFF08151A),97.0,97.0,0.0,0.0,0.0,0.0,30.0,),
                        buttons("9",Color(0xFF08151A),97.0,97.0,0.0,0.0,0.0,0.0,30.0,),
                        buttons("/",Color(0xFF093B3C),97.0,97.0,0.0,0.0,0.0,0.0,40.0,),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        buttons("0",Color(0xFF08151A),97.0,97.0,0.0,0.0,0.0,0.0,30.0,),
                        buttons(".",Color(0xFF08151A),97.0,97.0,0.0,0.0,0.0,0.0,30.0,),
                        buttons("=",Color(0xFF29ACA1),97.0,195.0,0.0,0.0,0.0,0.0,40.0,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  // Action in bottom >>>>>>>>>>>>>> 
  
  //Calculator logic // 

  void calculation(btnText) {
    if(btnText  == 'c') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();

      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
