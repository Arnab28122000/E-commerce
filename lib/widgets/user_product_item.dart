import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products.dart';

class UserProductItem extends StatefulWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id,this.title, this.imageUrl);

  @override
  _UserProductItemState createState() => _UserProductItemState();
}

class _UserProductItemState extends State<UserProductItem> {
  @override
  Widget build(BuildContext context) {
    final scaffold= Scaffold.of(context);
    return ListTile(
      title: Text(widget.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.imageUrl),
      ),
      trailing: Container(
        width: 100,
              child: Row(
          children:<Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditProductScreen.routeName,
                arguments: widget.id,
                );
            },
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              return showDialog(context: context, builder: (ctx) => 
              AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to remove the item from your products?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                 Navigator.of(ctx).pop(false);
              },
               child: Text('No'),
               ),
               FlatButton(
                 onPressed: () async{
                   try{
                    Provider.of<Products>(context, listen: false).deleteProduct(widget.id);
                     Navigator.of(ctx).pop(true);
                   }catch(error){
                     scaffold.showSnackBar(
                       SnackBar(
                       content:Text('Deleting Failed!', textAlign:TextAlign.center ,),
                     ));
                   }  
                 }, 
                 child: Text('Yes'),
                 ),
          ],
              ),
              );
            },
            color: Theme.of(context).errorColor,
          ),
          ],
        ),
      ),
    );
  }
}
