//
//  TitleView.swift
//  voiceMemo
//
//  Created by Terry on 2023/10/12.
//

import SwiftUI

struct TitleView: View {
    var title: String

    init(
        title: String = ""
    ) {
        self.title = title
    }

    var body: some View {
        Text(title)
            
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
