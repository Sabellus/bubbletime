//
//  UIImage+Extension.swift
//  bubbletime
//
//  Created by  savelii on 18.07.23.
//

import Foundation
import UIKit
import CoreImage
import ImageIO
import MobileCoreServices

extension UIImage {
    enum AppImage: String, CaseIterable {
        case bell
    }
    static func app(_ appImage: AppImage, rendering: RenderingMode = .automatic) -> UIImage? {
        return UIImage(named: appImage.rawValue, in: Bundle.main, compatibleWith: nil)?.withRenderingMode(rendering)
    }
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        color.set()
        withRenderingMode(.alwaysTemplate).draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
