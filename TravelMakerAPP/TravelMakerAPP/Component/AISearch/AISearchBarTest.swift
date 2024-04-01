////
////  SearchBar.swift
////  TravelMakerAPP
////
////  Created by ms k on 3/21/24.
////
//
//import SwiftUI
//
////struct AISearchBar: UIViewRepresentable {
//struct AISearchBarTest : View {
//    
// 
//    @Binding var text : String //AISearch에서 검색한 결과 들고올 것.
//    @State var searchList : [SearchList] = []
//     
//    @State var searchResultList : [String] = [] //SearchBar에서 검색한 결과 저장할 빈 배열
//
//    @State var showDetail : Bool = false
//    @FocusState var isTextFieldFocused : Bool
// 
//    var searchResults: [String] {
//            if text.isEmpty {
//                return searchResultList
//            } else {
//                return searchResultList.filter { $0.contains(text)
//                }
//            }
//        }
//    
//    var body: some View {
//            NavigationStack {
//                TextField("검색어를 입력하세요", text: $text)
//                    .frame(width: 250, height: 50)
//                    .padding(.horizontal, 8)
//                    .background(Color.gray.opacity(0.5))
//                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
//                    .keyboardType(.default)
//                    .autocorrectionDisabled()//자동수정방지
//                    .textInputAutocapitalization(.never)//자동첫글자대문자 방지
//                    .focused($isTextFieldFocused)
////                        .searchable(text: $text, placement: .sidebar)
//                    .overlay(
//                            HStack{
//                                Button(
//                                    action: {
//                                        // searchText가 비어있는지 확인.
//                                        isTextFieldFocused = false
//                                        _ = text.trimmingCharacters(in: .whitespacesAndNewlines)
//                                        if (!text.isEmpty){
////                                            showDetail = true
//                                            addToSearchResults(text)
//                                        }
//                                        
//                                    })
//                                {
//                                    Image(systemName: "magnifyingglass")
//                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
//                                        .padding(.trailing, 8)
//                                }
//                                //                                    .fullScreenCover(isPresented: $shosDetail){
//                                .sheet(isPresented: $showDetail){
//                                    DetailView(searchText: text)
//                                }
//                                if isTextFieldFocused{
//                                    //cancel button 표시
//                                    Button(action: {
//                                        text = ""
//                                        isTextFieldFocused = false
//                                    }){
//                                        Image(systemName: "multiply.circle.fill")//x모양 버튼
//                                            .foregroundStyle(Color.gray)
//                                            .padding(.trailing)
//                                    }
//                                }else{//텍스트 필드 바깥을 터치했을 때
//                                    //키보드 숨기기 기능 만들기
//                                }
//
//                            }
//                    )//overlay
//            
//     
//            List {
//                ForEach(searchResults, id: \.self) { searchResult in
//                    NavigationLink{
//                        DetailView(searchText: text)
//                        Text(searchResult)
//                    } label: {
//                        Text(searchResult)
//                    }
//                }
//                .sheet(isPresented: $showDetail){
//                    DetailView(searchText: text)
//                }
//            }
//        }
//    }
//    //시뮬레이터 너무오래걸려서 현재 테스트는 못하고 있는 상황.
//    func addToSearchResults(_ addText: String){
//        let checkSearchResultList = searchResultList.filter({$0 == addText})
//        
//        // 이미 존재하면 추가하지 않고 순서를 최상단으로
//        if !checkSearchResultList.isEmpty {
//            // 이미 있는 항목은 지우고
//            if let existingIndex = searchResultList.firstIndex(of: addText) {
//                searchResultList.remove(at: existingIndex)
//            }
//            // 새로운 요소를 배열의 맨 앞에 추가
//            searchResultList.insert(addText, at: 0)
//        }
//        
//        if checkSearchResultList.isEmpty{
//            searchResultList.append(addText)
//        }
//        
//        //배열 10개 넘어가면 밀어내기
//        if searchResultList.count > 10{
//            searchResultList.removeFirst()
//        }
//        
//        showDetail = true
//        
//    }
//}
