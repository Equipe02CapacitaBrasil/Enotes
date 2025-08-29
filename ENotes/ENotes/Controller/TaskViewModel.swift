//
//  TaskViewModel.swift
//  ENotes
//
//  Created by iredefbmac_27 on 18/08/25.
//

import SwiftUI
import SwiftData


@Observable
class TaskViewModel {
    
    
    
    
    
    var tasks: [Tasks] = []
    
    func fetchTasks (context : ModelContext) {
        
        let descriptor  = FetchDescriptor<Tasks>()
        
        do {
            try self.tasks = context.fetch(descriptor)
        }catch{
            fatalError("Não foi achado nenhuma tarefa salva.")
        }
        
        
    }
    
    //Adição de  Tasks
    func addTask(title:String, date: Date, context : ModelContext) {
        let newTask = Tasks(title: title, date: date)
        tasks.append(newTask)
        context.insert(newTask)
        do {
            try context.save()
        }catch{
            fatalError("Erro ao salvar a atividade.")
        }
    }
    
    //Marca a atividade como feita
    func toggleTask(_ task: Tasks) {
        if let index = tasks.firstIndex(where: {$0.id == task.id })
        {
            tasks[index].isDone.toggle()
        }
    }
    
    
    //Delete de tasks
    func deleteTask(at offsets: IndexSet, context: ModelContext) {
        
        context.delete(tasks[offsets.count])
        do {
            try context.save()
        }catch{
            fatalError("Não foi possivel deletar a atividade.")
        }
        tasks.remove(atOffsets: offsets)
    }
    
    func filterTasks(){
        
    }
    
    init(context: ModelContext) {
        fetchTasks(context: context)
    }
    
    
}
