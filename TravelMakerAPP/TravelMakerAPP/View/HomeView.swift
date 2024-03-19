//
//  HomeView.swift
//  TravelMakerAPP
//
//  Created by 김민수 on 3/17/24.
//  Description: AI기능인 여행지 추천을 해주는 뷰

// 구현해야할 것 : searchBar
// 1. 추천검색어 (list로 만들어두고 다양하게 추천)
// 2. 최근검색어 저장 (최근 5개 까지)
// 2-1. 개별삭제 및 전체삭제 만들어 두기
//
//


import SwiftUI



struct HomeView: View {
    
    @State var searchText : String //검색에 이용(최근검색어)
    @State private var searchIsActivate : Bool = false //Textfield를 클릭했을 때 true => circleX를 나타나게 할 것.
    @State var showDetail : Bool = false //디테일 뷰로 이동할 때 사용할 상태변수. => true시 DetailView(searchText)를 나타나게 할 것.
    @State private var keyboardHeight : CGFloat = 1
    @FocusState var isTextFieldFocused : Bool //키보드
    @State var testList = ["test1", "test2", "test3", "test4", "test5", "test6"]
    
    //제주도관광지데이터json
    //    @State var tourLists : [TourDataModel]
    
    
    
    
    var body: some View {
        // 뷰 내부에 NavigationLink를 포함하여 뷰를 이동
        NavigationView{
            
                VStack{
                    Image("JejuAiModel")
                        .resizable()
                        .frame(width: 120, height: 120)
                    HStack{
                        TextField("검색어를 입력하세요", text: $searchText)
                            .frame(width: 250, height: 50)
                            .padding(.horizontal, 8)
                            .background(Color.gray.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                            .keyboardType(.default)
                            .focused($isTextFieldFocused)
                        //                        .searchable(text: $searchText, isPresented: $searchIsActivate, prompt: "검색어를 입력하세요")
                            .overlay(
                                HStack{
                                    // 돋보기 아이콘
                                    Button(
                                        // searchAction
                                        action: {
                                            // searchText가 비어있는지 먼저 확인
                                            let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                                            if (!trimmedText.isEmpty){
                                                searchAction(searchData: searchText)
                                                self.showDetail = true
                                            }
                                        })
                                            {
                                                Image(systemName: "magnifyingglass")
                                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                                                    .padding(.trailing, 8)
                                            }
    //                                        .fullScreenCover(isPresented: $showDetail){
                                            .sheet(isPresented: $showDetail){
                                                DetailView(searchText: $searchText)
                                            }
                                    if searchIsActivate{
                                        Button(action: {
                                            searchText = ""
                                            isTextFieldFocused = false
                                        }){
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing)
                                        }
                                    }
                                }
                            )//overlay
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                self.searchIsActivate = true
                            }
//                        if searchIsActivate{
//                            Button(action: {
//                                sendMessage = searchText
//                            }, label: {
//                                Text("Search")
//                                    .foregroundStyle(Color.cyan)
//                                    .frame(alignment: .center)
//                                    .font(.system(size: 14))
//                            })
//                            .frame(width: 50, height: 30)
//                            .border(.blue, width: 2)
//                            .cornerRadius(5)
//        
//                            Button(
//                                action: {
//                                    self.searchIsActivate = false
//                                },
//                                label: {
//                                    Text("Cancel")
//                                        .foregroundStyle(Color.pink)
//                                        .frame(alignment: .center)
//                                        .font(.system(size: 14))
//                                }
//                            )
//                            .frame(width: 50, height: 30)
//                            .border(.red, width: 2)
//                            .cornerRadius(5)
//                            
//                            
//                        }
                    }
                    
                    //Tag내용
                    VStack{
                        HStack(spacing:10){
                            Button(testList[0]){
                                searchText = testList[0]
                                searchAction(searchData: testList[0])
                            }
                            .fontWeight(.bold)
                            //                                                .font(.largeTitle)
//                            .frame(width: 100, height: 30)
                            .buttonStyle(.bordered)
                            
                            Button(testList[1]){
                                searchText = testList[1]
                                searchAction(searchData: testList[1])
                            }
                            .fontWeight(.bold)
                            //                                                .font(.largeTitle)
//                            .frame(width: 100, height: 30)
                            .buttonStyle(.bordered)
                            
                            Button(testList[2]){
                                searchText = testList[2]
                                searchAction(searchData: testList[2])
                            }
                            .fontWeight(.bold)
                            //                                                .font(.largeTitle)
//                            .frame(width: 100, height: 30)
                            .buttonStyle(.bordered)

                        }
                        
                    }
                    .padding(20)
                    VStack{
                        HStack(spacing:10){
                            Button(testList[3]){
                                searchText = testList[3]
                                searchAction(searchData: testList[3])
                            }
                            .fontWeight(.bold)
                            //                                                .font(.largeTitle)
//                            .frame(width: 100, height: 30)
                            .buttonStyle(.bordered)

                            Button(testList[4]){
                                searchText = testList[4]
                                searchAction(searchData: testList[4])
                            }
                            .fontWeight(.bold)
                            //                                                .font(.largeTitle)
//                            .frame(width: 100, height: 30)
                            .buttonStyle(.bordered)

                            Button(testList[5]){
                                searchText = testList[5]
                                searchAction(searchData: testList[5])
                            }
                            .fontWeight(.bold)
                            //                                                .font(.largeTitle)
//                            .frame(width: 100, height: 30)
                            .buttonStyle(.bordered)

                        }
                    }
                    
                }
            
        }
    }
    // searchAction이 들어갈 함수
    func searchAction(searchData: String){
        showDetail = true // navigation할 변수를 true로 바꿨을 때 navigationLink가 작동시키게 할 것.
    }
}
//
//#Preview {
//    HomeView(searchText: <#String#>)
//}
