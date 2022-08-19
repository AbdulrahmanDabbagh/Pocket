import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:money_managment/data/db/db.dart';
import 'package:money_managment/home/home_controller.dart';
import 'package:money_managment/home/operations_card.dart';

import '../main.dart';

class homePage extends StatelessWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Operations"),
      ),
      body: StreamBuilder<List<Operation>>(
        stream: db.watchOperations,
        builder: (context, snapshot) {
          final operations = snapshot.data ?? [];
          return ListView.builder(
            itemCount: operations.length,
              itemBuilder: (context, index){
                return OperationsCard(operation: operations[index]);
              },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          final addForm=GlobalKey<FormState>();
          late String amount;
          late String description;
          late String type;
          Get.bottomSheet(Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))
              ),
            padding: const EdgeInsets.all(10),
            child: Form(
              key: addForm,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StreamBuilder<List<Categorie>>(
                      stream: db.watchCategories(),
                      builder: (_,snapshot){
                        final categories = snapshot.data ?? [];
                        return Obx((){
                            final selectedCategory = controller.selectedCategory.value;
                            return DropdownButtonFormField<Categorie>(
                              hint: const Text("select a category"),
                              isExpanded: true,
                              value: categories.isEmpty? null : selectedCategory,
                              validator: (Categorie? category){
                                if(category == null){
                                  return "required";
                                }
                                return null;
                              },
                              items: [
                                for(final category in categories)
                                  DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name),
                                  ),
                                DropdownMenuItem(
                                  value: Categorie(id: -1, name: ""),
                                  child: const Text("add new category"),
                                ),
                              ],
                              onChanged: (Categorie? category){
                                if(category!.id == -1){
                                  late String value;
                                  final form = GlobalKey<FormState>();
                                  Get.bottomSheet(Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Form(
                                      key: form,
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          hintText: "Category name",
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.add),
                                            onPressed: (){
                                              if(form.currentState!.validate()){
                                                db.addCategory(Categorie(name: value));
                                                Get.back();
                                              }
                                            },
                                          )
                                        ),
                                        onChanged: (v) => value = v,
                                        validator: (String? value){
                                          if(value == null || value.isEmpty){
                                            return "required";
                                          }
                                          if(categories.any((element) => element.name.trim() == value.trim())){
                                            return "this category is exist";
                                          }
                                          return null;

                                        },
                                      ),
                                    ),
                                  ));
                                }else{
                                  controller.selectedCategory.value = category;
                                }
                              },
                            );
                          }
                        );
                      }
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "amount",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (v) => amount = v,
                    validator: (String? value){
                      if(value == null || value.isEmpty){
                        return "required";
                      }
                      return null;
                    },
                  ),
                  Obx(() {
                    return TextButton(
                      child: Text(DateFormat('yyyy-MM-dd').format(controller.selectedDate.value)),
                      onPressed: () async{
                        final date = await showDatePicker(
                            context: context,
                            initialDate: controller.selectedDate.value,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100)
                        );
                        if(date != null){
                          controller.selectedDate(date);
                        }
                      },
                    );
                  }),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Description",
                    ),
                    onChanged: (v) => description = v,
                    validator: (String? value){
                      if(value == null || value.isEmpty){
                        return "required";
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    hint: const Text("select a type"),
                    isExpanded: true,
                    validator: (type){
                      if(type == null){
                        return "required";
                      }
                      return null;
                    },
                    items: const [
                      DropdownMenuItem(
                        value: "Income",
                        child: Text("Income"),
                      ),
                      DropdownMenuItem(
                        value: "Outcome",
                        child: Text("Outcome"),
                      ),
                      DropdownMenuItem(
                        value: "Creditor ",
                        child: Text("Creditor "),
                      ),
                      DropdownMenuItem(
                        value: "Debtor",
                        child: Text("Debtor"),
                      ),
                    ],
                    onChanged: (String? string){
                      if(string != null) {
                        type = string;
                      }
                    },

                  ),
                  // Obx((){
                  //   return DropdownButtonFormField<String>(
                  //     hint: const Text("select a type"),
                  //     isExpanded: true,
                  //     validator: (type){
                  //       if(type == null){
                  //         return "required";
                  //       }
                  //       return null;
                  //     },
                  //     items: const [
                  //       DropdownMenuItem(
                  //         value: "Income",
                  //         child: Text("Income"),
                  //       ),
                  //       DropdownMenuItem(
                  //         value: "Outcome",
                  //         child: Text("Outcome"),
                  //       ),
                  //       DropdownMenuItem(
                  //         value: "Creditor ",
                  //         child: Text("Creditor "),
                  //       ),
                  //       DropdownMenuItem(
                  //         value: "Debtor",
                  //         child: Text("Debtor"),
                  //       ),
                  //     ],
                  //     onChanged: (String? string){
                  //         if(string != null) {
                  //           type = string;
                  //         }
                  //       },
                  //
                  //   );
                  // }
                  // ),
                  ElevatedButton(
                    child: Text("Add"),
                    onPressed: (){
                      if(addForm.currentState!.validate()){
                        db.addOperations(Operation(
                            type: type,
                            amount: int.parse(amount),
                            date: controller.selectedDate.value,
                            description: description,
                            catId: controller.selectedCategory.value!.id!
                        ));
                        Get.back();
                      }
                    },
                  )
                ],
              ),
            ),
            )
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
