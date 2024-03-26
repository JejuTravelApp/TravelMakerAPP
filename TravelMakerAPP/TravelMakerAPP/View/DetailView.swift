//
//  DetailView.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/19/24.
//

import SwiftUI


struct DetailView: View {
    //첫화면으로 이동
    @Environment(\.presentationMode) var presentationMode
    //searchTest를 통해 데이터를 검색할 것.
    @State var searchText : String
    
    var body: some View {
        VStack{
            Text(searchText)
            Button("Back"){
                presentationMode.wrappedValue.dismiss()
            }
        }
        
        
        
        
            
    }
}
