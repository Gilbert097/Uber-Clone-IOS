//
//  DriverListViewController.swift
//  UberClone
//
//  Created by Gilberto Silva on 09/05/23.
//

import UIKit

public class DriverListViewController: UIViewController {
    
    public var loadList: (() -> Void)?

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Motorista"
        self.view.backgroundColor = .white
        self.loadList?()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
