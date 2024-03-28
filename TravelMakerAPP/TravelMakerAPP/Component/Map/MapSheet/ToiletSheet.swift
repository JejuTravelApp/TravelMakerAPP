//
//  ToiletSheet.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/17/24.
//  Description: 화장실 Annotation 클릭시 나오는 sheet

import SwiftUI
import UniformTypeIdentifiers // 텍스트 복사를 위해

struct ToiletSheet: View {
    
    @Binding var title: String
    @Binding var address: String
    @Binding var toiletCount1: Int // 남성용 장애인 대변기수
    @Binding var toiletCount2: Int // 남성용 장애인 소변기수
    @Binding var toiletCount3: Int // 여성용 장애인 대변기수
    @Binding var time: String
    @Binding var isBell: String
    @Binding var bellSpot: String
    @Binding var isBaby: String
    @Binding var babySpot: String
    @State private var isCopied: Bool = false // 복사될때 알림을 띄우기용
    
    var body: some View {
        ZStack {
//            Divider()
//                .frame(width: UIScreen.main.bounds.height * 0.1, height: 2, alignment: .center)
//                .padding(.horizontal, 10)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 27))
                    .bold()
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
                HStack {
                    Text(address == "x" ? "주소정보 없음" : address)
                        .font(.system(size: 15))
                        .foregroundStyle(Color.gray)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 5))
                    
                    Button {
                        let pasteboard = UIPasteboard.general
                        pasteboard.string = address
                        if pasteboard.string != nil{
                            withAnimation {
                                isCopied = true
                            }
                            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1.5) {
                                withAnimation {
                                    isCopied = false
                                }
                            }
                        }
                    } label: {
                        // 버튼 레이블에 조건을 줄려면 Group을 사용해야함
                        Group {
                            if address != "x" {
                                Image(systemName: "clipboard")
                                    .resizable()
                                    .frame(width: 10, height: 15)
                                    .foregroundColor(Color.gray)
                            } else {
                                EmptyView()
                            }
                        }
                    }
                    .padding(.bottom, 10)
                }
                
                Divider()
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                
                toiletStr(iconName: "clock", iconColor: Color.black, titleName: "개방시간: ", detail: time)
                toiletStr(iconName: "face.smiling", iconColor: Color.yellow, titleName: "귀저기 교환대: ", detail: isBaby == "Y" ? babySpot : "없음")
                toiletStr(iconName: "light.beacon.max", iconColor: Color.orange, titleName: "비상벨: ", detail: isBell == "Y" ? bellSpot : "없음")
                toiletStr(iconName: "figure.roll", iconColor: Color.blue, titleName: "남성용 장애인 소변기수: ", detail: toiletCount2 == 0 ? "없음" : "\(toiletCount2)개")
                toiletStr(iconName: "figure.roll", iconColor: Color.blue, titleName: "남성용 장애인 대변기수: ", detail: toiletCount1 == 0 ? "없음" : "\(toiletCount1)개")
                toiletStr(iconName: "figure.roll", iconColor: Color.red, titleName: "여성용 장애인 대변기수: ", detail: toiletCount3 == 0 ? "없음" : "\(toiletCount3)개")
                
                Spacer()
                
            }
            
            if isCopied {
                VStack(alignment: .center) {
                    Spacer()
                    Text("클립보드에 복사되었습니다!")
                        .foregroundColor(.white)
                        .bold()
                        .font(.footnote)
                        .frame(width: 180, height: 35)
                        .background(Color.gray.cornerRadius(7))
                        .padding(.bottom, 10)
                }
            }
            
            
            
        }
    }
} // End

// 화장실 바텀시트 디테일 정보 struct
struct toiletStr: View {
    
    @State var iconName: String
    @State var iconColor: Color
    @State var titleName: String
    @State var detail: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(iconColor)
            
            Text(titleName)
                .bold()
            
            Text(detail)
                .font(.system(size: 16))
        }
        .padding(.horizontal, 13)
        
    }
} // End
