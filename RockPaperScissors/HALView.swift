//
//  HALView.swift
//  RockPaperScissors
//
//  Created by William Mead on 18/06/2022.
//

import SwiftUI

struct HALView: View {
    var body: some View {
        Circle()
            .fill(
                RadialGradient(colors: [.yellow, .red, .black], center: .center, startRadius: 10, endRadius: 110)
            )
            .overlay(
                Circle()
                    .stroke(
                        LinearGradient(colors: [.black, .gray], startPoint: .bottom, endPoint: .top),
                        lineWidth: 20
                    )
            )
            .shadow(radius: 10)
            .frame(width: 250, height: 250, alignment: .center)
            .padding()
    }
}

struct HALView_Previews: PreviewProvider {
    static var previews: some View {
        HALView()
    }
}
