//
//  ViewController.swift
//  PexelsPractice
//
//  Created by Tiparpron Sukanya on 11/8/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextFilled: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    
    var searchText = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextFilled.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func searchButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "listConnect", sender: nil)
    //performSeque trigger navigation one page to another page
    }
    //to send data we need prepare for seque -prepare send data to next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let listViewController = segue.destination as? PhotoListViewController
        listViewController?.searchQuery = searchText
    }
}
//textfield like inputbox-user type something on the box
extension ViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        searchText = textField.text ?? "" + string // this line update what every user typring in input box -this line will keep update
        return true
    }
}
