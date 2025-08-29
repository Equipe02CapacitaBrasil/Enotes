//
//  NotesView.swift
//  ENotes
//
//  Created by iredefbmac_27 on 15/08/25.
//
import SwiftUI

struct NotesView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = NotesViewModel()
    
    @State private var newNoteText: String = "Escreva aqui!"
    @State private var newNoteDate: Date = Date.now
    @State private var newNoteMood: String = "Happy"
    @State private var showMoodBar: Bool = false
    @State private var showSettings = false
    
    var body: some View {
        ZStack {
            
            // Fundo
            Color.lightBlue
                .ignoresSafeArea()
            
            VStack {
                // Top Bar
                TopBar(firstButton: "arrow.left",
                       secondButton: "gearshape.fill",
                       showSettings: $showSettings)
                
                // Editor de notas
                VStack {
                    Text(newNoteDate.formatted(date: .abbreviated, time: .shortened))
                    
                    ZStack(alignment: .topLeading) {
                        if newNoteText.isEmpty {
                            Text("Escreva aqui")
                                .foregroundColor(.gray)
                                .padding(14)
                        }
                        TextEditor(text: $newNoteText)
                            .padding(10)
                    }
                }
                .padding()
                .frame(width: 300, height: 550)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 10)
                
                // Bottom bar
                BottomBar(
                    firstButton: "face.smiling",
                    secondButton: "checkmark.circle.fill",
                    thirdButton: "list.bullet",
                    firstAction: {
                        withAnimation { showMoodBar = true }
                    },
                    secondAction: {
                        viewModel.addNote(
                            text: newNoteText,
                            date: newNoteDate,
                            mood: newNoteMood
                        )
                        newNoteText = ""
                        newNoteDate = Date.now
                    },
                    thirdAction: {}
                )
            }
            
            // Settings View
            if showSettings {
                SettingsView(showSettings: $showSettings)
                    .edgesIgnoringSafeArea(.all)
                    .transition(.move(edge: .bottom))
            }
            
            // Mood Bar
            if showMoodBar {
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .frame(height: 250)
                        .shadow(radius: 10)
                        .overlay(
                            ZStack {
                                Color.lightBlue
                                VStack {
                                    // Header da MoodBar
                                    HStack {
                                        Spacer()
                                        Text("Seu humor hoje")
                                            .font(.title)
                                            .fontWeight(.bold)
                                        Spacer()
                                        Button {
                                            withAnimation { showMoodBar = false }
                                        } label: {
                                            Image(systemName: "xmark")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .padding(.trailing, 16)
                                        }
                                    }
                                    .padding(.bottom,60)
                                    
                                    // Botões de humor
                                    HStack(spacing: 20) {
                                       
                                        Button(action: { newNoteMood = "Ok" } ,label :{
                                            Image(systemName: "face.smiling")
                                            .font(.largeTitle)                                        })
                                        Button( action:  { newNoteMood = "Normal" }, label: {
                                            Image(systemName: "face.neutral")
                                            .font(.largeTitle)                                        })
                                        Button ( action: {newNoteMood = "Happy" }, label: {
                                            Image(systemName: "face.smiling.fill")
                                                .font(.largeTitle)
                                        })
                                        Button( action : { newNoteMood = "Tired" },label: {
                                            Image(systemName: "face.dashed")
                                            .font(.largeTitle)                                        })
                                        Button ( action:  { newNoteMood = "Sad" }, label : {
                                            Image(systemName: "face.frown")
                                            .font(.largeTitle)
                                        })
                                    }
                                }
                            }
                        )
                }
                .transition(.move(edge: .bottom))
                .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}


