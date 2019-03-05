//
//  SizeClassManager.swift
//
//  Created by Home on 2018.
//  Copyright 2017-2018 NoStoryboardsAtAll Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
//  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

class SizeCollectionManager {
    fileprivate var portraitConstraints: [NSLayoutConstraint]?
    fileprivate var leftLandscapeConstraints: [NSLayoutConstraint]?
    fileprivate var rightLandscapeConstraints: [NSLayoutConstraint]?
    
    /**
    Setting constraints for different orientation
    @param verticalSizeClass Check the device orientation depend on vertical size class. .compact mean
     vertical orientation, .regular mean horizontal
    @param orientation Check the device orientation depend on device orientation. Ignore if is not set.
    @param constraints The constraints )))
    */
    public func set(_ constraints: [NSLayoutConstraint], for verticalSizeClass: UIUserInterfaceSizeClass) {
        if verticalSizeClass == .regular {
            portraitConstraints = constraints.map { $0 }
        } else {
            leftLandscapeConstraints = constraints.map { $0 }
        }
    }
    
    public func set(_ constraints: [NSLayoutConstraint], for orientation: UIDeviceOrientation) {
        switch orientation {
        case .portrait:
            portraitConstraints = constraints.map { $0 }
        case .landscapeLeft:
            leftLandscapeConstraints = constraints.map { $0 }
        case .landscapeRight:
            rightLandscapeConstraints = constraints.map { $0 }
        default:
            break
        }
    }
    
    /**
     Get constraints for different orientation
     @param verticalSizeClass Device orientation depend on vertical size class. .compact mean
                              vertical orientation, .regular mean horizontal
     @param orientation Device orientation depend on device orientation. Ignore if is not set.
     */
    public func constraint(for verticalSizeClass: UIUserInterfaceSizeClass) -> [NSLayoutConstraint]? {
        return verticalSizeClass == .regular ? portraitConstraints : leftLandscapeConstraints
    }
    
    public func constraint(for orientation: UIDeviceOrientation) -> [NSLayoutConstraint]? {
        switch orientation {
        case .portrait:
            return portraitConstraints
        case .landscapeLeft:
            return leftLandscapeConstraints
        case .landscapeRight:
            return rightLandscapeConstraints
        default:
            return portraitConstraints
        }
    }
    
    /**
     Get all constraints 
     */
    public func all() -> [NSLayoutConstraint]? {
        var allConstraints: [NSLayoutConstraint] = []
        
        portraitConstraints?.forEach { allConstraints.append($0) }
        leftLandscapeConstraints?.forEach { allConstraints.append($0) }
        rightLandscapeConstraints?.forEach { allConstraints.append($0) }
        
        return allConstraints
    }
    
    public func combine(with sizeCollection: SizeCollectionManager) -> [NSLayoutConstraint]? {
        var constraints = all()
        sizeCollection.all()?.forEach( { constraints?.append($0) } )
        return constraints
    }
}
