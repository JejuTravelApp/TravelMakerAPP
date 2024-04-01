//
//  RecordDatePickerView.swift
//  TravelMakerAPP
//
//  Created by 정태영 on 4/1/24.
//

import SwiftUI

struct RecordStartDatePickerView: View {
    
    @Binding var selectedStartDate: Date
    
    // 날짜 범위로 현재날짜 이전은 선택 못하게할려면 Date()...을 in에 써주면됨
    var dateRange: ClosedRange<Date> {
       let min = Calendar.current.date(
         byAdding: .year,
         value: -10,
         to: selectedStartDate
       )!
       let max = Calendar.current.date(
         byAdding: .year,
         value: 10,
         to: selectedStartDate
       )!
       return min...max
     }

    var body: some View {
            VStack {
                DatePicker("", selection: $selectedStartDate, in: dateRange, displayedComponents: [.date])
                    .labelsHidden()
                    .datePickerStyle(.graphical) // 픽커 스타일
                    .padding()
                Text("\(selectedStartDate, formatter: dateFormatter)")
            }

    }
    // --- Functions ---
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

} // End

//#Preview {
//    RecordDatePickerView()
//}
