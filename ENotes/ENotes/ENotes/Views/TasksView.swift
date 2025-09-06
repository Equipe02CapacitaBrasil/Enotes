//
//  TasksView.swift
//  ENotes
//
//  Created by iredefbmac_27 on 16/07/25.
//
import SwiftUI
import SwiftData

struct TasksView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var newTaskTitle: String = ""
    @State private var newTaskDate: Date = Date()
    @State private var showingAddTask = false
    @State private var showSettings = false
    @StateObject var viewModel: TaskViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: TaskViewModel())
    }
    
    var body: some View {
        
            ZStack {
                Color.lightBlue.ignoresSafeArea()
                
                VStack {
                    TopBar(firstButton: "arrow.left",
                           secondButton: "gearshape.fill",
                           showSettings: $showSettings)
                    
                    List {
                        ForEach(viewModel.tasks) { task in
                            NavigationLink(value: task) {
                                HStack {
                                    Image(systemName: task.isDone ? "circle.fill" : "square")
                                        .foregroundColor(task.isDone ? .green :.gray)
                                        .onTapGesture {
                                            viewModel.toggleTask(task, context: context)
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
                        }
                        .onDelete { offsets in
                            viewModel.deleteTask(at: offsets, context: context)
                        }
                    }
                    .padding()
                    .frame(width:300,height:550)
                    .cornerRadius(10)
                    .background()
                    .shadow(color:.gray.opacity(0.4),radius: 5,x:0,y:10)
                    .listStyle(.insetGrouped)
                    .onAppear {
                        viewModel.fetchTasks(context: context)
                    }
                    
                    BottomBar(
                        firstButton: "",
                        secondButton: "plus.circle.fill",
                        thirdButton: "",
                        firstAction: {},
                        secondAction: {
                            showingAddTask = true
                        },
                        thirdAction: {}
                    )
                }
                
                if showSettings {
                    SettingsView(showSettings: $showSettings)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: showSettings)
                }
            }
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
                            Button("Adicionar") {
                                guard !newTaskTitle.isEmpty else { return }
                                viewModel.addTask(title: newTaskTitle,
                                                  date: newTaskDate,
                                                  context: context)
                                newTaskTitle = ""
                                newTaskDate = Date()
                                showingAddTask = false
                            }
                            .disabled(newTaskTitle.isEmpty)
                        }
                    }
                }
            }
            .navigationDestination(for: Tasks.self) { task in
                ActivityView(task: task)
            }
            .navigationBarBackButtonHidden(true)
        }
    }



struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
