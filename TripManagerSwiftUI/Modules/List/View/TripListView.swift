//
//  TripListView.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import SwiftUI
import MapKit

struct TripListView: View {
    
    @ObservedObject var viewModel: TripListViewModel = TripListViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Map(coordinateRegion: $viewModel.coordinateRegion)
                    .frame(maxWidth: .infinity, maxHeight: 350)
                
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        ForEach($viewModel.list, id: \.id) { trip in
                            TripListViewCell(model: trip
                            ) { model in
                                print("Jonas estas pirntando la lista")
                            }
                            
                            Divider()
                        }
                    }.frame(maxWidth: .infinity)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            viewModel.fetch() { response in
                print("Jona pintamos: \(response)")
            }
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView()
    }
}
