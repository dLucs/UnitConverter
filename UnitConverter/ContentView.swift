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
    let lengths = ["meters", "kilometers", "feet", "yards", "miles"]
    let temperatures = ["Celsius", "Fahrenheit", "Kelvin"]
    let times = ["seconds", "minutes", "hours", "days"]
    
  
    
    
    var conversionResult: Double {
       
            
            var result: Double = 0.0
            
           
            return result
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
