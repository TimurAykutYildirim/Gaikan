//
// This file is part of Gaikan
//
// Created by JC on 30/08/15.
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code
//

import Foundation

internal class ViewStyleRenderer {
    final class func render(stylable: UIView, styleRule: StyleRule) {
        let border = styleRule.border ?? Border(width: 0, color: nil)
        let visible = styleRule.visible ?? true
        let corners = styleRule.corners ?? Corners(radius: 0)
        
        stylable.layer.cornerRadius = corners.radius
        stylable.clipsToBounds = styleRule.clip
        stylable.layer.masksToBounds = styleRule.clip

        stylable.layer.transform = styleRule.transform
        stylable.layer.borderWidth = border.width
        stylable.layer.borderColor = border.color?.CGColor
        stylable.tintColor = styleRule.tintColor
        stylable.hidden = !visible
        stylable.alpha = CGFloat(styleRule.opacity / 100)
        stylable.layoutMargins = styleRule.margin ?? stylable.layoutMargins

        if let background = styleRule.background {
            BackgroundRenderer.render(Background(background), intoView: stylable)
        }

        ConstraintRenderer.render(stylable, styleRule: styleRule)
    }

    final class func render(stylable: UILabel, styleRule: StyleRule) {
        stylable.font = styleRule.font
        stylable.textColor = styleRule.color
        stylable.lineBreakMode = styleRule.textOverflow ?? .ByTruncatingTail
    }

    final class func render(button: UIButton, styleRule: StyleRule) {
        if let titleLabel = button.titleLabel {
            self.render(titleLabel, styleRule: styleRule)
        }

        button.setTitleColor(styleRule.color, forState: .Normal)
        button.contentEdgeInsets = styleRule.margin ?? button.contentEdgeInsets
    }

    final class func render(textField: UITextField, styleRule: StyleRule) {
        textField.textAlignment = styleRule.textAlign ?? .Natural
    }
    
    final class func render(navigationBar: UINavigationBar, titleStyle: StyleRule) {
        navigationBar.titleTextAttributes = titleStyle.textAttributes
    }
}