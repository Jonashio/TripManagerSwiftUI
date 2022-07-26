//
//  ErrorView.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 26/7/22.
//

import SwiftUI

struct ErrorView: View {
    
    private struct Constants {
        static let fontTitle = Font.custom("Muli-Bold", size: 30)
    }
    
    var close: () -> Void
    
    var body: some View {
        Button {
            close()
        } label: {
            VStack(spacing: 0) {
                Spacer()
                VStack(alignment: .center,spacing: 0) {
                    Text("An error has occurred")
                        .font(Constants.fontTitle)
                        .padding(.all, 20)
                        .foregroundColor(Color.black)
                        .shadow(color: Color.white, radius: 5, x: 1, y: 1)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(20)
                .padding(.all, 30)
                .shadow(radius: 10)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(hex: "000000", alpha: 0.5))
        }.buttonStyle(PlainButtonStyle())

    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView() {}
    }
}

