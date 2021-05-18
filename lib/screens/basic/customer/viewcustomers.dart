import 'package:flutter/material.dart';
import 'package:zetian/partials/sidemenu.dart';
import 'package:zetian/screens/basic/customer/addcustomer.dart';

class ViewCustomers extends StatefulWidget {
  @override
  _ViewCustomersState createState() => _ViewCustomersState();
}

class _ViewCustomersState extends State<ViewCustomers> {
  bool customerList = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Center(
          child: Text(
            'Customers',
            style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'Montserrat',
                color: Colors.green,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      endDrawer: SideMenu(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 768) {
            //
            // Tablet View
            //
            // If Customers list is empty show the empty customer screen
            if (customerList == false) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center ,
                  children: [
                    Text(
                      'No Customers',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 28.0,
                      ),
                    ),
                    Icon(
                      Icons.error,
                      color: Colors.black38,
                      size: 50.0,
                    )
                  ],
                ),
              );
            } else {
              // If Customers list is not empty, show customer list
              return Center(
                child: Container(
                  padding: EdgeInsets.only(top: 20.0, bottom: 50.0),
                  constraints: BoxConstraints(maxWidth: 600),
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Card(
                        //                           <-- Card widget
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Customer Name'),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          } else {
            //
            // Mobile View
            //
            // If Customers list is empty show the empty customer screen
            if (customerList == false) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center ,
                  children: [
                    Text(
                      'No Customers',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 28.0,
                      ),
                    ),
                    Icon(
                      Icons.error,
                      color: Colors.black38,
                      size: 50.0,
                    )
                  ],
                ),
              );
            } else {
              // If Customers list is not empty, show customer list
              return Container(
                padding: EdgeInsets.only(bottom: 70.0),
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Card(
                      //                           <-- Card widget
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Customer Name'),
                      ),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddCustomer()));
        },
        label: Text(
          'New Customer',
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
        ),
        icon: Icon(
          Icons.add,
          size: 30.0,
        ),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}