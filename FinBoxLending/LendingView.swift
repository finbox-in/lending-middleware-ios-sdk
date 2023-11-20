//
//  LendingView.swift
//  FinBoxLending
//
//  Created by Ashutosh Jena on 20/11/23.
//

import SwiftUI

public struct LendingView: View {
    
    public init() {
        
    }
    
    public var body: some View {
        VStack {
            FinBoxWebView(urlString: "https://lendingwebuat.finbox.in/session/ea5dcb68-15e4-42af-b69b-e35971dc7857?hidePoweredBy=false")
        }
    }
    
    struct LendingView_Previews: PreviewProvider {
        static var previews: some View {
            LendingView()
        }
    }
}
