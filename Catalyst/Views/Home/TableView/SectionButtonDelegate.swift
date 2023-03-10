//
//  SectionButtonDelegate.swift
//  Catalyst
//
//  Created by Sathya on 06/03/23.
//

import Foundation

@objc protocol SectionButtonDelegate {

    @objc optional func buttonSelected(for section: Int) -> Void
    @objc optional func buttonDeselected(for section: Int) -> Void
    @objc optional func isButtonSelectedByDefault(for section: Int) -> Bool

}
