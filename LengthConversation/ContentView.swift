//
//  ContentView.swift
//  LengthConversation
//
//  Created by Raymond Chen on 2/3/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var convertUnit: UnitLength = .meters
    @State private var toUnit: UnitLength = .feet
    @State private var convertLength: Double = 0.0
    @FocusState private var convertUnitIsFocused: Bool
    
    private var toLength: Measurement<UnitLength> {
        let inputValue = Measurement(value: convertLength, unit: convertUnit)
        let outputValue = inputValue.converted(to: toUnit)
        return outputValue
    }
    
    let units: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    let formatter: MeasurementFormatter
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .medium
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Convert Length", selection: $convertUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit.localizedName)
                        }
                    }
                    TextField("Input", value: $convertLength, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($convertUnitIsFocused)
                }
                
                Section {
                    Picker("To Length", selection: $toUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit.localizedName)
                        }
                    }
                    Text(toLength, formatter: formatter)
                }
            }
            .navigationTitle("Length Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        convertUnitIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UnitLength {
    var localizedName: String {
        if self == UnitLength.meters {
            return "Meter"
        } else if self == UnitLength.kilometers {
            return "Kilometer"
        } else if self == UnitLength.feet {
            return "Feet"
        } else if self == UnitLength.yards {
            return "Yards"
        } else if self == UnitLength.miles {
            return "Miles"
        } else {
            return "Unknown"
        }
    }
}
