//
//  Notes.swift
//  ENotes
//
//  Created by iredefbmac_27 on 20/08/25.
//

import SwiftUI
import SwiftData

@Model
class Notes : Identifiable{
   
    var text : String
    var mood : String
    var date : Date
    
    init(text: String = "",mood: String = "happy" , date: Date = Date.now) {
        
        self.text = text
        self.mood = mood
        self.date = date
        
    }
}
