//
//  ViewAllViewController.swift
//  FrameworkApp
//
//  Created by MacBook Pro on 15/10/2024.
//

import UIKit

class ViewAllViewController: UIViewController {

    @IBOutlet weak var serviceLBL: UILabel!
    @IBOutlet weak var viewAllLBL: UILabel!
    
    var viewpressed:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public init () {
        super.init(nibName: "ViewAllViewController", bundle: Bundle(for: ViewAllViewController.self))
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Custom initialization code here
    }


    @IBAction func viewAllPressed(_ sender: Any) {
        viewpressed?()
    }
}
