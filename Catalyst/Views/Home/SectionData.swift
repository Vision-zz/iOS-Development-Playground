    //
    //  CellData.swift
    //  Catalyst
    //
    //  Created by Sathya on 28/02/23.
    //

import Foundation
import UIKit

struct SectionData {
    let sectionID: Int
    let sectionName: String
    var display: Bool
    var controllers: [RowData]
    init(_ sectionID: Int, _ sectionName: String, display: Bool, controllers: [RowData]) {
        self.sectionID = sectionID
        self.sectionName = sectionName
        self.display = display
        self.controllers = controllers
    }
}

struct RowData {
    let name: String
    let image: UIImage?
    let controller: UIViewController.Type
    var display: Bool
    var index: Int

    init(_ name: String, image: UIImage?, controller: UIViewController.Type, display: Bool, index: Int) {
        self.name = name
        self.image = image
        self.controller = controller
        self.display = display
        self.index = index
    }

}
