//
//  RecordAddView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/28/24.
//

import SwiftUI
import PhotosUI // <<<

struct RecordAddView: View {
    
    @State private var recordImages: [UIImage] = [] // 화면에 띄워줄 이미지가 담길 배열
    @State private var photosPickerItems: [PhotosPickerItem] = [] // 픽커에서 선택된 이미지가 담길 배열
    @State private var isPresentingPhotosPicker = false // 버튼형식의 PhotoPicker를 쓰기위한 Bool값
    @State private var titleText = "" // 여행 제목
    @FocusState private var isFocused: Bool
    
    @State private var selectedStartDate = Date()
    @State private var selectedEndDate = Date()
    @State private var isStartDateAlert = false // 여행 시작일 Alert
    @State private var isEndDateAlert = false // 여행 종료일 Alert
    
    var body: some View {
        NavigationView { // 이걸로 감싸줘야 해당 화면을 넘기고 title을 줄 수 있음
            ScrollView(.vertical) {
                VStack() {
                    if recordImages.isEmpty {
                        // 배열이 비어있을 때 기본 이미지 표시
                        VStack {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding()
                            Text("눌러서 이미지 추가")
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.7, height: 230)
                        .background(.thinMaterial)
                        .onTapGesture {
                            isPresentingPhotosPicker = true
                        }
                        // 여러개의 사진 선택이 가능한 픽커로 버튼형식임
                        // selectionBehavior: .ordered로하면 몇개 선택했는지 번호로 보여줌
                        .photosPicker(
                            isPresented: $isPresentingPhotosPicker,
                            selection: $photosPickerItems,
                            maxSelectionCount: 5,
                            selectionBehavior: .ordered,
                            matching: .images
                        )
                    } else {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(recordImages.indices, id: \.self) { i in
                                    ZStack(alignment: .topTrailing) { // alignment를 topTrailing으로 설정
                                        Image(uiImage: recordImages[i])
                                            .resizable()
                                            .frame(width: 260, height: 230)
                                        
                                        Button(action: {
                                            // 버튼을 눌렀을 때 실행될 액션: 이미지 삭제
                                            recordImages.remove(at: i)
                                        }) {
                                            Image(systemName: "x.circle.fill")
                                                .resizable()
                                                .foregroundStyle(Color.red)
                                                .frame(width: 25, height: 25)
                                                .padding(15) // 버튼이 너무 가장자리에 붙지 않도록 패딩 추가
                                        }
                                        .offset(x: 10, y: -10) // 오른쪽 상단으로 조금 더 밀어내기 위한 오프셋 조정
                                    }
                                }
                            }
                        }
                        .frame(height: 240)
                        .background(.thinMaterial)
                        .shadow(radius: 3)
                    }
                    
                    HStack {
                        Spacer()
                        Text("\(recordImages.count)/5")
                            .foregroundStyle(Color.gray)
                            .padding(.trailing, 30)
                    }
                    
                    
                    HStack {
                        Text("여행 일자")
                            .bold()
                            .padding(.horizontal, 10)
                        

                        Spacer()
                    }
                    HStack(spacing: 30) {
                        Button {
                            isStartDateAlert = true
                        } label: {
                            VStack {
                                Image(systemName: "airplane.departure")
                                    .padding(.bottom, 3)
                                Text("여행 시작일 설정")
                                    .bold()
                                    .font(.system(size: 12))
                            }
                        }
                        .alert("여행 시작일 선택", isPresented: $isStartDateAlert) {
                            RecordStartDatePickerView(selectedStartDate: $selectedStartDate)
                            Button("선택완료", role: .none) {
                                print("Action Default")
                            }
                        }


                        Button {
                            isEndDateAlert = true
                        } label: {
                            VStack {
                                Image(systemName: "airplane.arrival")
                                    .padding(.bottom, 3)
                                Text("여행 종료일 설정")
                                    .bold()
                                    .font(.system(size: 12))
                            }
                        }
                        .alert("여행 시작일 선택", isPresented: $isEndDateAlert) {
                            RecordEndDatePickerView(selectedEndDate: $selectedEndDate)
                            Button("선택완료", role: .none) {
                                print("Action Default")
                            }
                        }
                        


                    }
                    .padding()

                    HStack {
                        Text("\(selectedStartDate, formatter: dateFormatter)")
                        Text("~")
                            .padding(.horizontal, 3)
                        Text("\(selectedEndDate, formatter: dateFormatter)")
                    }
                    .padding(.bottom, 8)
                    
                    
                    
                    
                    HStack {
                        Text("여행의 제목")
                            .bold()
                            .padding(.leading, 10)
                        Spacer()
                    }
                    TextField("", text: $titleText)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        .textFieldStyle(.roundedBorder)
                        .focused($isFocused)
                    
                    
                    
                    
                    
                    Spacer()
                    
                    
                }
                .padding(30)
                .onChange(of: photosPickerItems) { _, _ in
                    Task {
                        for item in photosPickerItems {
                            if let data = try? await item.loadTransferable(type: Data.self) {
                                if let image = UIImage(data: data) {
                                    recordImages.append(image)
                                }
                            }
                        }
                        photosPickerItems.removeAll() // 초기화
                    }
                    
                }
            }
            
            
        }
        .navigationBarTitle("기록 생성", displayMode: .inline) // VStack에 BarTitle이 붙음
    }
    // --- Functions ---
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
} // End

//#Preview {
//    RecordAddView()
//}
