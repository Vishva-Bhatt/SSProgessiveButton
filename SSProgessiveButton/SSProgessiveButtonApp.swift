//
//  SSProgessiveButtonApp.swift
//  SSProgessiveButton
//
//  Created by Vishva Bhatt on 10/06/21.
//

import SwiftUI

@main
struct SSProgessiveButtonApp: App {
    var body: some Scene {
        WindowGroup {
            let processTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                
            }
            SSProgressiveButton(processTimer: processTimer)
        }
    }
}
