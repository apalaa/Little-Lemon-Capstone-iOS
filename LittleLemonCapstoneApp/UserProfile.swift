//
//  UserProfile.swift
//  LittleLemonCapstoneApp
//
//  Created by Angel Palaguachi on 2/2/25.
//

import SwiftUI



struct UserProfile: View {

    @Binding var path: NavigationPath
    
    @State var firstName: String = UserDefaults.standard.string(forKey: keyFirstName) ?? "firstNamePlaceholder"
    @State var lastName: String = UserDefaults.standard.string(forKey: keyLastName) ?? "lastNamePlaceholder"
    @State var email: String = UserDefaults.standard.string(forKey: keyEmail) ?? "emailPlaceholder"
    @State var phoneNum: String = UserDefaults.standard.string(forKey: keyPhoneNum) ?? ""
    
    @State var missingField = ""
    @State var showFieldAlert = false
    @State var showConfirmation = false
    @State var showSaved = false
    
    @State private var isChecked1 = false
    @State private var isChecked2 = false
    @State private var isChecked3 = false
    @State private var isChecked4 = false
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 0) {
                
                HeaderLittleLemon()
                
                VStack(alignment: .leading) {
                    Text("Personal Information")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                    Text("First Name")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    TextField("First Name", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("Last Name")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("Email")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("Phone Number")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    TextField("(xxx) xxx-xxxx", text: $phoneNum)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }
                .padding()
                
                HStack {
                    Text("Email Notifications")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                VStack {
                    Toggle("Order Status", isOn: $isChecked1)
                    Toggle("Password Changes", isOn: $isChecked2)
                    Toggle("Special Offers", isOn: $isChecked3)
                    Toggle("Newsletter", isOn: $isChecked4)
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                VStack {
                    HStack {
                        Button(action: {discardChanges()}) {
                            Text("Discard changes")
                                .padding(.vertical)
                                .bold()
                                .frame(maxWidth: .infinity) // Makes the button expand horizontally
                                .foregroundColor(.black) // Black text for contrast
                                .cornerRadius(10) // Rounded edges
                                .overlay(RoundedRectangle(cornerRadius: 8).stroke(greenCustom, lineWidth: 1))
                        }
                        .alert( "Changes discarded", isPresented: $showConfirmation, actions: { Button("OK", role: .cancel){}})
                        Spacer()
                        Button(action: {saveChanges()}) {
                            Text("Save changes")
                                .padding(.vertical)
                                .bold()
                                .frame(maxWidth: .infinity) // Makes the button expand horizontally
                                .foregroundColor(.white) // Black text for contrast
                                .background(greenCustom)
                                .cornerRadius(10) // Rounded edges
                        }
                        .alert(
                            "Please provide a valid \(missingField).",
                            isPresented: $showFieldAlert,
                            actions: { Button("OK", role: .cancel) { missingField = "" }}
                        )
                        .alert(
                            "Changes saved",
                            isPresented: $showSaved,
                            actions: { Button("OK", role: .cancel) { }}
                        )
                    }
                    .padding(.horizontal, 15)
                    
                    Button(action: {
                        UserDefaults.standard.set(false, forKey: keyIsLoggedIn)
                        path.removeLast(path.count)
                    }) {
                        Text("Log out")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity) // Makes the button expand horizontally
                            .background(yellowCustom)
                            .foregroundColor(.black) // Black text for contrast
                            .cornerRadius(10) // Rounded edges
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black.opacity(0.4), lineWidth: 1)
                            )
                    }
                    .padding()
                }
                .padding(.top)
                
                Spacer()
                
            }
        }

    }
    
    private func saveChanges() {
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
            UserDefaults.standard.set(phoneNum, forKey: keyPhoneNum)
            showSaved.toggle()
        }
    }
    
    private func discardChanges() {
        firstName = UserDefaults.standard.string(forKey: keyFirstName) ?? "Invalid name"
        lastName = UserDefaults.standard.string(forKey: keyLastName) ?? "Invalid name"
        email = UserDefaults.standard.string(forKey: keyEmail) ?? "Invalid email"
        phoneNum = UserDefaults.standard.string(forKey: keyPhoneNum) ?? ""
        showConfirmation.toggle()
    }
}


#Preview {
    @Previewable @State var path = NavigationPath()
    UserProfile(path: $path)
}

