//
//  TasksView.swift
//  ENotes
//
//  Created by iredefbmac_27 on 16/07/25.
//
import SwiftUI
import SwiftData

struct TasksView: View {
    
    //Variaveis de estado
   
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @State var viewModel : TaskViewModel
    @State private var newTaskTitle: String = ""
    @State private var newTaskDate: Date = Date()
    @State private var showingAddTask = false
    @State private var showSettings = false
    
    init(){
        @Environment(\.modelContext) var context
        self.viewModel = TaskViewModel(context: context)
        
        
    }
    
    var body : some View {
        
        
        
        ZStack{
            Color.lightBlue
                .ignoresSafeArea()
            
            
            VStack{
                
                TopBar(firstButton: "arrow.left", secondButton: "gearshape.fill", showSettings: $showSettings)
                7
                
                
                //Copulando a lista de atividades
                
                
                List {
                    ForEach(viewModel.tasks.sorted(by: {$0.date < $1.date})) {task in
                        HStack {
                            
                            Image(systemName: task.isDone ? "circle.fill" : "square")
                                .foregroundColor(task.isDone ? .green :.gray)
                                .onTapGesture {
                                    viewModel.toggleTask(task)
                                }
                            
                            Text(task.title)
                                .strikethrough(task.isDone, color: .black)
                                .foregroundColor(task.isDone ? .gray :.primary)
                            Spacer()
                            Text(task.date.formatted(date: .abbreviated, time: .omitted))
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            
                        }
                    }
                    .onDelete(perform: self.deleteTask)
                }
                
                .listStyle(.insetGrouped)
                
                .sheet(isPresented: $showingAddTask) {
                    NavigationStack {
                        Form {
                            Section {
                                TextField("Tarefa...", text: $newTaskTitle)
                                DatePicker("Prazo...", selection: $newTaskDate, displayedComponents: .date)
                                
                            }
                        }
                        
                        
                        
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Cancelar") {
                                    showingAddTask = false
                                    newTaskTitle = ""
                                    newTaskDate = Date()
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Group {
                                    Button("Adicionar") {
                                        guard !newTaskTitle.isEmpty else { return }
                                        viewModel.addTask(title: newTaskTitle, date: newTaskDate, context: context)
                                        newTaskTitle = ""
                                        newTaskDate = Date()
                                        showingAddTask = false
                                    }
                                    .disabled(newTaskTitle.isEmpty)
                                }
                            }

                        }
                        
                        
                        
                    }
                    
                }
            
                .navigationBarBackButtonHidden(true)
                .padding()
                .frame(width:300,height:550)
                .cornerRadius(10)
                .background()
                .shadow(color:.gray.opacity(0.4),radius: 5,x:0,y:10)
                
                
             BottomBar(
                    firstButton: "trash.fill",
                    secondButton: "line.3.horizontal.decrease.circle.fill",
                    thirdButton: "plus.circle.fill",
                    firstAction: {},
                    secondAction: {},
                    thirdAction: {
                        showingAddTask = true
                    })
              
            }
            if showSettings {
                    SettingsView(showSettings: $showSettings)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: showSettings)
                    }
            
            
        }
    }
    
    func deleteTask(at offsets: IndexSet){
        viewModel.deleteTask(at: offsets, context: context)
    }
        
}



struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
