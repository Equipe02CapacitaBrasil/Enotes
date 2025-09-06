//
//  Tasks.swift
//  ENotes
//
//  Created by iredefbmac_27 on 18/08/25.
//

import Foundation
import SwiftData


@Model
class Tasks: Identifiable {
    var title: String
    var isDone: Bool
    var date: Date
    
    
    init(title: String, isDone: Bool = false, date: Date ) {
        
        
        self.title = title
        self.isDone = isDone
        self.date = date
        
    }
}
