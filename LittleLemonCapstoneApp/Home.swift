//
//  Home.swift
//  LittleLemonCapstoneApp
//
//  Created by Angel Palaguachi on 2/2/25.
//

import SwiftUI

struct Home: View {
    
    @Binding var path: NavigationPath
    
    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            UserProfile(path: $path)
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    @Previewable @State var path = NavigationPath()
    Home(path: $path)
}

