//
//  SearchBar.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/21/24.
//
import SwiftUI

struct AISearchBarTest_SQLITE : View {
    
    //field
    @Binding var text : String
    @State var searchingText : String = ""
    @State var searchList : [SearchList] = []
//    @FocusState var isTextfieldFocused : Bool
    @State var dbManager = TM_DB()
    var isTextfieldFocused : FocusState<Bool>.Binding
    
    var filteredSearchList : [SearchList] {
        guard text.isEmpty else {return searchList}
        return searchList.filter{
            $0.searchName.localizedCaseInsensitiveContains(text)
        }
    }
        
    //======dateFormatter 정의
    var dateFormatter : DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd EEE HH:mm:ss"
        return formatter
    }
        
        
        
        var body: some View{
            NavigationStack{
                
                List(searchList){data in
                    NavigationLink(
                        destination: DetailView(searchText: data.searchName),
                        label:{Text(data.searchName)}
                    )
                }
                .listStyle(.plain)
                .onAppear{
                    searchList.removeAll()
                    searchList = dbManager.queryDB_searchList()
                }
                
                .overlay(
                    Button(
                        action: {
                            // searchText가 비어있는지 확인.
                            _ = text.trimmingCharacters(in: .whitespacesAndNewlines)
                            if (!text.isEmpty){
                                addToSearchResults(text)
                                print("save\(text)")
                                searchList.removeAll()
                                searchList = dbManager.queryDB_searchList()
                                
                                
                            }
                        })
                    {
                        Image(systemName: "magnifyingglass")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 8)
                    }
                )//overlay
                
            }
            .searchable(text: $text, placement: .navigationBarDrawer(displayMode: .always), prompt: "검색어를 입력하세요" )
        }
        
        func addToSearchResults(_ addText: String){
            searchList = dbManager.queryDB_searchList()
            let searchNames = searchList.map { $0.searchName }
            
            if searchNames.contains(addText){
                //이미 존재하는 항목일 경우
                print("이미 존재하는 내용")
                let currentDateStr = dateFormatter.string(from: Date())
                _ = dbManager.updateDB_searchList_date(searchDate: currentDateStr)
                
            }else{
                //새로운 항목 추가.
                print("새로운 내용 추가")
                let currentDateStr = dateFormatter.string(from: Date())
                _ = dbManager.insertDB_searchList(searchName: addText, searchDate: currentDateStr)
            }
            //        searchList.removeAll()
            
        }
        //검색결과를 실시간 update하도록 만드는 함수
        func searchResults() {
            searchList.removeAll()
            if searchingText.isEmpty {
                searchList = dbManager.queryDB_searchList()
            } else {
                searchList = dbManager.queryDB_searchList()
                    .filter { $0.searchName.localizedStandardContains(searchingText) }
            }
        }
        
        //searcingText를 text로 바꿔주는 ㅎ마수
        func resultText() {
            text = searchingText
            searchResults()
        }
        
    }
    

