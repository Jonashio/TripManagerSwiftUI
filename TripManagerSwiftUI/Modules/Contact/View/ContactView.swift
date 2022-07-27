//
//  ContactView.swift
//  TripManagerSwiftUI
//
//  Created by Jonashio on 26/7/22.
//

import SwiftUI

struct ContactView: View {
    
    private struct Constants {
        static let fontTitle = Font.custom("Muli-Bold", size: 20)
        static let fontBody = Font.custom("Muli-Light", size: 13)
    }
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @Environment(\.managedObjectContext) private var moc
    @ObservedObject var viewModel = ContactViewModel()
    
    var body: some View {
        ZStack() {
            VStack(spacing: 0) {
                Form {
                    Section(header: Text("Contact (\(viewModel.getNumberSaved(context: moc)) saved)").padding(.top,20)) {
                        TextField("Name", text: $viewModel.name)
                            .textContentType(.name)
                        
                        TextField("Surname", text: $viewModel.surname)
                            .textContentType(.name)
                        
                        TextField("Mail", text: $viewModel.email)
                            .textContentType(.emailAddress)
                        
                        TextField("Phone(optional)", text: $viewModel.phone)
                            .textContentType(.telephoneNumber)
                        
                        TextField("Comments", text: $viewModel.comments)
                            .disableAutocorrection(true)
                            .multilineTextAlignment(.leading)
                            .lineLimit(0)
                            .frame(height: 200)
                            .truncationMode(.tail)
                        
                        HStack {
                            Button(action: {
                                if viewModel.saveAndNotify(context: moc) {
                                    viewControllerHolder?.dismiss(animated: true)
                                }
                            }) {
                                Text("Send")
                            }.buttonStyle(PlainButtonStyle())
                            
                            Spacer()
                            Button(action: {
                                viewControllerHolder?.dismiss(animated: true)
                            }) {
                                Text("Cancel")
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color.gray)
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
