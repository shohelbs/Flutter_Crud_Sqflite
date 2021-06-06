import 'package:flutter/material.dart';
import 'package:flutter_design_demo/controller/customer_controller.dart';
import 'package:flutter_design_demo/model/customer.dart';
import 'package:flutter_design_demo/view/customer_input.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomerList(),
    );
  }
}

class CustomerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(
        init: CustomerController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Design Demo'),
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[_getListView(), _addCustomer(controller)],
            ),
          );
        });
  }

  Expanded _getListView() {
    final controller = Get.put(CustomerController());
    return Expanded(
      child: ListView.builder(
        itemCount: controller.customerList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = controller.customerList[index];
          return _listItem(item, controller, index);
        },
      ),
    );
  }

  Widget _addCustomer(CustomerController controller) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 50,
        width: 250,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
        child: TextButton(
          onPressed: () {
            controller.addCustomerCLick(Customer('', ''));
          },
          child: Text(
            'Add Customer',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }

  Widget _listItem(
      Customer customer, CustomerController controller, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    customer.name,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(customer.email)
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      controller.updateOnClick(customer, index);
                    }),
                IconButton(
                    icon: Icon(Icons.delete, color: Colors.grey),
                    onPressed: () {
                      controller.deleteCustomer(customer, index);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
