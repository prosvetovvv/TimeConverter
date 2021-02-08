//
//  ContentView.swift
//  TimeConverter
//
//  Created by Vitaly Prosvetov on 08.02.2021.
//

import SwiftUI

enum TimeUnits: String {
    case seconds = "Seconds"
    case minutes = "Minutes"
    case hours = "Hours"
    case days = "Days"
    
    var perSeconds: Double {
        switch self {
        case .seconds:
            return 1
        case .minutes:
            return 1 * 60
        case .hours:
            return 60 * 60
        case .days:
            return 3600 * 24
        }
    }
}
 
struct ContentView: View {
    private let units: [TimeUnits] = [.seconds, .minutes, .hours, .days];
    
    @State private var inputValue = "";
    @State private var inputUnit: TimeUnits = .seconds;
    @State private var outputUnit: TimeUnits = .seconds;
    
    var inputValueBySeconds: Double {
        let userValue = Double(inputValue) ?? 0
        return userValue * inputUnit.perSeconds
    }
    
    var outputValue: Double {
        return inputValueBySeconds / outputUnit.perSeconds
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("FROM")) {
                    TextField("Enter value", text: $inputValue)
                        .keyboardType(.numberPad)
                    
                    Picker("Select unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("TO")) {
                    Picker("Select unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result")) {
                    Text("\(outputValue, specifier: "%.2f") \(outputUnit.rawValue.lowercased())")
                }
            }
            .navigationBarTitle("Time Converter")
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

