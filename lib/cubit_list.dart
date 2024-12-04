

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_cubit/db_helper.dart';
import 'package:notes_cubit/note_state.dart';

import 'note_model.dart';

class CubitList extends Cubit<NoteState>{

  DbHelper dbHelper = DbHelper.getInstance();
  CubitList() :super(NoteState(mNotes:[]));

    addNotes({required NoteModel listnote}) async{

    bool check = await dbHelper.addNote(listnote);

    if(check){
      List<NoteModel> notes = await dbHelper.fetchNote();
      emit(NoteState(mNotes:notes));

    }

  }

   getAllNotes() async {

     List<NoteModel> mData = await dbHelper.fetchNote();
     emit(NoteState(mNotes: mData));

  }

     updateNotes({required NoteModel updateNote}) async{

     bool check = await dbHelper.updateNote(updateNote: updateNote);
     if(check){
       List<NoteModel> upNotes =await dbHelper.fetchNote();
       emit(NoteState(mNotes: upNotes));
     }

  }

  void deleNotes({required int id}) async {
      bool check = await dbHelper.deleteNotes(id: id);
      if(check){
        List<NoteModel> delNotes = await dbHelper.fetchNote();
        emit(NoteState(mNotes: delNotes));
      }


  }




  }


