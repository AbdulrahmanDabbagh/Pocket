import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_managment/data/db/db.dart';

import '../main.dart';

class OperationsCard extends StatelessWidget {
  const OperationsCard({Key? key, required this.operation}) : super(key: key);
  final Operation operation;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (detials){
        // print(detials.globalPosition);
        print(detials.globalPosition.dy);
        showMenu(
            context: context,
            position: RelativeRect.fromLTRB(detials.localPosition.dx, detials.globalPosition.dy, detials.localPosition.dx, detials.localPosition.dy),
            items: [
              PopupMenuItem(
                value: 1,
                child: Text("posts"),
              ),
              PopupMenuItem(
                value: 2,
                child: Text("albums"),
              ),
              PopupMenuItem(
                value: 3,
                child: Text("todos"),
              ),
            ]
        );
      },
      child: Card(
        child: ListTile(
          leading: IconButton(
            icon: Icon(Icons.delete_forever),
              onPressed: (){
              db.removeOperation(operation);
              },
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(operation.amount.toString() ,
                  style: TextStyle(fontSize: 22),
                ),
              Text(operation.description),
            ],
          ),
          subtitle: Text(DateFormat("yyyy/MM/dd").format(operation.date)),
          trailing: Column(
            children: [
              FutureBuilder<Categorie>(
                future: db.getCategory(operation.catId),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const SizedBox();
                  }
                  final category = snapshot.data;
                  return Text(category!.name);
                },
              ),

              Text(

                operation.type,
                style: TextStyle(color: Colors.red),
              ),
            ],
          )


        ),
      ),
    );
  }
}
