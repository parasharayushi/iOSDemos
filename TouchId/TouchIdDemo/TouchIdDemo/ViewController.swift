//
//  ViewController.swift
//  TouchIdDemo
//
//  Created by Ayushi Parashar on 2/14/17.
//  Copyright © 2017 Ayushi Parashar. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func AuthenticateButtonClick(_ sender: Any) {
        let authContext:LAContext = LAContext()
        
        var authError:NSError?
        
        //is touchID available and configured
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            //perform touch Id
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Testing Touch Id", reply: {(success, error) in
                if success {
                    //User authenticated
                    self.updateAuthenticateResult(authError:error as NSError?)
                } else {
                    //There are a few reasons why it can fail, we'll write them out to the user in the label
                    
                    self.updateAuthenticateResult(authError: error as NSError?)
                    
                    //self.writeOutAuthResult(error)
                }
            } )
            
        } else {
            //not configured or available
            self.showAlert()
        }
    }

    @IBOutlet weak var authenticateResultLabel: UILabel!
    
    func updateAuthenticateResult(authError:NSError?){
        
        DispatchQueue.main.async {
            if let possibleError = authError {
                self.authenticateResultLabel.textColor = UIColor.red
                self.authenticateResultLabel.text = possibleError.localizedDescription
            } else {
                self.authenticateResultLabel.textColor = UIColor.green
                self.authenticateResultLabel.text = "Authentication Successful"
            }
        }
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Hey There", message: "Touch Id is not configured or not supported", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

