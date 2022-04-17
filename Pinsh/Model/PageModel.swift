//
//  PageModel.swift
//  Pinsh
//
//  Created by Zeyad Badawy on 16/04/2022.
//

import Foundation

struct Page: Identifiable {
    let id : Int
    let imageName: String
    
}

extension Page {
    var thumpnailName:String {
        return "thumb-" + imageName
    }
}
