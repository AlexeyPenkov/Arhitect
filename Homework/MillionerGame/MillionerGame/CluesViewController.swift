//
//  CluesViewController.swift
//  MillionerGame
//
//  Created by Алексей Пеньков on 09.08.2021.
//

import UIKit


class CluesViewController: UIViewController {

    var image: UIImage?
    var text: String?
    
    @IBOutlet weak var imageClue: UIImageView!
    
    @IBOutlet weak var labelClue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = self.image {
            imageClue.image = image
        }
        
        if let text = self.text {
            labelClue.text = text
        }
        
    }
    

    func setElements(image: UIImage, labelText: String) {
        self.image = image
        self.text = labelText
    }
    
    
    @IBAction func okButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

