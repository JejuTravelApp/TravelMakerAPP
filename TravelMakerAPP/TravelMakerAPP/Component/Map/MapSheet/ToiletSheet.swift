//
//  ToiletSheet.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/17/24.
//

import SwiftUI

struct ToiletSheet: View {
    
    @Binding var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 25))
                .bold()
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 10))

        }
        
    }
}

