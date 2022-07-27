//
//  DetailView.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 26/7/22.
//

import SwiftUI

struct DetailView: View {
    
    private struct Constants {
        static let fontTitle = Font.custom("Muli-Bold", size: 20)
        static let fontBody = Font.custom("Muli-Light", size: 13)
    }
    
    @Binding var data: (name: String, time: String, type: String)
    var close: () -> Void
    
    var body: some View {
        Button {
            close()
        } label: {
            VStack(spacing: 0) {
                Spacer()
                VStack(alignment: .center, spacing: 0) {
                    Text(data.type)
                        .font(Constants.fontTitle)
                        .padding(.all, 20)
                        .foregroundColor(Color.black)
                    Text("Name: \(data.name)")
                        .font(Constants.fontBody)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 5, trailing: 20))
                        .foregroundColor(Color.black)
                    Text("Estimate: \(data.time)")
                        .font(Constants.fontBody)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                        .foregroundColor(Color.black)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.all, 30)
                .shadow(radius: 10)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Blur(style: .regular))
        }.buttonStyle(PlainButtonStyle())

    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(data: .constant((name: "Jona", time: "Hoy", type: "Stop"))) {}
    }
}
