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
            //Perform Touch ID auth
            authContext.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "Testing Touch ID", reply:{(wasSuccessful:Bool, err:NSError?)
                
                if(wasSuccessful)
                {
                    //User authenticated
                    self.updateAuthenticateResult(authError:error)
                }
                else
                {
                    //There are a few reasons why it can fail, we'll write them out to the user in the label
                    
                    self.updateAuthenticateResult(authError: error)
                    
                    self.writeOutAuthResult(error)
                }
                
            })
        } else {
            //not available or configured
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
}

