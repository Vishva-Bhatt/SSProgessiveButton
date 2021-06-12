//
//  ContentView.swift
//  SSProgessiveButton
//
//  Created by Vishva Bhatt on 10/06/21.
//

import SwiftUI

struct SSProgressiveButton: View {
    var body: some View {
        HStack {
            Button(action: {}, label: {
                HStack {
                    Image(systemName: "")
                        .padding(.trailing).background(Color.black)
                    Text("Download").background(Color.orange)
                }
            })
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SSProgressiveButton()
    }
}
