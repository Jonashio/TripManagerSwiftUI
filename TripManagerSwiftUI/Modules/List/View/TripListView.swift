//
//  TripListView.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 24/7/22.
//

import SwiftUI
import UIKit
import MapKit

struct TripListView: View {
    
    private struct Constants {
        static let fontTitle = Font.custom("Muli-Bold", size: 25)
    }
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @ObservedObject var viewModel: TripListViewModel = TripListViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                MapView(routesLocation: $viewModel.routesLocation, needRefresh: $viewModel.needMapRefresh) { idx in
                    viewModel.loadDetailView(idx)
                }.frame(maxWidth: .infinity, maxHeight: 350)
                
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        Text("Trips list")
                            .font(Constants.fontTitle)
                            .padding()
                        buildList()
                    }.frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.bottom, 30)
            }
            
            buildButtonContactUs()
            buildDetail()
            buildStateBuildEvents()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.fetch()
        }
    }
    
    // swiftlint:disable empty_count
    private func buildList() -> some View {
        VStack {
            if $viewModel.list.count > 0 {
                ForEach(0..<viewModel.list.count, id: \.self) { idx in
                    TripListViewCell(model: $viewModel.list[idx], selected: viewModel.selectedIndex == idx) {
                        viewModel.generateRouteInMap(idx)
                    }
                    Divider()
                }
            }
        }
    }
    
    private func buildDetail() -> some View {
        VStack {
            if !viewModel.detailData.name.isEmpty {
                DetailView(data: $viewModel.detailData, close: viewModel.closeDetail())
            }
        }
    }
    
    private func buildStateBuildEvents() -> some View {
        VStack {
            switch viewModel.stateEvents {
            case .loading:
                LoadingView()
            case .error:
                ErrorView(close: viewModel.closeError())
            case .normal:
                EmptyView()
            }
        }
    }
    private func buildButtonContactUs() -> some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    gotoContactUs()
                } label: {
                    Image("contact")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .buttonStyle(PlainButtonStyle())
                .tag("ContactUs")

            }
            Spacer()
        }.padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 30))
    }
    
    private func gotoContactUs() {
        self.viewControllerHolder?.present(style: .pageSheet, builder: {
            ContactView().environment(\.managedObjectContext, CoreDataStack.context)
        })
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView()
    }
}
