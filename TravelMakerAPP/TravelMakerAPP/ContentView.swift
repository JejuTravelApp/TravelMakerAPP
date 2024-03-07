//
//  ContentView.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView(selection: $selection){
            pickerView()
                .tabItem {
                    Image(systemName: "house")
                    Text("PickerView")
                }
                .tag(0)
            
            DatePickerView()
                .tabItem {
                    Image(systemName: "car")
                    Text("DatePicker")
                }
                .tag(1)
            
            alertActionView()
                .tabItem {
                    Image(systemName: "alarm")
                    Text("alertAction")
                }
                .tag(2)
            startView()
                .tabItem {
                    Image(systemName: "mail")
                    Text("startView")
                }
            
            
            
        }
        .accentColor(.red)
    }

#Preview {
    ContentView()
}
