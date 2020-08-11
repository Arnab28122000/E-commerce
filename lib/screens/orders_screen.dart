import '../widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder:(ctx, dataSnapShot) {
          if(dataSnapShot.connectionState == ConnectionState.waiting){
            return Center(
        child: CircularProgressIndicator(),
      );
          }else{
            if(dataSnapShot.error != null){
              return Center(
                child:AlertDialog(
                  title: Text('Something went wrong!'),
                  content: Text('Looks like an error occured while placing an Order.'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                 Navigator.of(ctx).pop(true);
              },
               child: Text('Okay'),
               ),
          ],
                ),
              );
            }else{
              return Consumer<Orders>(
                builder: (ctx, orderData, child) =>ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
        ),
              );
            }
          }
        },
        ) 
    );
  }
}