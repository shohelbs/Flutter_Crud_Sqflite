import 'package:flutter/material.dart';
import 'package:flutter_design_demo/controller/customer_controller.dart';
import 'package:flutter_design_demo/model/customer.dart';
import 'package:get/get.dart';

class CustomerInput extends StatelessWidget {
  final CustomerController controller = Get.find();
  Customer _customer;

  CustomerInput(Customer customer){
    _customer = customer;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Customer'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Center(
              child: Container(
                  width: 200,
                  height: 150,
                  /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                  child: Image.asset('asset/images/flutter-logo.png')),
            ),
          ),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'Enter Enter Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter Enter Email'),
            ),
          ),
          FlatButton(
            onPressed: () {
              //TODO FORGOT PASSWORD SCREEN GOES HERE
            },
            child: Text(
              'Forgot Password',
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ),
          ),
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: FlatButton(
              onPressed: () async {
                _customer.name = controller.nameController.text;
                _customer.email = controller.emailController.text;
                if (controller.isFromUpdate == false) {
                  final rowId = await controller.addCustomer(_customer);
                  if (rowId > 0) {
                    Get.back();
                  }
                } else {
                  final rowId = await controller.updateCustomer(_customer);
                  if (rowId > 0) {
                    Get.back();
                  }
                }
              },
              child: Text(
                controller.isFromUpdate == false
                    ? 'Create Customer'
                    : 'Update Customer',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Text('New User? Create Account')
        ],
      ),
    );
  }
}
