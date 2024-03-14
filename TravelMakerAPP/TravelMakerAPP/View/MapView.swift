//
//  MapView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/14/24.
//

import SwiftUI

struct MapView: View {
    
//    @State var ShapeColor: Color = Color.blue
//    @State var ShapeOpacity: Double = 2.0
    @State var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Text("ddddd")
//                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
//                .frame(width: 260, height: 260, alignment: .center)
                .offset(y: isAnimating ? 0 : 100) // UIScreen.main.bounds.size.width: 해당 디바이스의 너비값
                .animation(.easeIn(duration: 1), value: isAnimating)
                
        } //: ZSTACk
        .onAppear(perform: {
            isAnimating.toggle()
        })
    }}

//#Preview {
//    MapView()
//}
