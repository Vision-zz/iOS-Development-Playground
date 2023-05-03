    //
    //  DataProvider.swift
    //  Catalyst
    //
    //  Created by Sathya on 02/03/23.
    //

import Foundation
import UIKit

struct DataProvider {
    static let cellData: [SectionData] = [
        SectionData(0, "Content Views", display: true, controllers: [
            RowData("Activity Indicator View", image: UIImage(systemName: "circle.dotted"), controller: ActivityIndicatorViewVC.self, display: true, index: 0),
            RowData("Calendar View", image: UIImage(systemName: "calendar"), controller: CalendarViewVC.self, display: true, index: 1),
            RowData("Image View", image: UIImage(systemName: "photo"), controller: ImageViewVC.self, display: true, index: 2),
            RowData("Search View", image: UIImage(systemName: "magnifyingglass"), controller: SearchVC.self, display: true, index: 3),
        ]),
        SectionData(1, "Text Fields", display: true, controllers: [
            RowData("Text Field", image: UIImage(systemName: "character.cursor.ibeam"), controller: TextViewVC.self, display: true, index: 0)
        ])
    ]
}
