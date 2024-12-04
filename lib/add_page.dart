import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_cubit/cubit_list.dart';
import 'package:notes_cubit/db_helper.dart';
import 'package:notes_cubit/note_model.dart';

class AddPage extends StatefulWidget{

  bool isUpdate;
  String title;
  String desc;
  int? id =0;

  AddPage({this.id,this.isUpdate = false, this.title="", this.desc= ""});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

 late bool isUpdate;
  late String title;
  late String desc;
  int? id ;


  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();
  DbHelper dbHelper = DbHelper.getInstance();


  @override
  void initState(){
    super.initState();

    //initialize local variable

    isUpdate = widget.isUpdate;
    title = widget.title;
    desc = widget.desc;
    id = widget.id;

    // Initialize Controller with initial values

    titleController = TextEditingController(text: widget.title);
    descController = TextEditingController(text: widget.desc);

  }

 void handleSave() {

   String updatedTitle = titleController.text.trim();
   String updateddesc = descController.text.trim();

   if (updatedTitle.isEmpty || updateddesc.isEmpty) {
     ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(
           content:
           Text("Title & Description cannot be empty"),
           backgroundColor: Colors.red,));

     return;
   }

   if (isUpdate) {
     context.read<CubitList>().updateNotes(
         updateNote: NoteModel(
             id: id, title: updatedTitle, desc: updateddesc));
   } else {
     // Add a new note
     context.read<CubitList>().addNotes(listnote: NoteModel(
       title: updatedTitle,
       desc: updateddesc,
     ));
   }
  Navigator.pop(context);

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate? "Update Note" : "Add Note"),
      ),

      body: Padding(
        padding: const EdgeInsets.only(top:18.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: titleController,
                maxLines: 2,
                minLines: 1,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: "Title",hintStyle:TextStyle(fontSize: 21),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11)
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:5),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: descController,
                  maxLines:12,
                  minLines:12,
                  decoration: InputDecoration(
                      hintText: "Type Something here...",hintStyle:TextStyle(fontSize: 21),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)
                      )
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(onPressed:handleSave,
                   child: Text(isUpdate ? "Update":"Add",style: TextStyle(fontSize:18),)),

                  SizedBox(width: 15,),
                  OutlinedButton(onPressed:(){
                    Navigator.pop(context);
                  }, child: Text("Cancel",style: TextStyle(fontSize:18),)),
                ],
              ),
            )

          ],
        ),
      ),

    );
  }
}