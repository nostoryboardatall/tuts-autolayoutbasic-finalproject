//
//  BasicLayoutController.swift
//
//  Created by Home on 2019.
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

class BasicLayoutController: UIViewController {
    
    // definition of the view
    lazy var sizeClassTestView: UIView = {
        let view = UIView()
        
        // tell xCode that we are going to use AutoLayout
        view.translatesAutoresizingMaskIntoConstraints = false
        // additional property setup
        view.backgroundColor = .blue
        view.layer.cornerRadius = 13.0
        view.layer.masksToBounds = true

        return view
    }()
    
    // declare and init the SizeCollectionManager variable
    var manager: SizeCollectionManager = SizeCollectionManager()
    
    // Do any additional setup here
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // Setup your view and constraints here
    override func loadView() {
        super.loadView()
        prepareView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func prepareView() {
        // add some space from the top for landscape orientation
        additionalSafeAreaInsets.top = 13.0

        view.addSubview(sizeClassTestView)
        
        // store constraint for portrait orientation
        manager.set([
            sizeClassTestView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            sizeClassTestView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            sizeClassTestView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sizeClassTestView.heightAnchor.constraint(equalToConstant: 69.0)
        ], for: .portrait)
        
        // store constraint for landscapeLeft orientation
        manager.set([
            sizeClassTestView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sizeClassTestView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            sizeClassTestView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            sizeClassTestView.widthAnchor.constraint(equalToConstant: 69.0)
        ], for: .landscapeLeft)
        
        // store constraint for landscapeRight orientation
        manager.set([
            sizeClassTestView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sizeClassTestView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            sizeClassTestView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            sizeClassTestView.widthAnchor.constraint(equalToConstant: 69.0)
        ], for: .landscapeRight)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // store current orientation in let variable
        let orientation = UIDevice.current.orientation
        
        // check if current and future constraints are not nil
        if let inactiveConstraint = manager.all(), let activeConstraint = manager.constraint(for: orientation) {
            // deactivate current constraints
            NSLayoutConstraint.deactivate(inactiveConstraint)
            // activate new constraints
            NSLayoutConstraint.activate(activeConstraint)
        }
        
        // call the super method
        super.traitCollectionDidChange(traitCollection)
    }

}
