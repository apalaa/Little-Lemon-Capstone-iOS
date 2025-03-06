//
//  Onboarding.swift
//  LittleLemonCapstoneApp
//
//  Created by Angel Palaguachi on 1/10/25.
//

import SwiftUI
import CoreData

let keyFirstName = "first name key"
let keyLastName = "last name key"
let keyEmail = "email key"
let keyIsLoggedIn = "isLoggedIn key"
let keyPhoneNum = "phone number key"



struct Onboarding: View {
    
    
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    
    @State var isLoggedIn = false
    
    @State var showFieldAlert = false
    @State var missingField = ""

    @State private var path = NavigationPath()
    
    var body: some View {
        
        NavigationStack(path: $path) {
            VStack {
                
                HeaderLittleLemon()
                HeroLittleLemon()

                VStack(alignment: .leading) {
                    Text("First Name *")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    TextField("First Name", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("Last Name *")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("Email *")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()

                Button("Register") { handleRegistration() }
                    .alert(
                        "Please provide a valid \(missingField).",
                        isPresented: $showFieldAlert,
                        actions: { Button("OK", role: .cancel) { missingField = "" }}
                    )
                
                Spacer()
                
            }
            .onAppear {
                if (UserDefaults.standard.bool(forKey: keyIsLoggedIn)) {
                    path.append("home")
                }
            }
            .navigationDestination(for: String.self ) { destination in
                if destination == "home" {
                    Home(path: $path)
                }
            }
        }
    }
    
    private func handleRegistration() {
        let triggerAlert: (String) -> Void = { field in
            missingField = field
            showFieldAlert.toggle()
        }
        if(firstName.isEmpty) {
            triggerAlert("first name")
        } else if(lastName.isEmpty) {
            triggerAlert("last name")
        } else if(email.isEmpty) {
            triggerAlert("email address")
        } else {
            UserDefaults.standard.set(firstName, forKey: keyFirstName)
            UserDefaults.standard.set(lastName, forKey: keyLastName)
            UserDefaults.standard.set(email, forKey: keyEmail)
            UserDefaults.standard.set(true, forKey: keyIsLoggedIn)
            path.append("home")
        }
    }
    
}

#Preview {
    Onboarding()
}
