//
//  AboutViewController.swift
//  Geekhub iOS_HW_7
//
//  Created by Pavel Bondar on 15.12.2019.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak private var geekImageView: UIImageView!
    @IBOutlet weak private var textView: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        geekImageView.center.x -= view.bounds.width
        textView.center.x += view.bounds.width
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
            self.geekImageView.center.x += self.view.bounds.width
            self.textView.center.x -= self.view.bounds.width
        }, completion: nil)
    }
}
