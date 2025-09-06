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
    
    @Environment(\.colorScheme) var colorScheme
    
    
    var body : some View{
        
        HStack(){
            Button{
                dismiss()
            }
            label: {
                if firstButton.isEmpty {
                    Text("Enotes")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                }else{
                    Image(systemName:firstButton  )
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.darkBlue)
                }
            }
            
            Spacer()
            
            Button{
                showSettings = true
            }
            label:{
                Image(systemName: secondButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width:40,height:40)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.darkBlue)
            }
        
                
            
        }
        .frame(maxWidth: 270)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 10)    }
}

