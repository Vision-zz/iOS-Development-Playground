//
//  Util.swift
//  Catalyst
//
//  Created by Sathya on 12/03/23.
//

import UIKit

class Util {
    public static func createGlassMorphicEffectView(for frame: CGRect) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
        let effect = UIVisualEffectView(effect: blurEffect)
        effect.frame = frame
        return effect
    }
}
