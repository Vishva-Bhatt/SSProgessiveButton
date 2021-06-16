//
//  CustomButton.swift
//  SSProgessiveButton
//
//  Created by Vishva Bhatt on 16/06/21.
//

import SwiftUI

let circleSize : CGFloat = 30
let imageSize : CGFloat = 20

struct CustomButton: View {
    
    @Binding var animation: Bool
    @Binding var loadingProgress: Float
    
    var animationBehaviour: Animation {
        Animation.linear.speed(0.5).repeatForever(autoreverses: false)
    }
    
    struct ImageOverlay: View {
        var body: some View {
            ZStack {
                Image(systemName: "arrow.down")
                    .font(Font.title3.weight(.medium))
                    .accentColor(.red)
                    .frame(width: imageSize, height: imageSize, alignment: .center)
            }
        }
    }
    
    var downloadImage: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.black,lineWidth: 3)
                .frame(width: circleSize, height: circleSize)
                .animation(nil)
            Image(systemName: "arrow.down")
                .font(Font.title3.weight(.medium))
                .accentColor(.black)
                .frame(width: imageSize, height: imageSize, alignment: .center)
                .offset(x: 0, y: animation ? ((circleSize - imageSize)/2) : -((circleSize - imageSize)/2))
                .animation(animation ? animationBehaviour : .none)
                .opacity(animation ? 1.0 : 0.0)
            Image(systemName: "arrow.down")
                .font(Font.title3.weight(.medium))
                .accentColor(.black)
                .frame(width: imageSize, height: imageSize, alignment: .center)
                .opacity(animation ? 0.0 : 1.0)
        }
    }
    
    var body: some View {
        VStack(alignment:.center) {
            HStack(alignment: .center, spacing: 0, content: {
                downloadImage
                ZStack {
                    Text("Downloading")
                        .foregroundColor(.black)
                        .fontWeight(.medium)
                        .font(.title2)
                        .animation(nil)
                        .opacity(animation ? 1.0 : 0.0)
                    Text("Download")
                        .foregroundColor(.black)
                        .fontWeight(.medium)
                        .font(.title2)
                        .animation(nil)
                        .opacity(animation ? 0.0 : 1.0)
                }
            })
        }
    }
}


struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(animation: .constant(false), loadingProgress: .constant(0))
    }
}

struct ProgressBar: View {
    
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.5)
                    .foregroundColor(Color.clear)
                Rectangle().frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: 1.5)
                    .foregroundColor(Color.white)
                    .animation(.linear)
            }.cornerRadius(5.0)
        }
    }
}
