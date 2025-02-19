//
//  Home.swift
//  LittleLemonCapstoneApp
//
//  Created by Angel Palaguachi on 2/2/25.
//

import SwiftUI

struct Home: View {
    
    @Binding var path: NavigationPath
    
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }.environment(\.managedObjectContext, persistenceController.container.viewContext)
            
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

