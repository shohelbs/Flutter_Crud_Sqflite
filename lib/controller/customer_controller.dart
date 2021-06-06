import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_design_demo/db/db_helper.dart';
import 'package:flutter_design_demo/model/customer.dart';
import 'package:flutter_design_demo/view/customer_input.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  List<Customer> customerList = [];
  final dbHelper = DbHelper.db;

  bool isFromUpdate = false;

  // ===== Add customer Field =====
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  var customerId = 0;

  @override
  void onInit() {
    super.onInit();
    _getCustomerList();
  }

  void addCustomerCLick(Customer customer) {
    nameController.clear();
    emailController.clear();
    isFromUpdate = false;
    update();
    Get.to(() => CustomerInput(customer));
  }

  void updateOnClick(Customer customer, int index) {
    isFromUpdate = true;
    update();
    customerId = customerList[index].id;
    nameController.text = customerList[index].name;
    emailController.text = customerList[index].email;
    Get.to(() => CustomerInput(customer));
  }

  _getCustomerList() async {
    final items = await dbHelper.getAllCustomer();
    if (items.isNotEmpty) customerList.assignAll(items);
    update();
  }

  Future<int> addCustomer(Customer customer) async {
    final customerId = await dbHelper.checkCustomer(customer);
    if (customerId > 0) {
      Get.snackbar('Alert', 'Customer Already Exist');
    } else {
      final itemId = await dbHelper.saveCustomer(customer);
      debugPrint(itemId.toString());
      if (itemId > 0) {
        customerList.add(customer);
        update();
        return itemId;
      }
    }
    return 0;
  }

  Future<int> updateCustomer(Customer customer) async {
    final customerId = await dbHelper.getCustomerFromId(customer.id);
    if (customerId > 0) {
      await dbHelper.updateCustomer(customer);
      customerList.clear();
      _getCustomerList();
      return customerId;
    } else {
      Get.snackbar('Alert', 'Customer Not Found');
      return 0;
    }
  }

  deleteCustomer(Customer customer, int index) async {
    final customerId = await dbHelper.checkCustomer(customer);
    if (customerId > 0) {
      await dbHelper.deleteTrans(customer.id);
      customerList.removeAt(index);
      update();
    } else {
      Get.snackbar('Alert', 'Customer  Not Found');
    }
  }
}
