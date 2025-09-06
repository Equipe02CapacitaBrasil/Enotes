//
//  BottomBar.swift
//  ENotes
//
//  Created by iredefbmac_27 on 14/08/25.
//

import SwiftUI

struct BottomBar: View {
    let firstButton: String
    let secondButton: String
    let thirdButton: String
    @Environment(\.colorScheme) var colorScheme
    
    let firstAction: () -> Void
    let secondAction: () -> Void
    let thirdAction: () -> Void
    
    var body: some View {
        HStack {
            
            Button(action:firstAction) {
                Image(systemName: firstButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.darkBlue)
            }
            
            Spacer()
            
            Button(action: secondAction) {
                Image(systemName: secondButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 30)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.darkBlue)
                
            }
            
            Spacer()
            
            Button(action: thirdAction ) {
                Image(systemName: thirdButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.darkBlue)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .frame(width: 300)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 10)
    }
        
}


