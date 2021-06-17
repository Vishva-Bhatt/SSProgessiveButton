//
//  CustomButton.swift
//  SSProgessiveButton
//
//  Created by Vishva Bhatt on 16/06/21.
//

import SwiftUI

let circleSize : CGFloat = 40
let imageSize : CGFloat = 40

struct CustomButton: View {
    
    @Binding var shouldAnimate: Bool
    @Binding var loadingProgress: Float
    
    var animationBehaviour: Animation {
        Animation.linear.speed(0.5).repeatForever(autoreverses: false)
    }
    
    var downloadImageView: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.black,lineWidth: 3)
                .frame(width: circleSize, height: circleSize)
                .animation(nil)
            DownloadImage()
                .offset(x: 0, y: shouldAnimate ? imageSize : -imageSize)
                .animation(shouldAnimate ? animationBehaviour : .none)
                .opacity(shouldAnimate ? 1.0 : 0.0)
                .clipped()
            DownloadImage()
                .opacity(shouldAnimate ? 0.0 : 1.0)
        }
    }
    
    var body: some View {
        VStack(alignment:.center) {
            HStack(alignment: .center, spacing: 10, content: {
                downloadImageView
                ZStack {
                    ButtonLabelView(title: "Downloading")
                        .opacity(shouldAnimate ? 1.0 : 0.0)
                    ButtonLabelView(title: "Download")
                        .opacity(shouldAnimate ? 0.0 : 1.0)
                }
            })
        }
    }
}


struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(shouldAnimate: .constant(false), loadingProgress: .constant(0))
    }
}

struct ButtonLabelView: View {
    
    var title : String
    
    var body: some View {
        Text(title)
            .foregroundColor(.black)
            .fontWeight(.medium)
            .font(.title2)
            .animation(nil)
    }
    
}

struct DownloadImage: View {
    
    var body: some View {
        Image(systemName: "arrow.down")
            .font(Font.title3.weight(.medium))
            .accentColor(.black)
            .frame(width: imageSize, height: imageSize, alignment: .center)
    }
    
}

struct ProgressBar: View {
    
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: min(CGFloat(self.value) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color.white)
                    .animation(.linear)
            }
        }
    }
}

struct ButtonBackground : View {
    
    @Binding var animationOn: Bool

    var body: some View {
        GeometryReader { geometry in
            Rectangle().fill(Color.green)
                .frame(width: geometry.size.width , height: animationOn ? geometry.size.height : 0)
                .offset(x: 0, y: animationOn ? 0 : -60)
                .animation(.linear)
        }
        
        
    }
}
