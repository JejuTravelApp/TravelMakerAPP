//
//  MapView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 3/14/24.
//  Description: 제주도의 지도를 검색하고 조회하는 뷰

import SwiftUI
import MapKit
import CoreLocation

@available(iOS 15.0, *)
struct MapView: View {
    
    // @@ === Map Field === @@
    // 맵의 초기 띄워줄 위도, 경도, 줌을 설정하는 position으로 제주도 가운데인 한라산 봉우리를 기본값으로 찍어놓음
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.361722862714, longitude: 126.53366495424248),
        span: MKCoordinateSpan(latitudeDelta: 0.6, longitudeDelta: 0.6)
    ))
    @State private var selectedResult: MKMapItem? // 선택된 마커를 알고있을 변수
    @State var touristResult: [TouristDataModel] = [] // 관광지, 쇼핑 검색 결과
    @State var restaurantResult: [RestaurantDataModel] = [] // 식당 검색 결과
    @State var toiletResult: [ToiletDataModel] = [] // 화장실 검색 결과
    
    // @@ === View Field === @@
    @State private var searchText: String = "" // 검색 텍스트필드
    @State private var showActionButtons = false
    @State private var showMenu = false
    @FocusState private var isTextFieldFocused: Bool // FocusState를 부모 뷰에서 관리
    @Namespace var mapScope
    
    // @@ === BottomSheet Field === @@
    @State private var showTourSheet: Bool = false // sheet status
    @State private var showFoodSheet: Bool = false // sheet status
    @State private var showToiletSheet: Bool = false // sheet status
    @State private var sheetSize: CGFloat = UIScreen.main.bounds.height * 0.38 // 기본 sheet사이즈
    @State var selectedDetentIdentifier: UISheetPresentationController.Detent.Identifier? = .medium // 기본 sheet사이즈
    
    // 식당
    @State private var selectedFoodTitle: String = "" // 선택된 마커 이름을 담을 변수
    @State private var selectedFoodCategory: String = "" // 카테고리 담을 변수
    @State private var selectedFoodImages: String = "" // 선택된 마커가 가진 이미지를 담을 변수
    // 관광지
    @State private var selectedTourTitle: String = "" // 선택된 마커 이름을 담을 변수
    @State private var selectedTourImages: String = ""
    @State private var selectedTourCategory: String = ""
    @State private var selectedTourIntro: String = ""
    @State private var selectedTourAddress: String = ""
    @State private var selectedTourPhone: String = ""
    @State private var selectedTourTag: String = ""
    
    
    // 화장실
    @State private var selectedToiletTitle: String = "" // 선택된 마커 이름을 담을 변수
    @State private var selectedToiletAddress: String = "" // 주소
    @State private var selectedToiletCount1: Int = 0 // 남성용 장애인 대변기수
    @State private var selectedToiletCount2: Int = 0 // 남성용 장애인 소변기수
    @State private var selectedToiletCount3: Int = 0 // 여성용 장애인 대변기수
    @State private var selectedToiletTime: String = "" // 화장실 개방시간
    @State private var selectedToiletIsBell: String = "" // 비상벨 유무
    @State private var selectedToiletBellSpot: String = "" // 비상벨 장소
    @State private var selectedToiletIsBaby: String = "" // 귀저기교환대장소 유무
    @State private var selectedToiletBabySpot: String = "" // 귀저기교환대장소
    
    
    // @@ === Constructor === @@
    var data = MapDataLoad() // json데이터 불러오기 및 검색기능이 있는 class 생성자 연돈
    @ObservedObject var userLocationManager = UserLocationManager() // 유저 위치 가져오기 및 권한
    
    
    var body: some View {
        ZStack {
            Map(position: $position, selection: $selectedResult, scope: mapScope) {
                
                // 유저의 위치를 찍어주기위한 파란점 찍기
                UserAnnotation()
                
                
                // 내가 찜한 장소 어노테이션
                
                
                // 관광지 어노테이션
                ForEach(touristResult, id: \.self) {  tour in
                    Annotation(tour.title, coordinate: CLLocationCoordinate2D(latitude: tour.latitude, longitude: tour.longitude)) {
                        ZStack {
                            if tour.category == "관광지"  && !tour.tag.contains("반려동물"){
                                AnnotationShape(imageName: "flag.circle.fill", imageBackColor: Color.green, imageForeColor: Color.white)
                            } else if tour.category == "쇼핑" {
                                AnnotationShape(imageName: "bag.circle.fill", imageBackColor: Color.orange, imageForeColor: Color.white)
                            } else {
                                AnnotationShape(imageName: "dog.circle.fill", imageBackColor: Color.brown, imageForeColor: Color.white)
                            }
                            
                        }
                        .onTapGesture {
                            // 선택된 어노테이션의 위치로 MapCamera 조절
                            updatePosition(latitude: tour.latitude, longitude: tour.longitude, latitudeDelta: 0.03, longitudeDelta: 0.03)
                            
                            selectedTourTitle = tour.title
                            selectedTourCategory = tour.category
                            selectedTourAddress = tour.roadaddress
                            selectedTourImages = tour.imgpath
                            selectedTourIntro = tour.introduction
                            selectedTourTag = tour.tag
                            
                            if !showTourSheet {
                                showTourSheet = true
                            }

                        }
                    }
                }
                
                
                // 음식점 어노테이션
                ForEach(restaurantResult, id: \.self) {  restaurant in
                    Annotation(restaurant.사업장명, coordinate: CLLocationCoordinate2D(latitude: Double(restaurant.lat) ?? 37.5665, longitude: Double(restaurant.lng) ?? 126.9780)) {
                            AnnotationShape(imageName: "fork.knife.circle.fill", imageBackColor: Color.orange, imageForeColor: Color.white)
                        .onTapGesture { // 마커 클릭시 이벤트
                            //                            DispatchQueue.main.async {
                            // 선택된 어노테이션의 위치로 MapCamera 조절
                            updatePosition(latitude: Double(restaurant.lat), longitude: Double(restaurant.lng), latitudeDelta: 0.03, longitudeDelta: 0.03)
                            
                            selectedFoodTitle = restaurant.사업장명
                            selectedFoodImages = restaurant.images // 이미지 상태 업데이트
                            selectedFoodCategory = restaurant.foodCategory
                            
                            if !showFoodSheet {
                                showFoodSheet = true
                            }
                            
                        }
                    }
                    
                    
                }
                
                
                // 화장실 어노테이션
                ForEach(toiletResult, id: \.self) {  toilet in
                    Annotation(toilet.화장실명, coordinate: CLLocationCoordinate2D(latitude: Double(toilet.WGS84위도) ?? 37.5665, longitude: Double(toilet.WGS84경도) ?? 126.9780)) {
                        AnnotationShape(imageName: "toilet.circle.fill", imageBackColor: Color.indigo, imageForeColor: Color.white)
                            .onTapGesture { // 마커 클릭시 이벤트
                                
                                DispatchQueue.main.async {
                                    // 선택된 어노테이션의 위치로 MapCamera 조절
                                    updatePosition(latitude: Double(toilet.WGS84위도), longitude: Double(toilet.WGS84경도), latitudeDelta: 0.03, longitudeDelta: 0.03)
                                    
                                    selectedToiletTitle = toilet.화장실명
                                    selectedToiletAddress = toilet.소재지도로명주소
                                    selectedToiletCount1 = toilet.남성용_장애인용대변기수
                                    selectedToiletCount2 = toilet.남성용_장애인용소변기수
                                    selectedToiletCount3 = toilet.여성용_장애인용대변기수
                                    selectedToiletTime = toilet.개방시간상세
                                    selectedToiletIsBell = toilet.비상벨설치여부
                                    selectedToiletBellSpot = toilet.비상벨설치장소
                                    selectedToiletIsBaby = toilet.기저귀교환대유무
                                    selectedToiletBabySpot = toilet.기저귀교환대장소
                                    
                                    if !showToiletSheet {
                                        showToiletSheet = true
                                    }
                                    
                                }
                            }
                    }
                }
                
                
            }
            .mapStyle(.standard(elevation: .realistic)) // 맵 스타일 유형 옵션 (.standard, .imagery, .hybrid)
            //            .mapControls() { // AppleMap 기본 버튼 생성
            //                MapControllView()
            //            }
            //            .padding(EdgeInsets(top: 45, leading: 0, bottom: 0, trailing: 0))
            
            
            
            // 맵 위에 서치바, 카테고리 버튼들이 있는 VStack
            VStack (alignment: .leading) {
                HStack{
                    MapSearchBarView(searchText: $searchText, isTextFieldFocused: _isTextFieldFocused, restaurantResult: $restaurantResult, touristResult: $touristResult, toiletResult: $toiletResult)
                        .shadow(radius: 5)
                        .onTapGesture {
                            isTextFieldFocused = true
                        }
                    
                    Spacer()
                    
                    Button(action: {
                        position = .userLocation(fallback: .automatic)
                    }, label: {
                        Image(systemName: "location")
                            .resizable()
                            .frame(width: 26, height: 26, alignment: .center)
                            .padding()
                    })
                    .frame(width: 38, height: 38, alignment: .center)
                    .background(.white)
                    .cornerRadius(5)
                    .shadow(radius: 3)
                    
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                
                
                // 나중에 struct로 따로 분리할 필요가 있음
                // 음식점 버튼
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button(action: {
                            toiletResult = []
                            touristResult = []
                            restaurantResult = []
                            updatePosition() // 카메라 초기화
                            
                            if let results = data.searchData(searchText: "연돈", filename: "제주도식당_지도Data", type: RestaurantDataModel.self) {
                                restaurantResult.append(contentsOf: results)  // 배열에 다른 배열의 내용을 추가
                            }
                            
                        }) {
                            HStack(spacing: 5) {
                                Image(systemName: "fork.knife")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(Color.orange)
                                Text("음식점")
                                    .bold()
                                    .font(.system(size: 13))
                                    .foregroundStyle(Color.black)
                            }
                            .frame(alignment: .center)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .padding(5)
                        .shadow(radius: 3)
                        
                        
                        // 반려동물 버튼
                        Button(action: {
                            toiletResult = []
                            touristResult = []
                            restaurantResult = []
                            updatePosition() // 카메라 초기화
                            
                            if let results = data.searchAnimalData() {
                                touristResult.append(contentsOf: results)
                            }
                        }) {
                            HStack(spacing: 5) {
                                Image(systemName: "dog")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(Color.brown)
                                Text("반려동물")
                                    .bold()
                                    .font(.system(size: 13))
                                    .foregroundStyle(Color.black)
                            }
                            .frame(alignment: .center)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .padding(5)
                        .shadow(radius: 3)
                        
                        
                        // 화장실 버튼
                        Button(action: {
                            toiletResult = []
                            touristResult = []
                            restaurantResult = []
                            updatePosition() // 카메라 초기화
                            
                            if let results = data.searchToilets() {
                                toiletResult.append(contentsOf: results)  // 배열에 다른 배열의 내용을 추가
                            }
                        }) {
                            HStack(spacing: 5) { // 내부 요소 간 간격 조정
                                Image(systemName: "figure.dress.line.vertical.figure")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(Color.indigo)
                                Text("화장실")
                                    .bold()
                                    .font(.system(size: 13))
                                    .foregroundStyle(Color.black)
                            }
                            .frame(alignment: .center)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                        }
                        .background(.white)
                        .cornerRadius(10)
                        .padding(5)
                        .shadow(radius: 3)
                        
                    }
                    .padding(.leading, 15)
                    
                }
                Spacer()
            }
            
        }
        .onTapGesture {
            isTextFieldFocused = false
        }
        .detentSheet(isPresented: $showTourSheet, prefersGrabberVisible: true) {
            TourSheet(title: $selectedTourTitle, category: $selectedTourCategory, address: $selectedTourAddress, images: $selectedTourImages, intro: $selectedTourIntro, phone: $selectedTourPhone, tag: $selectedTourTag)
        }
        .edgesIgnoringSafeArea(.all) // 얘가 있어야지 Map의 영역이 짤리지 않게됨
        .detentSheet(isPresented: $showFoodSheet, prefersGrabberVisible: true) {
            RestaurantSheetView(title: $selectedFoodTitle, category: $selectedFoodCategory, images: $selectedFoodImages)
        }
        .edgesIgnoringSafeArea(.all) // 얘가 있어야지 Map의 영역이 짤리지 않게됨
        .detentSheet(isPresented: $showToiletSheet, prefersGrabberVisible: true, detents: [.medium()]) {
            //            sheetCompo.showDivider()
            ToiletSheet(title: $selectedToiletTitle, address: $selectedToiletAddress, toiletCount1: $selectedToiletCount1, toiletCount2: $selectedToiletCount2, toiletCount3: $selectedToiletCount3, time: $selectedToiletTime, isBell: $selectedToiletIsBell, bellSpot: $selectedToiletBellSpot, isBaby: $selectedToiletIsBaby, babySpot: $selectedToiletBabySpot)
        }
        .edgesIgnoringSafeArea(.all) // 얘가 있어야지 Map의 영역이 짤리지 않게됨
        .onDisappear {
            DispatchQueue.main.async {
                showTourSheet = false
                showFoodSheet = false
                showToiletSheet = false
            }
        }
        
        
        
        
        
        
    }
    // --- Functions ---
    
    // 카메라 포지션을 업데이트 해주기 (아무것도 인자로 받지 않으면 초기화됨)
    func updatePosition(latitude: Double? = 33.361722862714, longitude: Double? = 126.53366495424248, latitudeDelta: Double? = 0.6, longitudeDelta: Double? = 0.6) {
        let newRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude ?? 33.361722862714,
                                           longitude: longitude ?? 126.53366495424248),
            span: MKCoordinateSpan(latitudeDelta: latitudeDelta ?? 0.6,
                                   longitudeDelta: longitudeDelta ?? 0.6)
        )
        position = .region(newRegion)
    }
    
} // End

// Annotation을 형성하는 struct로 .fill로된 image로 해줘야 이쁨
struct AnnotationShape: View {
    
    @State var imageName: String
    @State var imageBackColor: Color
    @State var imageForeColor: Color
    
    var body: some View {
        LazyVStack(spacing: 0) { // View를 느리게 스캔해서 필요한 것만 로드되기 때문에 퍼포먼스 좋아짐
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .font(.headline)
                .foregroundColor(imageForeColor)
                .padding(5)
                .background(imageBackColor)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(imageBackColor)
                .frame(width: 8, height: 8)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
        }
        
    }
}


//#Preview {
//    MapView()
//}
//
