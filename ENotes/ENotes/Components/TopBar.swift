//
//  TopBar.swift
//  ENotes
//
//  Created by iredefbmac_27 on 14/08/25.
import SwiftUI


struct TopBar : View{
    @Environment(\.dismiss) var dismiss
    let firstButton : String
    let secondButton : String
    @Binding var showSettings : Bool
    
    
    
    var body : some View{
        HStack(spacing:200){
            Button{
                dismiss()
            }
            label: {
                Image(systemName:firstButton  )
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.darkBlue)
            }
            Button{
                showSettings = true
            }
            label:{
                Image(systemName: secondButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width:40,height:40)
                    .foregroundColor(.darkBlue)
            }
        
                
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 10)    }
}

