//
//  ContentView.swift
//  SSProgessiveButton
//
//  Created by Vishva Bhatt on 10/06/21.
//

import SwiftUI

struct SSProgressiveButton: View {
    
    @State private var animationOn = false
    @State var loadingProgress: Float = 0.0
    @State var processTimer : Timer
 
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            HStack {
                Button(action: {
                     self.changeBackgroundColor()
                }, label: {
                    VStack(alignment: .center, spacing: 0.0) {
                        CustomButton(animation: self.$animationOn, loadingProgress: self.$loadingProgress)
                        ProgressBar(value: (self.$loadingProgress))
                            .frame(height: 4.0)
                            .offset(x: 2, y: 11)
                    }
                    
                })
                .frame(width: UIScreen.main.bounds.width - 40, height: 60.0)
                .background(animationOn ? Color.green : Color.white)
                .cornerRadius(10)
            }
            
        }
        
    }
    
    func changeBackgroundColor() {
        self.animationOn.toggle()
        
        if (processTimer.isValid && self.animationOn == false) {
            processTimer.invalidate()
            loadingProgress = 0
            return
        }

        processTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if loadingProgress <= 1.0 {
                withAnimation {
                    loadingProgress += 0.015
                    print("progress \(loadingProgress)")

                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let processTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            
        }
        SSProgressiveButton(processTimer: processTimer)
    }
}
