//
//  PedometerManager.swift
//  PedometerApp
//
//  Created by Chris Yao on 2026-03-16.
//
import Foundation
import Observation
import CoreMotion

@Observable
class PedometerManager{
    var steps = 0
    var status = "Not Started"
    let now = Date()
    
    private let pedometer = CMPedometer()
    
    func fetchTodaySteps(){
        guard CMPedometer.isStepCountingAvailable() else{
            status = "not available"
            return
        }
        
        let start = Calendar.current.startOfDay(for: now)

        pedometer.queryPedometerData(from: start, to: now){ data, error in
            if let error = error{
                DispatchQueue.main.async {
                    self.status = "Error:\(error.localizedDescription)"
                }
                return
            }
            
            let steps_num = data?.numberOfSteps.intValue ?? 0
            DispatchQueue.main.async {
                self.status = "Updated"
                self.steps = steps_num
                
            }
        }
    }
    
    func startUpdate(){
        guard CMPedometer.isStepCountingAvailable() else {
                  status = "Step counting not available"
                  return
              }
              
              let startOfDay = Calendar.current.startOfDay(for: Date())
              
              pedometer.startUpdates(from: startOfDay) { data, error in
                  if let error = error {
                      DispatchQueue.main.async {
                          self.status = "Live update error: \(error.localizedDescription)"
                      }
                      return
                  }
                  
                  let stepsNum = data?.numberOfSteps.intValue ?? 0
                  
                  DispatchQueue.main.async {
                      self.steps = stepsNum
                      self.status = "Live"
                  }
              }
    }
    
    func stopUpdate(){
        pedometer.stopUpdates()
        self.status = "Stopped"
    }
}
