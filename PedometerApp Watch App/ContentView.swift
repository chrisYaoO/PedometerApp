//
//  ContentView.swift
//  PedometerApp Watch App
//
//  Created by Chris Yao on 2026-03-16.
//

import SwiftUI

struct ContentView: View {
    
    @State private var manager = PedometerManager()
    var body: some View {
        VStack(spacing: 6) {
            Text("Pedometer")
                .font(.headline)
            
            Text("\(manager.steps)")
                .font(.title2)
            
            Text("steps today")
                .font(.caption)
            
            Text(manager.status)
                .font(.title2)
            
            Button ("fetch"){
                manager.fetchTodaySteps()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

