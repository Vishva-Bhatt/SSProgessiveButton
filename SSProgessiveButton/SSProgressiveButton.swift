//
//  ContentView.swift
//  SSProgessiveButton
//
//  Created by Vishva Bhatt on 10/06/21.
//

import SwiftUI

struct SSProgressiveButton: View {
    
    @State private var animationOn = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            HStack {
                Button(action: {
                    self.changeBackgroundColor()
                }, label: {
                    CustomButton()
                })
                .frame(width: UIScreen.main.bounds.width - 40, height: 50.0)
                .background(animationOn ? Color.green : Color.white)
                .cornerRadius(10)
                .animation((Animation.linear).delay(0.5))
            }
        }
        
    }
    
    func changeBackgroundColor() {
        withAnimation(.easeIn) {
            self.animationOn.toggle()
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
                    .accentColor(.black)
            }
            Text("Download")
                .foregroundColor(.black)
                .fontWeight(.medium)
                .font(.title2)
        })
    }
}
