//
//  NotesListView.swift
//  ENotes
//
//  Created by iredefbmac_27 on 01/09/25.
//

import SwiftUI
import SwiftData
struct NotesListView : View{
    @Environment(\.dismiss) var dismiss
    @State private var showSettings = false
    @Environment(\.modelContext) var context
    @Query private var notes : [Notes]
    @Environment(\.colorScheme) var colorScheme
    var body : some View {
        ZStack{
            Color.lightBlue
                .ignoresSafeArea()
            
            VStack
            {
                TopBar(firstButton: "arrow.left",
                       secondButton: "gearshape.fill",
                       showSettings: $showSettings)
                VStack{
                    Text("Minhas notas")
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding(20)
                    List{
                        ForEach(notes){ note in
                            Section{
                                VStack{
                                    HStack(){
                                        Text(note.mood)
                                        Spacer()
                                        Text(note.date.formatted(date: .abbreviated, time:.omitted))
                                    }
                                    Spacer()
                                    Text(note.text)
                                        .font(.headline)
                                }
                            }
                            
                        }
                        .onDelete(perform: deleteNote)
                    }
                }
                .padding()
                .frame(width: 300, height: 650)
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 10)
            }
            
            
            if showSettings {
                SettingsView(showSettings: $showSettings)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.move(edge: .bottom))
            }        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    private func deleteNote(at offsets : IndexSet){
        offsets.forEach { index in
            let note = notes[index]
            context.delete(note)
        }
        try? context.save()           
    }

}

struct NotesListView_Preview : PreviewProvider{
    static var previews : some View{
        NotesListView()
    }
}

