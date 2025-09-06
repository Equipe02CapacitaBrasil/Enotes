//
//  ContentView.swift
//  ENotes
//
//  Created by iredefbmac_27 on 14/07/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        
        NavigationStack{
            
            if viewModel.isAuthenticated {
                HomeView(viewModel : viewModel)
            }else{
                LoginView(viewModel : viewModel)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
