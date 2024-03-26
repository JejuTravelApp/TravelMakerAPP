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
//struct AISearchBarTest_SQLITE : View {
// 
//    @Binding var text : String //AISearch에서 검색한 결과 들고올 것.
//    @State var isInsert : Bool = false
//    @State var searchList : [SearchList] = [] // searachList형태의 배열.
////    @State var searchResultList : [String] = [] //SearchBar에서 검색한 결과 저장할 빈 배열
//    @State var showDetail : Bool = false
//    @FocusState var isTextFieldFocused : Bool
//    
//    //DB선언
//    let DBManager = TM_DB()
// 
//    var searchResults: [String] {
//        if text.isEmpty {
//            print(searchList.map {$0.searchName})
//            return searchList.map { $0.searchName }
//        } else {
//            print(searchList.map { $0.searchName }.filter { $0.contains(text)
//            })
//            return searchList.map { $0.searchName }.filter { $0.contains(text)
//            }
//        }
//    }
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
//                        HStack{
//                            Button(
//                                action: {
//                                    // searchText가 비어있는지 확인.
//                                    let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
//                                    let checkNum = searchList.count
//                                    if (!trimmedText.isEmpty){
//                                        showDetail = true
//                                        //검색 내역 추가
//                                        isInsert = true
//                                        delete_insert_Item(at: checkNum, trimmedText: trimmedText)
//                                    }
//                                    isTextFieldFocused = false
//                                    
//                                })
//                            {
//                                Image(systemName: "magnifyingglass")
//                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
//                                    .padding(.trailing, 8)
//                            }
//                            //                                    .fullScreenCover(isPresented: $showDetail){
//                            .sheet(isPresented: $showDetail){
//                                DetailView(searchText: text)
//                            }
//                            if isTextFieldFocused{
//                                //cancel button 표시
//                                Button(action: {
//                                    text = ""
//                                    isTextFieldFocused = false
//                                }){
//                                    Image(systemName: "multiply.circle.fill")//x모양 버튼
//                                        .foregroundStyle(Color.gray)
//                                        .padding(.trailing)
//                                }
//                            }else{//텍스트 필드 바깥을 터치했을 때
//                                //키보드 숨기기 기능 만들기
//                            }
//
//                        }
//                    )//overlay
//            
//     
//                List {
//                    Section{//List section추가.
//                        ForEach(searchList, id: \.searchId) {searchItem in
//                            NavigationLink(destination: DetailView(searchText: searchItem.searchName)){
//                                Text(searchItem.searchName)
//                            }
//                        }
//                        .onDelete(perform: {indexSet in
//                            deleteItem(at: indexSet)
//                        })
//                    }
//                header:{
//                    Text("검색 기록")
//                }
//
//                }
//                .onAppear(perform: {
//                    searchList.removeAll()
//                    searchList = searchListDBManager.queryDB_searchList()
//                })
//                
//                
//                
//        }
//    }
//    //시뮬레이터 너무오래걸려서 현재 테스트는 못하고 있는 상황.
////    func addToSearchResults(_ addText: String){
////        let checkSearchResultList = searchResultList.filter({$0 == addText})
////        
////        // 이미 존재하면 추가하지 않고 순서를 최상단으로
////        if !checkSearchResultList.isEmpty {
////            // 이미 있는 항목은 지우고
////            if let existingIndex = searchResultList.firstIndex(of: addText) {
////                searchResultList.remove(at: existingIndex)
////            }
////            // 새로운 요소를 배열의 맨 앞에 추가
////            searchResultList.insert(addText, at: 0)
////        }
////        
////        if checkSearchResultList.isEmpty{
////            searchResultList.append(addText)
////        }
////        
////        //배열 10개 넘어가면 밀어내기
////        if searchResultList.count > 10{
////            searchResultList.removeFirst()
////        }
////        
////    }
//    /// === Function ===
//    /// delete_insert_Item : 이미 존재하는 항목은 지우고 새로운 요소를 배열 맨앞에 추가하는 함수. 배열 10개 넘어가면 밀어내기 까지.
//    func delete_insert_Item(at offset: IndexSet, trimmedText: String){
//        for index in offset{
//            let item = searchList[index] //searchList모델에 searchId 기준
//            var checkSearchResult = searchList.filter({$0 == item})//searchList에 item과 동일한 항목이 있는지 체크
//            let existingIndex = searchList.firstIndex(of: item)
//            
//            //이미 존재하는지 확인 후 순서를 최상단으로
//            //이미 있는 항목은 지우고
//            if let existingIndex = existingIndex{
//                searchList.remove(at: existingIndex)
//                searchList.insert(item, at: 0)
//                DBManager.deleteDB_searchList(searchId: Int32(existingIndex))
//                DBManager.insertDB_searchList(searchName: trimmedText)
//            }else {
//                // 동일한 항목이 없는 경우 배열에 추가
//                searchList.append(item)
//                // 배열이 최대 길이보다 길면 가장 오래된 항목을 삭제
//                if searchList.count > 10 {
//                    DBManager.deleteDB_searchList(searchId: 0)
//                }
//                // 데이터베이스에도 삽입
//                DBManager.insertDB_searchList(searchName: trimmedText)
//            }
//        }
//    }
//    
//    func deleteItem(at offset: IndexSet){
//        for index in offset{
//            let item = searchList[index]
//            _ = DBManager.deleteDB_searchList(searchId: Int32(item.searchId))
//        }
//    }
//}
