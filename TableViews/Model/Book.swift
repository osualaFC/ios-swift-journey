//
//  Book.swift
//  TableViews
//
//  Created by fredrick osuala on 17/04/2021.
//

import UIKit

struct Book {
    let title : String
    let author : String
    var image : UIImage {
        Library.loadImage(forBook: self) ??
        LibrarySymbol.letterSquare(letter: title.first).image
    }
}
