//
//  SettingsView.swift
//  ENotes
//
//  Created by iredefbmac_27 on 25/08/25.
//

import SwiftUI
import UserNotifications

struct SettingsView : View{
    @Binding var showSettings : Bool
    @State private var isOn = false
    @State private var isOnNotification = false
    @AppStorage("AppStyle") private var appStyle: String = "System"
    @AppStorage("AppNotification") private var appNotification =  "System"
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
                                
                                Toggle("",isOn: Binding(
                                    get: { isOnNotification },
                                        set: { newValue in
                                            isOnNotification = newValue

                                            if newValue {
                                                
                                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                                                    if granted {
                                                        print("Permissão concedida!")
                                                        
                                                    } else {
                                                        print("Permissão negada")
                                                    }
                                                }
                                            } else {
                                                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                            }
                                        }
                                    ))
                                .labelsHidden()
                                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                                
                                
                                Text("Notificações")
                                Spacer()
                            }
                            .padding(.leading,30)
                            
                            HStack{
                                Toggle("", isOn : Binding (
                                    get :{ appStyle == "light" } ,
                                                            
                                    set :{ appStyle = $0 ? "light" : "dark" }
                                    )
                                )
                                .labelsHidden()
                                .toggleStyle(SwitchToggleStyle(tint:.blue))
                                Text("Modo Claro")
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

