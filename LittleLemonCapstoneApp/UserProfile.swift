//
//  UserProfile.swift
//  LittleLemonCapstoneApp
//
//  Created by Angel Palaguachi on 2/2/25.
//

import SwiftUI



struct UserProfile: View {

    @Binding var path: NavigationPath
    
    let firstName: String = UserDefaults.standard.string(forKey: keyFirstName) ?? "firstNamePlaceholder"
    let lastName: String = UserDefaults.standard.string(forKey: keyLastName) ?? "lastNamePlaceholder"
    let email: String = UserDefaults.standard.string(forKey: keyEmail) ?? "emailPlaceholder"
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
            Text(firstName)
            Text(lastName)
            Text(email)
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: keyIsLoggedIn)
                path.removeLast(path.count)
            }
            Spacer()
        }
    }
}


#Preview {
    @Previewable @State var path = NavigationPath()
    UserProfile(path: $path)
}

