//
//  HeaderLittleLemon.swift
//  LittleLemonCapstoneApp
//
//  Created by Angel Palaguachi on 2/28/25.
//

import SwiftUI


struct HeaderLittleLemon: View {
    
    let fontSize = CGFloat(18)
    
    @AppStorage(keyIsLoggedIn) private var isLoggedIn: Bool = false
    
    
    var body: some View {
        ZStack {
            HStack() {
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 45)
                Text("Little Lemon")
                    .font(.custom("Times New Roman", size: fontSize))
                    .bold()
                    .foregroundStyle(greenCustom)
                Spacer()
                
            }
            
            if isLoggedIn {
                HStack {
                    Spacer()
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .trailing)
                }
                .padding(.horizontal, 10)
            }
            
        }
    }
}

#Preview {
    HeaderLittleLemon()
}
