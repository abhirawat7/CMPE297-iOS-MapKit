//
//  ViewController.swift
//  MapKitAssignment
//
//  Created by Student on 9/26/17.
//  Copyright © 2017 Anvit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var fromAddress: UITextField!
    @IBOutlet var fromCity: UITextField!
    @IBOutlet var fromState: UITextField!
    @IBOutlet var fromZip: UITextField!
    
    @IBOutlet var toAddress: UITextField!
    @IBOutlet var toCity: UITextField!
    @IBOutlet var toState: UITextField!
    @IBOutlet var toZip: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var fromPlace = fromAddress.text! + ", " + fromCity.text!
        fromPlace += ", " + fromState.text! + ", " + fromZip.text! + ", USA"
        var toPlace = toAddress.text! + ", " + toCity.text!
        toPlace += ", " + toState.text! + ", " + toZip.text! + ", USA"
        
        if let destinationVC = segue.destination as? MapViewController {
            destinationVC.fromPlace = fromPlace
            destinationVC.toPlace = toPlace
            if segue.identifier == "ShowMap" { //show Map
                destinationVC.showType = "map"
            } else if segue.identifier == "ShowRoute" { //show Route
                destinationVC.showType = "route"
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
