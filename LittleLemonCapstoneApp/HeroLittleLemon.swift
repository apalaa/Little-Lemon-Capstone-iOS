//
//  HeroLittleLemon.swift
//  LittleLemonCapstoneApp
//
//  Created by Angel Palaguachi on 2/28/25.
//

import SwiftUI



struct HeroLittleLemon: View {
    
    var heroText = "We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist."
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                
                Text("Little Lemon")
                    .font(.custom("Times New Roman", size: 30))
                    .bold()
                    .foregroundStyle(yellowCustom)
                    .padding(.bottom, 5)

                HStack {
                    
                    VStack(alignment: .leading) {
                        
                        Text("Chicago")
                            .foregroundStyle(Color.white)
                            .font(.title2)
                            .padding(.bottom, 10)

                        Text(heroText)
                            .foregroundStyle(Color.white)
                            .font(.subheadline)
                    }
                    .padding(.trailing, 20)
                    
                    Image("pizza-marg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, alignment: .bottom)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                }
                
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            
        }
        .frame(maxWidth: .infinity)
        .background(greenCustom)
    }
}

#Preview {
    HeroLittleLemon()
}
