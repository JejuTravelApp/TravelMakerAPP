//
//  HomeViewTest.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/21/24.
//

import SwiftUI

struct AISearchTest: View {
    
    @State var searchText : String                  //TextField에 검색한 내용. => DetailView로 전송
    @State var showDetail : Bool = false            //sheet(DetailView)를 띄울 때 사용할 상태변수.
    @StateObject var dbManager = TM_DB()
    @FocusState var isTextfieldFocused : Bool
                                                    //searchbar 변수
    @State var currentDate : Date
    
    // dateFormatter 정의
    var dateFormatter : DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd EEE HH:mm:ss"
        return formatter
    }
    
    @State var testList = ["test1", "test2", "test3", "test4", "test5", "test6"]
    
    var body: some View {
        VStack(spacing:-10){
            Image("JejuAiModel")
                .resizable()
                .frame(width: 120, height: 120)
            // SEARCH BAR Start
            AISearchBarTest_SQLITE(text: $searchText, isTextfieldFocused: $isTextfieldFocused)
            
            
            // SearchBar End
            // 해시태그
//                VStack(spacing: 20) {
//                    self.aaaaa
//                    self.bbbb
//                }
//                .padding(20)
                
            }
        }
        
    
    //====== func ======
//     searchAction이 들어갈 함수
    func searchAction(searchData: String){
        showDetail = true
    }
}




//extension AISearchTest {
//    var aaaaa: some View {
//        HStack(spacing: 10) {
//            ForEach(0..<3, id: \.self) { index in
//                Button(testList[index]) {
//                    searchText = (testList[index])
//                    searchAction(searchData: searchText)
//                }
//                    .fontWeight(.bold)
//                    .buttonStyle(.bordered)
//            }
//        }
//    }
//    
//    
//    // MARK: 기능 이름
//    
//    var bbbb: some View {
//        HStack(spacing: 10) {
//            ForEach(3..<6, id: \.self) { index in
//                Button(testList[index]) {
//                    searchText = (testList[index])
//                    searchAction(searchData: searchText)
//                }
//                    .fontWeight(.bold)
//                    .buttonStyle(.bordered)
//            }
//        }
//    }
//}
