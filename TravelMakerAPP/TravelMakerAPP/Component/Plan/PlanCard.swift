//
//  PlanCard.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/29/24.
//

import SwiftUI

struct PlanCard: View {
    
    //FIELD
    @State var planGroups : [PlanGroup] = []
    
    
    
    //BODY
    var body: some View {
        VStack{
            List{
                ForEach(planGroups, id: \.id){plangroup in
                    NavigationLink(destination: PlanView(planGroup : plangroup)){
                        
                    }, 
                }
                
            }
                
        }
    }
    
    //FUNCTION
}

//EXTENSION
extension PlanCard{
    //card View
    private var cardView : some View{
        VStack{
            ZStack{
                
            }
        }
    }
    
    //card image (systemImage)
    
    
    
    
}

