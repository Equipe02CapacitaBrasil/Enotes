//
//  HomeView.swift
//  ENotes
//
//  Created by iredefbmac_27 on 15/07/25.
//
import SwiftUI

import Charts

struct HomeView: View {
    @ObservedObject var viewModel: LoginViewModel
    @State private var navigationPath = NavigationPath()
    
    @State private var showPopup = false // controla exibição do pop-up
    @State private var name = ""
    @State private var description = ""
    
    @State private var showSettings = false
    
    
    let dados = [
        
        Activities(done: 10, undone: 5 , month:"Janeiro"),
        Activities(done: 15, undone: 3, month: "Fevereiro"),
        Activities(done: 9, undone: 4, month: "Março")

    ]
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            
            ZStack {
                Color.lightBlue
                    .ignoresSafeArea()
                
                
                
                VStack(spacing: 20) {
                    // Barra superior
                    TopBar(firstButton: "plus", secondButton: "gearshape.fill", showSettings: $showSettings)
                    
                    // Conteúdo principal
                    VStack {
                        
                    
                        Text("Relatório")
                            .bold()
                            .font(.title)
                        
                        
                        Chart(dados) { item in
                            SectorMark(
                                angle: .value("Valor", item.done),
                                innerRadius: .ratio(0.6),  // 0 = pizza, >0 = doughnut
                                angularInset: 3        // espaço entre setores
                            )
                            .foregroundStyle(by: .value("Mês", item.month))
                        }
                        
                    }
                    .padding()
                    .frame(width:300,height:550)
                    .cornerRadius(10)
                    .background()
                    .shadow(color:.gray.opacity(0.4),radius: 5,x:0,y:10)
                    // Barra inferior
                    
                    BottomBar(
                        firstButton: "book.fill",
                        secondButton: "house.fill",
                        thirdButton:"checklist",
                        firstAction: {
                            navigationPath.append(Routes.notes)
                        },
                        secondAction: {
                            
                        },
                        thirdAction: {
                            navigationPath.append(Routes.tasks)
                        })
                    
                }
                
                if showSettings {
                        SettingsView(showSettings: $showSettings)
                            .edgesIgnoringSafeArea(.all)
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut, value: showSettings)
                        }
                }
            
               
                // Pop-up tipo alerta
                if showPopup {
                    // Fundo semi-transparente
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture { showPopup = false } // fecha ao tocar fora
                    
                    // Caixa retangular do pop-up
                    VStack(spacing: 20) {
                        TextField("Nome da Atividade",text : $name)
                        
                            
                        
                        TextEditor( text: $description)
                            .frame(width: 300, alignment: .center)
                            
                        HStack{
                            Image(systemName: "calendar")
                            Image(systemName: "flag")
                            
                        }
                        
                        Button("Criar") {
                            showPopup = false
                        }
                        
                    }
                    .padding()
                    .frame(width: 300)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .transition(.scale) // animação ao aparecer/desaparecer
                }
            }
            .animation(.easeInOut, value: showPopup)
            
            .navigationDestination(for: Routes.self) { route in
                switch route {
                case .notes:
                    NotesView()
                case .tasks:
                    TasksView()
                }
            }
        }
    }


struct HomeView_Provider : PreviewProvider {
    static var previews : some View{
        HomeView(viewModel : LoginViewModel())
    }
}

struct Activities : Identifiable{
    var id = UUID()
    var done : Int
    var undone : Int
    var month : String
    
}
