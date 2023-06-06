//
//  ContentView.swift
//  animationMalown
//
//  Created by Marine Michelot on 05/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    
    // MARK:- variables
    let circleTrackGradient = LinearGradient(gradient: .init(colors: [Color.darkPurple, Color.darkPurple]), startPoint: .leading, endPoint: .bottomLeading)
    let circleRoundGradient = LinearGradient(gradient: .init(colors: [Color.pinkDark, Color.darkPurple]), startPoint: .topLeading, endPoint: .trailing)
    
    let trackerRotation: Double = 2
    let animationDuration: Double = 0.75
    
    @State var isAnimating: Bool = false
    @State var circleStart: CGFloat = 0.17
    @State var circleEnd: CGFloat = 0.325
    
    @State var rotationDegree: Angle = Angle.degrees(0)
    
     // MARK:- views
    var body: some View {
        ZStack {
            Color.eerieBlack
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 40))
                    .fill(circleTrackGradient)
                Text("Welcome in Mal0wn's Github")
                    .font(.system(size: 36, weight: .heavy, design: .rounded))
                    .frame(width: 250)
                    .foregroundColor(Color.pinkDark)
                    .multilineTextAlignment(.center)
                Circle()
                    .trim(from: circleStart, to: circleEnd)
                    .stroke(style: StrokeStyle(lineWidth: 30, lineCap: .round))
                    .fill(circleRoundGradient)
                    .rotationEffect(self.rotationDegree)
            }.frame(width: 400, height: 300)
            .onAppear() {
                self.animateLoader()
                Timer.scheduledTimer(withTimeInterval: self.trackerRotation * self.animationDuration + (self.animationDuration), repeats: true) { (mainTimer) in
                    self.animateLoader()
                }
            }
        }
    }
    
    // MARK:- functions
    func getRotationAngle() -> Angle {
        return .degrees(360 * self.trackerRotation) + .degrees(120)
    }
    
    func animateLoader() {
        withAnimation(Animation.spring(response: animationDuration * 2 )) {
            self.rotationDegree = .degrees(-57.5)
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
            withAnimation(Animation.easeInOut(duration: self.trackerRotation * self.animationDuration)) {
                self.rotationDegree += self.getRotationAngle()
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration * 1.25, repeats: false) { _ in
            withAnimation(Animation.easeOut(duration: (self.trackerRotation * self.animationDuration) / 2.25 )) {
                self.circleEnd = 0.925
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: trackerRotation * animationDuration, repeats: false) { _ in
            self.rotationDegree = .degrees(47.5)
            withAnimation(Animation.easeOut(duration: self.animationDuration)) {
                self.circleEnd = 0.325
            }
        }
    }
}

struct CircleLoader_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
