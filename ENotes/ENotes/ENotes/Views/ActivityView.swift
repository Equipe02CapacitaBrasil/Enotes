//
//  ActivityView.swift
//  ENotes
//
//  Created by iredefbmac_27 on 15/07/25.
//
import SwiftUI
import SwiftData


struct ActivityView : View{
    
    var task : Tasks
    @Environment(\.dismiss) var dismiss
    @State private var comentario = ""
    @State private var showSettings = false
    
    
    var body : some View{
        ZStack{
            Color.lightBlue
                .ignoresSafeArea()
            
            VStack(spacing:20){
               
                TopBar(firstButton: "arrow.left", secondButton: "gearshape.fill", showSettings: $showSettings)
                
                
                VStack{
                    HStack{
                        Image(systemName: task.isDone ? "circle.fill" : "square")
                        Text(task.date.formatted(date:.abbreviated,time: .shortened))
                        Spacer()
                        Image(systemName: "flag")
                        
                    }
                    Spacer()
                    HStack{
                        Text(task.title)
                        Spacer()
                    }
                        .font(.title)
                    Spacer()
                    TextEditor(text: $comentario)
                        .frame(height: .infinity)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                    )
                    Spacer()
                }
                .padding()
                .frame(width:300,height:550)
                .cornerRadius(10)
                .background()
                .shadow(color:.gray.opacity(0.4),radius: 5,x:0,y:10)
                
                BottomBar(
                    firstButton: "trash.fill",
                    secondButton: "house.fill",
                    thirdButton: "checklist",
                    firstAction: {},
                    secondAction: {},
                    thirdAction: {})
                

            }
            if showSettings {
                    SettingsView(showSettings: $showSettings)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: showSettings)
                    }
            
            }
        .navigationBarBackButtonHidden(true)
    }
    
}

struct ActivityView_provider : PreviewProvider {
    static var previews: some View {
        ActivityView(task: Tasks(title: "Gym", date: Date.now))
    }
}
