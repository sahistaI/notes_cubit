import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_cubit/cubit_list.dart';
import 'package:notes_cubit/note_model.dart';

import 'add_page.dart';

class NotesUi extends StatefulWidget{

  @override
  State<NotesUi> createState() => _NotesUiState();
}

class _NotesUiState extends State<NotesUi> {
  List<NoteModel> mList = [];


  @override
  Widget build(BuildContext context) {

  List<NoteModel> mList = context.watch<CubitList>().state.mNotes;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cubit Notes"),
      ),
      body: ListView.builder(
          itemCount: mList.length,
          itemBuilder: (_,index){
        return ListTile(
          title: Text(mList[index].title,style: TextStyle(fontSize: 18),),
          subtitle: Text(mList[index].desc,style: TextStyle(fontSize: 15),),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage
                    (isUpdate:true,id:mList[index].id,title: mList[index].title,desc: mList[index].desc,))
                    ,);} , icon:Icon(Icons.edit)),
                IconButton(onPressed: (){

                  context.read<CubitList>().deleNotes(id:mList[index].id!);

                }, icon:Icon(Icons.delete,color: Colors.red,)),
              ],
            )
             ),
             );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}