//
//  RegisterView.swift
//  ENotes
//
//  Created by iredefbmac_27 on 15/07/25.
//

import SwiftUI

struct RegisterView : View{
    //Variaveis de estado para fazer a validação do usuario
    @State private var email : String = ""
    @State private var password: String = ""
    
    //Corpo da tela de login
    
    var body : some View{
      
        NavigationView{
            ZStack{
                Color.lightBlue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.6)
                    .foregroundColor(Color.white)
                VStack(){
                    Text("Register")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .padding()
                        .frame(width: 300,height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    SecureField("Senha", text: $password)
                        .autocapitalization(.none)
                        .padding()
                        .frame(width: 300,height: 50 )
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    SecureField("Confirme a senha", text: $password)
                        .autocapitalization(.none)
                        .padding()
                        .frame(width: 300,height: 50 )
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        Button("Cadastrar"){
                        print("Entrar com \(email)")
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: 300 , height: 50 )
                    .background(Color.lightBlue)
                    .cornerRadius(10)
                    
                }
            }
        }
    }
}

struct RegisterView_previews:
    PreviewProvider{
    static var previews: some View{
        RegisterView()
    }
}
