//
//  ViewController.swift
//  vaolkhovskaiaPW1
//
//  Created by Вилина Ольховская on 16.10.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var views: [UIView]!
    @IBOutlet var button: UIButton!
    // MARK: Function activates on complited view load.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //changeColor(views)
        //changeCornerRadius(views)
    }
    
    // MARK: Function changes color and border radius on button pressed.
    @IBAction func buttonWasPressed(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        
        button.isEnabled = false
        setAnimate(views, button)
        
    }
    
    
}

extension ViewController {
    // MARK: Function changes view's border radius.
    func changeColor(_ views: [UIView]) {
        var uniqueColors: Set<UIColor> = getUniqueColor(views.count)
        
        for view in views {
            view.backgroundColor = uniqueColors.popFirst()
        }
    }
    
    // MARK: Function returns a random color.
    func getUniqueColor(_ viewsCount: Int) -> Set<UIColor> {
        var colorsSet = Set<UIColor>()
        
        for _ in 0..<viewsCount {
            colorsSet
                .insert(
                    UIColor(
                        displayP3Red: .random(in: 0...1),
                        green: .random(in: 0...1),
                        blue: .random(in: 0...1),
                        alpha: 1
                    )
                )
        }
        return colorsSet
    }
    
    // MARK: Function changes view's color.
    func changeCornerRadius(_ views: [UIView]) {
        for view in views {
            view.layer.cornerRadius = .random(in: 0...40)
        }
    }
    // MARK: Function sets animation.
    func setAnimate(_ views: [UIView], _ button: UIButton?) {
        UIView.animate(
            withDuration: 0.5,
            animations: {
                self.changeColor(views)
                self.changeCornerRadius(views)
            },
            completion: { _ in
                button?.isEnabled = true
            }
        )
    }
}

