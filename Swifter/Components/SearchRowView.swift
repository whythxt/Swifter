//
//  SearchRowView.swift
//  TwitterClone
//
//  Created by Yurii on 03.08.2022.
//

import SwiftUI

struct SearchRowView: View {
    var body: some View {
        HStack {
            Circle()
                .frame(width: 36, height: 36)
            
            VStack(alignment: .leading) {
                Text("whythat")
                    .font(.headline)
                
                Text("@whythxt")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct SearchRowView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRowView()
    }
}
