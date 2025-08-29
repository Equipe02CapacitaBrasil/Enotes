//
//  Notes.swift
//  ENotes
//
//  Created by iredefbmac_27 on 20/08/25.
//

import SwiftUI
struct Notes : Identifiable, Codable {
    let id : UUID
    var text : String
    var mood : String
    var date : Date
    
    init(id: UUID = UUID(), text: String = "",mood: String = "happy" ,date: Date = Date.now) {
        self.id = id
        self.text = text
        self.mood = mood
        self.date = date
        
    }
}
