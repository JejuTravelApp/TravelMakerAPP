//
//  SearchBar.swift
//  TravelMakerAPP
//
//  Created by ms k on 3/21/24.
//

import SwiftUI

//struct AISearchBar: UIViewRepresentable {
struct AISearchBar : View {
    
 
    @Binding var text : String
    @FocusState var isTextFieldFocused : Bool
    
    @State var showDetail : Bool = false
    
    private let alertText : String = "두 글자 이상 입력해주세요."
    
    
//    func makeUIView(context: Context) -> UISearchBar {
//        
//        let searchBar = UISearchBar()
//        
//        searchBar.searchBarStyle = .prominent
//        searchBar.autocapitalizationType = .none
//        searchBar.placeholder = "검색어를 입력하세요"
//        
//        
//        return searchBar
//    }
//    
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//        
//        uiView.text = text
//        
//    }
    
//SEARCH BAR (SQLITE스타일) START
    var body: some View{
        HStack{
            TextField("검색어를 입력하세요", text: $text)
                .frame(width: 250, height: 50)
                .padding(.horizontal, 8)
                .background(Color.gray.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                .keyboardType(.default)
                .autocorrectionDisabled()//자동수정방지
                .textInputAutocapitalization(.never)//자동첫글자대문자 방지
                .focused($isTextFieldFocused)
                .overlay(
                        
                        HStack{
                            
                            
                            Button(
                                action: {
                                    // searchText가 비어있는지 확인.
                                    _ = text.trimmingCharacters(in: .whitespacesAndNewlines)
                                    if (!text.isEmpty){
                                        showDetail = true
                                    }
                                    
                                })
                            {
                                Image(systemName: "magnifyingglass")
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 8)
                            }
                            //                                    .fullScreenCover(isPresented: $shosDetail){
                            .sheet(isPresented: $showDetail){
                                DetailView(searchText: text)
                            }
                            if isTextFieldFocused{
                                //cancel button 표시
                                Button(action: {
                                    text = ""
                                    isTextFieldFocused = false
                                }){
                                    Image(systemName: "multiply.circle.fill")//x모양 버튼
                                        .foregroundStyle(Color.gray)
                                        .padding(.trailing)
                                }
                            }else{//텍스트 필드 바깥을 터치했을 때
                                //키보드 숨기기 기능 만들기
                            }

                        }
                )//overlay
        }
        //SEARCH BAR (SQLITE스타일) END
    }
//Function
//    func textUnder2words() {
//        if text.count < 2{
//            Alert(title: Text(""), message : Text(alertText))
//            
//        }
//    }
    
}
