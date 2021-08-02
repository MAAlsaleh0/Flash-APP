//
//  ContentView.swift
//  Flash
//
//  Created by Mohammed Alsaleh on 23/12/1442 AH.
//
import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var ISON = false
    @State var onn = false
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.1254901961, green: 0.1215686275, blue: 0.1254901961, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            VStack{
                RoundedRectangle(cornerRadius: 50)
                    
                    //                .stroke(Color.white, lineWidth: 2)
                    .foregroundColor(Color(#colorLiteral(red: 0.1254901961, green: 0.1215686275, blue: 0.1254901961, alpha: 1)))
                    
                    .frame(width: 120, height: 250)
                    .overlay(RoundedRectangle(cornerRadius: 50)
                                .foregroundColor(ISON ? .green : .red).frame(width: 120, height: 150),alignment: ISON ? .bottom : .top)
                    .overlay(Text(ISON ? "is ON" : "is OFF")
                                .bold().foregroundColor(ISON ? .green : .red).frame(width: 120, height: 150),alignment: ISON ? .top : .bottom)
                    .animation(.easeIn)
                    .background(RoundedRectangle(cornerRadius: 50).shadow(radius: 15))
            }.onTapGesture {
                ISON.toggle()
                onn.toggle()
                toggleFlash()
                
            }.frame(width: 200, height: 290).cornerRadius(50)
        }.preferredColorScheme(.light)
    }
    
    func toggleFlash() {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            
            device.torchMode = onn ? .on : .off
            if onn {
                try device.setTorchModeOn(level: AVCaptureDevice.maxAvailableTorchLevel)
            }
            
            device.unlockForConfiguration()
        } catch {
            print("Error: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 12 Pro")
    }
}

