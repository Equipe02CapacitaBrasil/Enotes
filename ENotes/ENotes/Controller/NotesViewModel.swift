//
//  NotesViewModel.swift
//  ENotes
//
//  Created by iredefbmac_27 on 20/08/25.
//

import SwiftUI

class NotesViewModel : ObservableObject{
    @Published var notes : [Notes] = []
    
    func addNote(text: String, date: Date, mood: String){
        let newNote = Notes(text: text, mood: mood, date: date)
        notes.append(newNote)
    }
    
    func deleteNote(at offSets : IndexSet ){
        notes.remove(atOffsets: offSets)
    }
    
    func filterNote(){
        
    }
    
    
    
}

