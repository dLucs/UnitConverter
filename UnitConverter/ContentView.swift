//
//  ContentView.swift
//  UnitConverter
//
//  Created by Lucas on 15/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNumber = 0.0
    @State private var inputUnit = ""
    @State private var outputUnit = ""
    @State private var conversionType = "Temperature"
    @FocusState private var inputIsFocused: Bool
    
    let conversions = ["Length", "Temperature", "Time"]
    let lengths = ["meters", "kilometers","centimeters", "millimeters", "inches","feet", "yards", "miles"]
    let temperatures = ["Celsius", "Fahrenheit", "Kelvin"]
    let times = ["seconds", "minutes", "hours", "days", "weeks", "months", "years"]
    
    func convertLength() -> Double {
         let conversionFactors: [Double] = [
             1.0, // meters
             1000.0, // kilometers
             0.01, // centimeters
             0.001, // millimeters
             0.0254, // inches
             0.3048, // feet
             0.9144, // yards
             1609.34 // miles
         ]

        let fromFactor = conversionFactors[lengths.firstIndex(of: inputUnit) ?? 0]

         let toFactor = conversionFactors[lengths.firstIndex(of: outputUnit) ?? 0]

         let result = inputNumber * (fromFactor / toFactor)
         return result
     }
    
    func convertTemperature() -> Double {
        let conversionFormulas: [(Double) -> Double] = [
                { $0 },                             // Celsius to Celsius
                { ($0 * 9/5) + 32 },                 // Celsius to Fahrenheit
                { $0 + 273.15 }                      // Celsius to Kelvin
            ]

            let result = conversionFormulas[temperatures.firstIndex(of: inputUnit) ?? 0](inputNumber)
            let convertedResult = conversionFormulas[temperatures.firstIndex(of: outputUnit) ?? 0](result)

            return convertedResult
        }
    
    func convertTime() -> Double {
         let conversionFactors: [Double] = [
            1.0,      // seconds
            60.0,     // minutes
            3600.0,   // hours
            86400.0,  // days
            604800.0, // weeks
            2628000.0, // average days in a month (30.44 days)
            31536000.0 // average days in a year (365.25 days)
             
         ]

        let fromFactor = conversionFactors[times.firstIndex(of: inputUnit) ?? 0]

         let toFactor = conversionFactors[times.firstIndex(of: outputUnit) ?? 0]

         let result = inputNumber * (fromFactor / toFactor)
         return result
     }

    
    
    var conversionResult: Double {
       
       
        switch conversionType {
          case "Length":
            return convertLength()
          case "Temperature":
            return convertTemperature()
          case "Time":
            return convertTime()
          default:
              return 0.0
          }
     
        }

    
    var body: some View {
        NavigationStack{
            Form{
                Section("Choose Conversion Type"){Picker("Tip percentage", selection: $conversionType){
                    ForEach(conversions, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.segmented)
                        .onAppear(perform: {
                            outputUnit = temperatures[0]
                            inputUnit = temperatures[0]})
                    .onChange(of: conversionType) {
                        if (conversionType == "Temperature"){
                            outputUnit = temperatures[0]
                            inputUnit = temperatures[0]}
                        else if (conversionType == "Length"){
                            outputUnit = lengths[0]
                            inputUnit = lengths[0]}
                        else {outputUnit = times[0]
                            inputUnit = times[0]}
                            }
                }

                    Section("Input value to convert"){
                        
                        TextField("Value", value: $inputNumber, format: .number) .keyboardType(.decimalPad)
                            .focused($inputIsFocused)
                        
                            
                        HStack(){
                            
                            Section(){Picker("from", selection: $inputUnit){
                                if (conversionType == "Temperature"){
                                    ForEach(
                                        temperatures, id: \.self){
                                            Text($0)
                                        }}else  if (conversionType == "Length"){
                                            ForEach(
                                                lengths, id: \.self){
                                                    Text($0)
                                                }}else {ForEach(
                                                    times, id: \.self){
                                                        Text($0)
                                                    }}
                            }
                            }
                            Section(){Picker("    to", selection: $outputUnit){
                                if (conversionType == "Temperature"){
                                    ForEach(
                                        temperatures, id: \.self){
                                            Text($0)
                                        }}else  if (conversionType == "Length"){
                                            ForEach(
                                                lengths, id: \.self){
                                                    Text($0)
                                                }}else {ForEach(
                                                    times, id: \.self){
                                                        Text($0)
                                                    }}
                            }
                            }
                            
                        }
                        
                    }
                    
                    Section("Conversion"){
                        HStack(){
                            Text(conversionResult, format: .number)
                            Text(outputUnit)
                        }
                    }
                        
                    
                
            }
                
            } .navigationTitle("Unit Converter")
        }
    }


#Preview {
    ContentView()
}
