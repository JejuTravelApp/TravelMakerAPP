//
//  PlanInsertView.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/28/24.
//

import SwiftUI

struct PlanInsertSheet: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack{
            Text("PlanInsertView")
            Button("Back"){
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
