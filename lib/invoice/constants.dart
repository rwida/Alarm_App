import 'package:flutter/material.dart';

class ScreenConfig {
  static double deviceWidth;
  static double deviceHeight;
  static double designHeight = 1300;
  static double designWidth = 600;
  static init(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
  }

  static double getProportionalHeight(height) {
    return deviceHeight * height / designHeight;
  }

  static double getProportionalWidth(width) {
    return deviceWidth * width / designWidth;
  }
}

const iPrimaryColor = Color(0xFFF9FCFF);
const iAccentColor = Color(0xFFFFB44B);
const iAccentColor2 = Color(0xFFFFEAC9);

const demoDate = [
  {
    "imagePath": "images/img1.jpg",
    "price": 10,
    "quantity": 1,
    "itemDesc": "Chicken Burger"
  },
  {
    "imagePath": "images/img1.jpg",
    "price": 10,
    "quantity": 1,
    "itemDesc": "Chicken Burger"
  },
  {
    "imagePath": "images/img1.jpg",
    "price": 10,
    "quantity": 1,
    "itemDesc": "Chicken Burger"
  },
  {
    "imagePath": "images/img1.jpg",
    "price": 10,
    "quantity": 2,
    "itemDesc": "Chicken Burger"
  },
  {
    "imagePath": "images/img1.jpg",
    "price": 10,
    "quantity": 1,
    "itemDesc": "Chicken Burger"
  },
  {
    "imagePath": "images/img1.jpg",
    "price": 10,
    "quantity": 1,
    "itemDesc": "Chicken Burger"
  },
  {
    "imagePath": "images/img1.jpg",
    "price": 10,
    "quantity": 1,
    "itemDesc": "Chicken Burger"
  },
  {
    "imagePath": "images/img1.jpg",
    "price": 10,
    "quantity": 1,
    "itemDesc": "Chicken Burger"
  },
];