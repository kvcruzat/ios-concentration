//
//  ThemeChooserViewController.swift
//  Concentration
//
//  Created by Khen Cruzat on 15/12/2017.
//  Copyright © 2017 Khen Cruzat. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController, UISplitViewControllerDelegate{

    private let themes: [String:[String]] = [
        "Halloween" : ["🦇", "🙀", "😱", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🤡"] ,
        "Christmas" : ["🎄", "✨", "🎁", "⛄️", "❄️", "🎅🏻", "👼🏻"," 🦌", "🍪", "🧣"],
        "Animals" : ["🐮", "🐔", "🐢", "🐷", "🦊", "🐼", "🐯", "🐰", "🐶", "🙊"],
        "Sports" : ["🏀", "🏈", "⚾️", "⚽️", "🎱", "🥊", "🎾", "🏐", "🏓" ,"🎳"],
        "Faces" : ["😀", "😍", "😘", "😂", "😎", "😜", "😭", "🙁", "🤮", "😡"],
        "Food" : ["🍕", "🍖", "🍟", "🌮", "🌭", "🍗", "🍙", "🍔", "🍥", "🍣"]
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationController {
            if let themeName = (sender as? UIButton)?.currentTitle,  let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle,  let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true )
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentrationController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }

    private var lastSeguedToConcentrationViewController: ConcentrationViewController?

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle,  let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }


}
