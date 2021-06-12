//
//  ContentView.swift
//  SSProgessiveButton
//
//  Created by Vishva Bhatt on 10/06/21.
//

import SwiftUI

struct SSProgressiveButton: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            // Ask sir about this color properties
            HStack {
                Button(action: {
                    // Animated image
                }, label: {
                    CustomButton()
                })
                .frame(width: UIScreen.main.bounds.width - 40, height: 50.0)
                .background(Color.white)
                .cornerRadius(10)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SSProgressiveButton()
    }
}

struct CustomButton: View {
    
    var body: some View {
        HStack(alignment: .center, spacing: 15, content: {
            ZStack {
                Circle()
                    .strokeBorder(Color.black,lineWidth: 3)
                    .frame(width: 33, height: 33)
                Image(systemName: "arrow.down")
                    .font(Font.title3.weight(.medium))
                    .accentColor(.black).animation(.easeIn(duration: 5.0))
            }
            Text("Download")
                .foregroundColor(.black)
                .fontWeight(.medium)
                .font(.title2)
        })
    }
}
