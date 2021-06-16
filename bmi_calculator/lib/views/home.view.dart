import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum gender { MALE, FEMALE }

class _HomeScreenState extends State<HomeScreen> {
  var selectedGender = gender.MALE;
  int height = 183;
  int weight = 74;
  int age = 19;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('BMI CALCULATOR'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: genderSelector(),
          ),
          Expanded(
            child: heightSelector(),
          ),
          Expanded(
            child: weightAndAgeSelector(),
          ),
          calculateIBMButton(),
        ],
      ),
    );
  }

  Widget defaultCard(
      {Color? activeColor,
      Color? inactiveColor,
      Widget? child,
      bool isInactive = true}) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 200,
      child: Card(
        color: isInactive
            ? (inactiveColor ?? Color(0xFF111428))
            : (activeColor ?? Color(0xFF1D1F33)),
        child: child ?? Container(),
      ),
    );
  }

  Widget genderSelector() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                this.selectedGender = gender.MALE;
              });
            },
            child: defaultCard(
              child: genderBuilder(
                iconData: FontAwesomeIcons.mars,
                text: 'masculino',
                iconColor: this.selectedGender == gender.MALE
                    ? Colors.white
                    : Colors.grey,
              ),
              isInactive: !(selectedGender == gender.MALE),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                this.selectedGender = gender.FEMALE;
              });
            },
            child: defaultCard(
              child: genderBuilder(
                iconData: FontAwesomeIcons.venus,
                text: 'feminino',
                iconColor: this.selectedGender == gender.FEMALE
                    ? Colors.white
                    : Colors.grey,
              ),
              isInactive: !(selectedGender == gender.FEMALE),
            ),
          ),
        ),
      ],
    );
  }

  Widget heightSelector() {
    return Container(
      child: defaultCard(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'height'.toUpperCase(),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  this.height.toString(),
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'cm',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            Slider(
              value: this.height.toDouble(),
              onChanged: (value) {
                setState(() {
                  this.height = value.toInt();
                });
              },
              inactiveColor: Colors.grey,
              min: 0,
              max: 250,
            )
          ],
        ),
      ),
      width: double.infinity,
    );
  }

  Widget weightAndAgeSelector() {
    return Row(
      children: [
        Expanded(
          child: defaultCard(
            child: valueChanger(
              text: 'weight',
              value: this.weight,
              increaseCallBack: () {
                setState(() {
                  this.weight++;
                });
              },
              decreaseCallBack: () {
                setState(() {
                  this.weight--;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: defaultCard(
            child: valueChanger(
              text: 'age',
              value: this.age,
              increaseCallBack: () {
                setState(() {
                  this.age++;
                });
              },
              decreaseCallBack: () {
                setState(() {
                  this.age--;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget calculateIBMButton() {
    return Container(
      color: Color(0xFFEB1555),
      width: double.infinity,
      height: 50,
      child: TextButton(
        child: Text(
          'CALCULATE YOUR BMI',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget genderBuilder(
      {required IconData iconData, required String text, Color? iconColor}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          iconData,
          size: 80,
          color: iconColor ?? Colors.white,
        ),
        Text(
          text.toUpperCase(),
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }

  Widget valueChanger(
      {required String text,
      required int value,
      VoidCallback? decreaseCallBack,
      VoidCallback? increaseCallBack}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
        Text(
          value.toString(),
          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          child: Container(),
        ),
        GestureDetector(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Icon(FontAwesomeIcons.minus),
                    decoration: BoxDecoration(
                      color: Color(0xFF2D2F43),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onTap: decreaseCallBack,
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Icon(FontAwesomeIcons.plus),
                    decoration: BoxDecoration(
                      color: Color(0xFF2D2F43),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onTap: increaseCallBack,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
