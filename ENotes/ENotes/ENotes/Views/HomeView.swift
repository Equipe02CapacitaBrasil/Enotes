//
//  HomeView.swift
//  ENotes
//
//  Created by iredefbmac_27 on 15/07/25.
//
import SwiftUI
import SwiftData
import Charts
import Foundation

struct HomeView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    @State private var navigationPath = NavigationPath()
    @State private var showPopup = false
    @State private var name = ""
    @State private var description = ""
    @State private var showSettings = false
    
    @Environment(\.modelContext) private var context
    @Query(sort: \Tasks.date) var tasks: [Tasks]
    
    // Tarefas concluídas e pendentes
    var completedTasks: [Tasks] { tasks.filter { $0.isDone } }
    var pendingTasks: [Tasks] { tasks.filter { !$0.isDone } }
    
    // Estrutura para o gráfico
    struct TaskSummary {
        let month: String
        let status: String
        let count: Int
    }
    
    // Dados para o gráfico
    var dataForChart: [TaskSummary] {
        let calendar = Calendar.current
        
        let completedGrouped = Dictionary(
            grouping: completedTasks,
            by: { calendar.component(.month, from: $0.date) }
        )
        
        let pendingGrouped = Dictionary(
            grouping: pendingTasks,
            by: { calendar.component(.month, from: $0.date) }
        )
        
        var result: [TaskSummary] = []
        
        for (monthNumber, tasks) in completedGrouped {
            let monthName = DateFormatter().monthSymbols[monthNumber - 1]
            result.append(TaskSummary(month: monthName, status: "Concluído", count: tasks.count))
        }
        
        for (monthNumber, tasks) in pendingGrouped {
            let monthName = DateFormatter().monthSymbols[monthNumber - 1]
            result.append(TaskSummary(month: monthName, status: "Pendente", count: tasks.count))
        }
        
        return result
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color.lightBlue
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Barra superior
                    TopBar(firstButton: "", secondButton: "gearshape.fill", showSettings: $showSettings)
                    
                    // Conteúdo principal
                    VStack {
                        
                        Text("Relatório")
                            .bold()
                            .font(.title)
                        Chart(dataForChart, id: \.month) { item in
                            SectorMark(
                                angle: .value("Tarefas", item.count),
                                innerRadius: .ratio(0.6),
                                angularInset: 3
                            )
                            .foregroundStyle(by: .value("Status", item.status))
                        }
                        
                    }
                    .padding()
                    .frame(width: 300, height: 550)
                    .cornerRadius(10)
                    .background()
                    .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 10)
                    // Barra inferior
                    BottomBar(
                        firstButton: "book.fill",
                        secondButton: "house.fill",
                        thirdButton: "checklist",
                        firstAction: { navigationPath.append(Routes.notes) },
                        secondAction: {},
                        thirdAction: { navigationPath.append(Routes.tasks) }
                    )
                }
                
                // Configurações
                if showSettings {
                    SettingsView(showSettings: $showSettings)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: showSettings)
                }
                
                // Pop-up tipo alerta
                if showPopup {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture { showPopup = false }
                    
                    VStack(spacing: 20) {
                        TextField("Nome da Atividade", text: $name)
                        TextEditor(text: $description)
                            .frame(width: 300, alignment: .center)
                        HStack {
                            Image(systemName: "calendar")
                            Image(systemName: "flag")
                        }
                        Button("Criar") { showPopup = false }
                    }
                    .padding()
                    .frame(width: 300)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .transition(.scale)
                }
            }
            .animation(.easeInOut, value: showPopup)
            .navigationDestination(for: Routes.self) { route in
                switch route {
                case .notes: NotesView(navigationPath: $navigationPath)
                case .tasks: TasksView()
                case .notesList: NotesListView()
                }
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
