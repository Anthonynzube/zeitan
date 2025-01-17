import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zetian/mixins/expense_helper.dart';
import 'package:zetian/models/expense/read/get_expense_response.dart';
import 'package:zetian/providers/app_provider.dart';
import 'package:zetian/providers/employee_provider.dart';
import 'package:zetian/providers/expense_provider.dart';
import 'package:zetian/screens/basic/expense/expensedetail.dart';

class ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> with ExpenseHelper {
  bool expenseList = true;
  List<GetExpenseResponse> expenseResult = [];
  var formatter = new DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    getAllExpenses(Provider.of<AppProvider>(context, listen: false).dio,
        Provider.of<AppProvider>(context, listen: false).baseUrl, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
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
                'Expenses List',
                style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Montserrat',
                    color: Colors.green,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
                // Mobile View
                //
                // If Expenses list is empty show the empty Expenses screen
                if (expenseList == false) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center ,
                      children: [
                        Text(
                          'No Expenses',
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
                  // If Expenses list is not empty, show Expenses list
                  return Provider.of<ExpenseProvider>(context, listen: true)
                          .isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          strokeWidth: 4,
                        ))
                      : Container(
                          // padding: EdgeInsets.only(bottom: 70.0),
                          child: ListView.builder(
                            itemCount: provider.expenses.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Provider.of<EmployeeProvider>(context,
                                              listen: false)
                                          .isLoading
                                      ? Center(
                                          child: Container(
                                              margin: EdgeInsets.only(
                                                  top: 30.0, bottom: 30),
                                              width: 100,
                                              height: 100,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              )))
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ExpenseDetail(
                                                      expenseDetails: provider
                                                          .expenses[index])));
                                },
                                child: Card(
                                  //                           <-- Card widget
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.account_balance_wallet,
                                      size: 30,
                                    ),
                                    title: Text(
                                      provider.expenses[index].expense,
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      formatter.format(provider.expenses[index].date).toString(),
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    trailing: Text(
                                      "₦" +
                                          provider.expenses[index].amount
                                              .toString(),
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                }
            },
          ),
        );
      },
    );
  }
}
