//
//  SettingsView.swift
//  ENotes
//
//  Created by iredefbmac_27 on 25/08/25.
//

import SwiftUI

struct SettingsView : View{
    @Binding var showSettings : Bool
    @State private var isOn = false
    @State private var clearMode = false
    @State private var resume = false
    var body : some View {
        VStack{
            
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(height: 250)
                .shadow(radius: 10)
                .overlay(
                    ZStack(){
                        Color.lightBlue
                        VStack{
                            HStack{
                                Spacer()
                                Text("Configurações")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                                
                                Button(action:{
                                    showSettings.toggle()
                                } ){
                                    Image(systemName:"xmark")
                                    
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height:20)
                                    .bold()
                                    .foregroundStyle(Color.darkBlue)
                                }
                                .padding(.leading,-40)
                                
                            }
                            .padding(.bottom,30)
                            HStack{
                                
                                Toggle("", isOn: $isOn)
                                    .labelsHidden()
                                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                                
                                Text("Receber Notificações")
                                
                                Spacer()
                            }
                            .padding(.leading,30)
                            
                            HStack{
                                Toggle("", isOn: $clearMode)
                                    .labelsHidden()
                                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                                Text("Modo Claro")
                                Spacer()
                            }
                            .padding(.leading,30)
                            HStack{
                                Toggle("", isOn: $resume)
                                    .labelsHidden()
                                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                                Text("Gerar Relatorios")
                                Spacer()
                            }
                            .padding(.leading,30)
                        }
                        
                        
                    }
                    
                    )
                }
                .transition(.move(edge: .bottom))
                
                .ignoresSafeArea()
                .shadow(radius: 10)
    }
}

