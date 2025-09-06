//
//  TaskViewModel.swift
//  ENotes
//
//  Created by iredefbmac_27 on 18/08/25.
//

import SwiftUI
import SwiftData
import Combine


class TaskViewModel : ObservableObject{
    

    
    @Published var tasks: [Tasks] = []
    
    func addTask(title: String, date: Date, context: ModelContext)
    {
        let task = Tasks(title: title, date: date)
        context.insert(task)
        try? context.save()
        fetchTasks(context: context)
    }
    
    
    func fetchTasks (context : ModelContext)
    {
        
        let descriptor  = FetchDescriptor<Tasks>()
        
        do {
            try self.tasks = context.fetch(descriptor)
        }catch{
            fatalError("Não foi achado nenhuma tarefa salva.")
        }
        
        
    }
    

    //Marca a atividade como feita
    func toggleTask(_ task: Tasks, context: ModelContext)
    {
        task.isDone.toggle()
        try? context.save()
        fetchTasks(context: context)
    }
    
    
    //Delete de tasks
    func deleteTask(at offsets: IndexSet, context: ModelContext)
    {
        offsets.map { tasks[$0] }.forEach { context.delete($0) }
        try? context.save()
        fetchTasks(context: context)

    }
    
   
    
  
    
    
}
