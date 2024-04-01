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
//struct AISearchBarTest_SQLITE3 : View {
//    
//    
//    @Binding var text : String //AISearch에서 검색한 결과 들고올 것.
//    //stateobject를 사용하면 view를 다시 그리지 않아도 된다.
//    @State var dbManager = TM_DB()
//    @State var searchList : [SearchList] = []
////    @State var searchResultList : [SearchResultItem] = []
//    @FocusState var isTextFieldFocused : Bool
//    
//    
//    // dateFormatter 정의
//    var dateFormatter : DateFormatter{
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd EEE HH:mm:ss"
//        return formatter
//    }
//    
//    
//    var body: some View {
////        
//        VStack {
//            TextField("검색어를 입력하세요", text: $text)
//                .frame(width: 250, height: 50)
//                .padding(.horizontal, 8)
//                .background(Color.gray.opacity(0.5))
//                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
//                .keyboardType(.default)
//                .autocorrectionDisabled()//자동수정방지
//                .textInputAutocapitalization(.never)//자동첫글자대문자 방지
//                .focused($isTextFieldFocused)
////                .searchable(text: $text, placement: .sidebar)
//                .overlay(
//                    NavigationView{
//                        
//                        HStack{
//                            
//                            Button(
//                                action: {
//                                    // searchText가 비어있는지 확인.
//                                    _ = text.trimmingCharacters(in: .whitespacesAndNewlines)
//                                    if (!text.isEmpty){
//                                        print("돋보기 버튼 클릭")
//                                        addToSearchResults(text)
//                                        print("함수실행 후")
//                                        searchList = dbManager.queryDB_searchList()
//                                        
//                                    }
//                                    
//                                })
//                            {
//                                Image(systemName: "magnifyingglass")
//                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
//                                    .padding(.trailing, 8)
//                            }
//                            
//                            if isTextFieldFocused{
//                                //cancel button 표시
//                                Button(
//                                    action: {
//                                        text = ""
//                                        isTextFieldFocused = false
//                                        searchList = dbManager.queryDB_searchList()
//                                    })
//                                    {
//                                        Image(systemName: "multiply.circle.fill")//x모양 버튼
//                                            .foregroundStyle(Color.gray)
//                                            .padding(.trailing)
//                                    }
//                            }else{//텍스트 필드 바깥을 터치했을 때
//                                //키보드 숨기기 기능 만들기
//                                
//                            }
//                            
//                            
//                        }
//                    }
//                    
//                )//overlay
//                .onTapGesture{
////                    searchList = dbManager.queryDB_searchList()
//                }
//            
//            
////            List {
////                ForEach(searchResults.sorted { $0.searchDate > $1.searchDate }) { searchResult in
////                        Text("검색내용 : \(searchResult.searchName)")
////                    }
////                    .onDelete(perform: { indexSet in
////                        deleteItem(at: indexSet)
////                    })
////            }
////            .onAppear(perform: {
////                print("onAppear")
////                searchResults = dbManager.queryDB_searchList().map { ($0.searchName, $0.searchDate) }
////
////            })
//            
//            
//
//
//                
//            
//        }
//        .onTapGesture{
//            isTextFieldFocused = false
//        }
//    }
////    func addToSearchResults(_ addText: String){
////        //이미 searchList에 DB에서 불러온 내용이 저장되어 있음. 이 함수 실행전에 삽입.
////        //searchList = db.query뭐시기 ~~~~ 되어 있는 상태.
////
////        //$0 : SearchList의 객체
////        let checkSearchResultList = searchList.filter({$0.searchName == addText})
////        print(checkSearchResultList)
////        //현재 시간을 string타입으로 바꾼것.
////        let currentDateStr = dateFormatter.string(from: Date())
////
////        /// searchList에 있는 내용과 addText할게 같다면, currentDateStr만 수정해준다.
////        /// 함수이름은 "updateDB_searchList_date" 필요한건 searchDate
////
////
////        // 이미 존재하면 추가하지 않고 순서를 최상단으로
////        if !checkSearchResultList.isEmpty {
////            // 이미 있는 항목은 지우고
////            if let existingIndex = checkSearchResultList(of: addText) {
////                searchResultList.remove(at: existingIndex)
////                _ = dbManager.deleteDB_searchList(searchId: Int32(existingIndex))
////            }
////            // 새로운 요소를 배열의 맨 앞에 추가
////            searchResultList.insert(addText, at: 0)
////            _ = dbManager.insertDB_searchList(searchName: addText, searchDate: currentDateStr)
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
////        let success = dbManager.insertDB_searchList(searchName: addText, searchDate: currentDateStr)
////        if success{
////            print("성공")
////        }else{
////            print("실패")
////        }
////    }
//    func addToSearchResults(_ addText: String){
//        // 이미 searchList에 DB에서 불러온 내용이 저장되어 있음. 이 함수 실행전에 삽입.
//        // searchList = db.query뭐시기 ~~~~ 되어 있는 상태.
//        // $0 : SearchList의 객체
//        if searchResults.first(where: { $0.0 == addText }) != nil {
//            // 이미 존재하는 항목이면 업데이트
//            let currentDateStr = dateFormatter.string(from: Date())
//            let success = dbManager.updateDB_searchList_date(searchDate: currentDateStr)
//            
//            if success {
//                print("성공: 기존 항목 업데이트")
//                
//            } else {
//                print("실패: 기존 항목 업데이트")
//                
//            }
//        } else {
//            // 새로운 항목 추가
//            let currentDateStr = dateFormatter.string(from: Date())
//            let success = dbManager.insertDB_searchList(searchName: addText, searchDate: currentDateStr)
//            if success {
//                print("성공: 새로운 항목 추가")
//                
//            } else {
//                print("실패: 새로운 항목 추가")
//                
//            }
//        }
//        //함수가 완료되면 searchList를 비워준다.
//        
//        
//        
//        
//        // searchList에 있는 내용과 addText할게 같다면, currentDateStr만 수정해준다.
//        // 함수이름은 "updateDB_searchList_date" 필요한건 searchDate
//        
//        // 이미 존재하면 추가하지 않고 순서를 최상단으로
//        /*
//        if !checkSearchResultList.isEmpty {
//            // 이미 있는 항목은 지우고
//            if let existingIndex = checkSearchResultList(of: addText) {
//                searchResultList.remove(at: existingIndex)
//                _ = dbManager.deleteDB_searchList(searchId: Int32(existingIndex))
//            }
//            // 새로운 요소를 배열의 맨 앞에 추가
//            searchResultList.insert(addText, at: 0)
//            _ = dbManager.insertDB_searchList(searchName: addText, searchDate: currentDateStr)
//        }
//        
//        if checkSearchResultList.isEmpty{
//            searchResultList.append(addText)
//        }
//        
//        // 배열 10개 넘어가면 밀어내기
//        if searchResultList.count > 10{
//            searchResultList.removeFirst()
//        }
//        
//        let success = dbManager.insertDB_searchList(searchName: addText, searchDate: currentDateStr)
//        if success{
//            print("성공")
//        }else{
//            print("실패")
//        }
//        */
//    }
//
//    
//    func deleteItem(at offset: IndexSet){
//        for index in offset{
//            let item = searchList[index].searchId
//            print(item)
//            _ = dbManager.deleteDB_searchList(searchId: Int32(item))
//            
//            
//            
//        }
//    }
//}
//
//extension AISearchBarTest_SQLITE3{
//    
//    var searchResults: ([(String, String)]) {
//        if text.isEmpty {
//            return dbManager.queryDB_searchList().map { ($0.searchName, $0.searchDate) }
//            
//        } else {
//            return dbManager.queryDB_searchList()
//                .filter { $0.searchName.contains(text) }
//                .map { ($0.searchName, $0.searchDate) }
//        }
//    }
//}
