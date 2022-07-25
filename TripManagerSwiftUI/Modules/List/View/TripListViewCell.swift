//
//  TripListViewCell.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import SwiftUI

struct TripListViewCell: View {
    
    private struct Constants {
        static let fontDestination = Font.custom("Muli", size: 16)
        static let fontBody = Font.custom("Muli", size: 13)
        static let fontTime = Font.custom("Muli", size: 11)
        static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        static let dateFormatForShowing = "yyyy/MM/dd HH:mm"
    }
    
    @Binding var model: TripModel
    var selected: Bool
    var action: ((UUID)->Void)?
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .frame(maxWidth: .infinity, maxHeight: 85)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(selected ? .cyan : .clear, lineWidth: 1))
                .cornerRadius(20)
            
            Button {
                action?(model.id)
            } label: {
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    HStack() {
                        Text("\(model.tripModelDescription ?? "Error") (\(model.stops?.count ?? 0) Stops)")
                            .font(Constants.fontDestination)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    
                    HStack(alignment: .top) {
                        VStack() {
                            Text("Status \(model.status?.rawValue ?? "Error")")
                                .font(Constants.fontBody)
                                .foregroundColor(statusColor())
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("From \(model.origin?.address ?? "Error")")
                                .font(Constants.fontBody)
                                .foregroundColor(Color.white)
                            Text("To \(model.destination?.address ?? "Error")")
                                .font(Constants.fontBody)
                                .foregroundColor(Color.white)
                        }
                        
                    }
                    .padding(.bottom, 5)
                    
                    Text("Schedule \(model.startTime?.toDate(dateFormat: Constants.dateFormat)?.toString(format: Constants.dateFormatForShowing) ?? "Error") - \(model.endTime?.toDate(dateFormat: Constants.dateFormat)?.toString(format: Constants.dateFormatForShowing) ?? "Error")")
                        .font(Constants.fontTime)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .foregroundColor(Color.white)
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 85, alignment: .center)
                .padding(EdgeInsets(top: 3, leading: 20, bottom: 10, trailing: 30))
            }.buttonStyle(PlainButtonStyle())
        }
        .background(Color.black)
        
    }
    
    func statusColor() -> Color {
        guard let status = model.status else {
            return .black
        }
        
        switch status {
        case .ongoing:
            return .orange
        case .cancelled:
            return .red
        case .scheduled:
            return .green
        case .finalized:
            return .gray
        }
    }
}

struct TripListViewCell_Previews: PreviewProvider {
    static var previews: some View {
        TripListViewCell(model: .constant(TripModel(status: nil, stops: nil, origin: nil, startTime: "2018-12-18T08:00:00.000Z", tripModelDescription: nil, endTime: "2018-12-18T09:00:00.000Z", route: nil, destination: nil, driverName: "Jona")), selected: false) {_ in 
            // nothing
        }
    }
}
