////
////  HomeView.swift
////  TravelMakerAPP
////
////  Created by 김민수 on 3/17/24.
////  Description: AI기능인 여행지 추천을 해주는 뷰
//
//// 구현해야할 것 : searchBar
//// 1. 추천검색어 (list로 만들어두고 다양하게 추천)
//// 2. 최근검색어 저장 (최근 5개 까지)
//// 2-1. 개별삭제 및 전체삭제 만들어 두기
////
////
//
//
//import SwiftUI
//
//
//
//struct HomeView: View {
//    
//    
//    
//    @State var searchText : String = ""
//    @State var sendMessage : String = ""
//    @State private var isEditing = false
//    @FocusState private var isFocusfield : Bool
//    @State var tagList : String = ""
//      
//    var body: some View {
//        VStack{
//            Image("JejuAiModel")
//                .resizable()
//                .frame(width: 120, height: 120)
//            
//            HStack{
//                TextField("검색어를 입력하세요", text: $searchText)
//                    .frame(width: 180, height: 50)
//                    .padding(.horizontal, 25)
//                    .background(Color.gray.opacity(0.5))
//                    .cornerRadius(10.0)
//                    .keyboardType(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
//                    .overlay(
//                        HStack{
//                            //돋보기 아이콘
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(.black)
//                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                                .padding(.leading, 8)
//                            if isEditing{
//                                Button(action: {
//                                    self.searchText = ""
//                                    
//                                }) {
//                                    Image(systemName: "multiply.circle.fill")
//                                        .foregroundColor(.gray)
//                                        .padding(.trailing, 8)
//                                }
//                            }
//                        }
//                    )
//                    .padding(.horizontal, 10)
//                    .onTapGesture {
//                        self.isEditing = true
//                    }
//                
//                if isEditing{
//                    Button(action: {
//                        self.isEditing = true
//                        self.sendMessage = searchText
//                    }, label: {
//                        Text("Search")
//                            .foregroundStyle(Color.blue)
//                            .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                            .font(.system(size: 14))
//                        
//                    })
//                    .frame(width: 50, height: 30)
//                    .border(.blue, width: 2)
//                    .cornerRadius(5)
//                    
//                    
//                    Button(action: {
//                        self.isEditing = false
//                    
//                    }, label: {
//                        Text("Cancel")
//                            .foregroundStyle(Color.red)
//                            .frame(alignment: .center)
//                            .font(.system(size: 14))
//                            
//                    })
//                    .frame(width: 50, height: 30)
//                    .border(.red, width: 2)
//                    .cornerRadius(5)
//                    //keyboard내리기
//                    
//                }
//                
//                
//                    
//                
//            }
//        }
//
//            
//        
//
//        
//    }
//}
////
////#Preview {
////    HomeView(searchText: <#String#>)
////}
