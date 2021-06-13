//
//  SplashStruct.swift
//  SSProgessiveButton
//
//  Created by Vishva Bhatt on 13/06/21.
//

import SwiftUI

struct SplashShape: Shape {
    
    public enum SplashAnimaion {
        case leftToRight
        case rightToLeft
    }
    
    var progress : CGFloat
    var animationType : SplashAnimaion
    
    var animatableData: CGFloat {
        get { return progress }
        set { self.progress = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        switch animationType {
        case .leftToRight:
            return self.leftToRight(rect: rect)
        case .rightToLeft:
            return self.rightToLeft(rect: rect)
        }
    }
    
    func leftToRight(rect:CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint.zero) // Top Left
        path.addLine(to: CGPoint(x: rect.width * progress, y: 0)) // Top Right
        path.addLine(to: CGPoint(x: rect.width * progress, y: rect.height)) // Bottom Right
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
    
    func rightToLeft(rect:CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width - (rect.width * progress), y: 0))
        path.addLine(to: CGPoint(x: rect.width - (rect.width * progress), y: rect.height))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.closeSubpath()
        return path
    }
}

struct SplashView: View {
    
    var animationType : SplashShape.SplashAnimaion
    @State private var prevColor : Color // Stores background color
    @ObservedObject var colorStore : ColorStore // sends new color  updates
    
    @State var layers: [(Color, CGFloat)] = [] // new color & progress
  
    init(animationType: SplashShape.SplashAnimaion, color:Color) {
        self.animationType = animationType
        self._prevColor = State<Color>(initialValue: color)
        self.colorStore = ColorStore(color:color)
    }
    
    var body: some View {
        Rectangle()
            .foregroundColor(self.prevColor)
            .overlay(
                ZStack{
                    ForEach(layers.indices, id: \.self) { x in
                        SplashShape(progress: self.layers[x].1, animationType: self.animationType)
                            .foregroundColor(self.layers[x].0)
                    }
                }
                ,alignment: .leading)
            .onReceive(self.colorStore.$color) { color in
                // Animate the color update
                self.layers.append((color, 0))
                withAnimation(Animation.easeOut(duration: 1.0)) {
                    self.layers[self.layers.count-1].1 = 1.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.prevColor = self.layers[0].0 // Finalizes background color of SplashView
                        self.layers.remove(at: 0) // removes itself from layers array
                    }
                }
            }
    }
}

class ColorStore: ObservableObject {
    
    @Published var color: Color
    
    init(color: Color) {
        self.color = color
    }
}

struct ContentView: View {
    var colors: [Color] = [.blue, .red, .green, .orange]
    @State var index: Int = 0
    
    @State var progress: CGFloat = 0
    var body: some View {
        VStack {
            
            SplashView(animationType: .leftToRight, color: self.colors[self.index])
                .frame(width: 200, height: 100, alignment: .center)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
            
            Button(action: {
                self.index = (self.index + 1) % self.colors.count
            }) {
                Text("Change Color")
            }
            .padding(.top, 20)
        }
        
    }
}

struct SplashStruct_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
