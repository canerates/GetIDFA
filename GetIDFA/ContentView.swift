//
//  ContentView.swift
//  GetIDFA
//
//  Created by Caner Ates on 22.05.2024.
//

import SwiftUI
import AdSupport
import AppTrackingTransparency

struct ContentView: View {
    @State var idfa: UUID!
    @State var text: String = "..."
    @State var copyButtonText = "Copy IDFA"
    var body: some View {
        VStack {
            
            Image("Logo")
                .resizable()
                .frame(width: 200, height: 200)
            
            VStack {
                
                Text("IDFA Number")
                    .foregroundStyle(Color.black)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(height: 50)
                    .padding(.bottom, 10)
                
                
                Text("\(text)")
                    .foregroundStyle(Color.black)
                    .padding(.horizontal, 30)
                    .frame(height: 50)
                
            }
            .frame(height: 100)
            
            Spacer()
            
            HStack {
                Button {
                    idfa =  ASIdentifierManager.shared().advertisingIdentifier
                    text = idfa.uuidString
                } label: {
                    Text("Get IDFA")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .frame(width: 100)
                        .padding(14)
                        .background(Color.blue)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.5), radius: 1, x: 0, y: 3)
                }
                
                Button {
                    UIPasteboard.general.string = text
                    self.copyButtonText = "Coppied.."
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.copyButtonText = "Copy IDFA"
                    }
                } label: {
                    Text("\(copyButtonText)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.white)
                        .frame(width: 100)
                        .padding(14)
                        .background(Color.orange)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.5), radius: 1, x: 0, y: 3)
                }
                .opacity(idfa != nil ? 1 : 0.5)
                .disabled(idfa == nil)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in })
        }
    }
}

#Preview {
    ContentView()
}
