//
//  HomeView_real.swift
//  TravelMakerAPP
//
//  Created by ms k on 4/4/24.
//

import SwiftUI

struct HomeView_real: View {
    
    @State var showDetail : Bool = false
    @State var searchHashTag : String = ""
    
    var body: some View {
        GeometryReader{ geo in
            VStack(spacing: 0){
                //            Spacer()
                //IMAGE
                jejuaiimage
                      .frame(width: geo.size.width ,height: geo.size.height * 0.15)
                    
                
                //SEARCH BAR
                AISearchBar_real()
                    .frame(height: geo.size.height * 0.6)
                    
                Divider()
                    .frame(width: 5, height: 5)
                
                //HASH TAG View
                hashTagView
                    .frame(height: geo.size.height * 0.25)
                    .background(Color.gray.opacity(0.1))
                
            }
        }
    }
    
    
    //function
}

extension HomeView_real{
    private var jejuaiimage : some View{
        HStack{
            Image("JejuAiModel")
                .resizable()
                .frame(width: 120, height: 120)
                
        }
//        .background(Color.gray.opacity(0.1))
    }
    
    private var hashTagView : some View{
        
        //해쉬 태그 예시
        let hashtags: [String] = [
            "#SwiftUI",
            "#iOSDevelopment",
            "#MobileApp",
            "#Programming",
            "#Coding",
            "#Xcode",
            "#SwiftLanguage",
            "#AppDevelopment",
            "#Apple",
            "#Developer",
            "#UI",
            "#UX",
            "#InterfaceDesign",
            "#AppDesign",
            "#CodeLife",
            "#Tech",
            "#Software",
            "#Engineering",
            "#DeveloperCommunity",
            "#CodeSnippets",
            "#SwiftCode",
            "#UIKit",
            "#SwiftPackage",
            "#AppStore",
            "#WWDC",
            "#AppDevelopmentTips",
            "#SoftwareEngineering",
            "#DevelopmentLife",
            "#MobileApps",
            "#AppleDeveloper",
            "#DeveloperTools",
            "#SwiftDev",
            "#iOSProgramming",
            "#MobileDevelopment",
            "#CodeNewbie",
            "#AppDesignInspiration",
            "#SwiftTips",
            "#SoftwareDeveloper",
            "#TechCommunity",
            "#iOSApps",
            "#CodingLife",
            "#ProgrammingCommunity",
            "#CodeChallenge",
            "#SoftwareDevelopmentLifeCycle",
            "#SwiftCoding",
            "#iOSDevelopmentTips",
            "#MobileAppDesign",
            "#SoftwareEngineer",
            "#SwiftProgrammer"
        ]
        
        let gridItemLayout = [
            GridItem(.flexible(minimum: 100)),
            GridItem(.flexible(minimum: 100)),
            GridItem(.flexible(minimum: 100))
        ]
        
        return NavigationView{
            ScrollView{
                LazyVGrid(columns: gridItemLayout, spacing: 5){
                    ForEach(hashtags, id: \.self){tag in
                       
                            Text(tag)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(Color.yellow.opacity(0.5))
                                .cornerRadius(20)
                                .shadow(radius: 10)
                                .onTapGesture{
                                    searchHashTag = tag
                                    showDetail.toggle()
                                }
                                .sheet(isPresented: $showDetail) {
                                    DetailView(searchText: searchHashTag)
                                }
                    }
                }
            }
        }
    }
    

    
    
}

