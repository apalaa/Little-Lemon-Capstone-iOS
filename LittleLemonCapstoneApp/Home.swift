//
//  Home.swift
//  LittleLemonCapstoneApp
//
//  Created by Angel Palaguachi on 2/2/25.
//

import SwiftUI

// Custom Colors
let yellowCustom = Color(red: 244/255, green: 206/255, blue: 20/255)
let greenCustom = Color(red: 73/255, green: 94/255, blue: 87/255)
let greyCustom = Color(red: 230/255, green: 230/255, blue: 230/255)

struct Home: View {
    
    @Binding var path: NavigationPath
    
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        TabView {
            
            Menu()
                .tabItem {Label("Menu", systemImage: "list.dash")}
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            UserProfile(path: $path)
                .tabItem {Label("Profile", systemImage: "square.and.pencil")}
            
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    @Previewable @State var path = NavigationPath()
    Home(path: $path)
}

