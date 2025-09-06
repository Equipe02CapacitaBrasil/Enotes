//
//  NotesViewModel.swift
//  ENotes
//
//  Created by iredefbmac_27 on 20/08/25.
//

import SwiftUI
import SwiftData
import Combine

class NotesViewModel : ObservableObject{
    @Published var notes : [Notes] = []
    
    func addNote(text: String, date: Date, mood: String, context: ModelContext){
        
        let newNote = Notes(text: text, mood: mood, date: date)
        if newNote.text != "Escreva aqui!" && newNote.text != "" {
            context.insert(newNote)
            try? context.save()
            fetchNote(context: context)
        }else{
            print("Por favor crie uma nota!")
        }
    }
    
    func deleteNote(at offSets : IndexSet, context : ModelContext ){
        offSets.map{notes[$0]}.forEach{
            context.delete($0)
        }
        try? context.save()
        fetchNote(context: context)
    }
    
    func filterNote(){
        
    }
    
    func fetchNote(context : ModelContext){
        let descriptor = FetchDescriptor<Notes>()
        do {
            try self.notes = context.fetch(descriptor)
        }catch{
            fatalError("Não foi achada nenhuma tarefa salva")
    }
    }
    
    
    
}

