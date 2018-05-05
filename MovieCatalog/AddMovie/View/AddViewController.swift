//
//  AddViewController.swift
//  MovieCatalog
//
//  Created by Katerina on 05.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//
protocol DetailsViewControllerOutput: class {
    func saveData(title: String, genre: String, poster: UIImage, yearOfProduction: String, description: String)
}

import UIKit
import SkyFloatingLabelTextField

class AddViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var titleTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var genreTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var yearPickerView: UIPickerView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    private let placeholderDescription = "Please enter description"
    
    private var yearsTillNow : [String] {
        var years = [String]()
        for i in (1900..<2018).reversed() {
            years.append("\(i)")
        }
        return years
    }
    
    private var currentYear: String = ""
    private var poster: UIImage? = UIImage(named: "placeholder")
    private var output: DetailsViewControllerOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVIPInstances()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    @objc func keyboardWillAppear(_ notification: NSNotification) {
        self.view.frame.origin.y = -120
    }
    
    @objc func keyboardWillDisappear(_ notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupVIPInstances() {
        let presenter = AddPresenter(output: self)
        let interactor = AddInteractor(output: presenter)
        output = interactor
    }
    
    private func setup() {
        descriptionTextView.delegate = self
        descriptionTextView.text = placeholderDescription
        descriptionTextView.textColor = UIColor.lightGray
        
        descriptionTextView!.layer.borderWidth = 1
        descriptionTextView!.layer.borderColor = UIColor.gray.cgColor
        
        yearPickerView.delegate = self
        yearPickerView.dataSource = self
    }
    
    @IBAction func saveAction(_ sender: Any) {
        var isValidData = true
        if titleTextField.text == "" {
            titleTextField.errorMessage = "Please enter title"
            isValidData = false
        }
        
        if genreTextField.text == "" {
            genreTextField.errorMessage = "Please enter genre"
            isValidData = false
        }
        
        if isValidData {
            currentYear = currentYear == "" ? yearsTillNow[0] : currentYear
            let descriptionText = descriptionTextView.text == placeholderDescription ? "" : descriptionTextView.text
            output.saveData(title: titleTextField.text!, genre: genreTextField.text!, poster: poster!, yearOfProduction: currentYear, description: descriptionText!)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getImageAction(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(image, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let theInfo:NSDictionary = info as NSDictionary
        poster = theInfo.object(forKey: UIImagePickerControllerOriginalImage) as? UIImage
        posterImageView.image = poster
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextViewDelegate
extension AddViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderDescription
            textView.textColor = UIColor.lightGray
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            if let titleTextField = textField as? SkyFloatingLabelTextField {
                if text.count == 0 {
                    titleTextField.errorMessage = ""
                }
            }
        }
        return true
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return yearsTillNow.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return yearsTillNow[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentYear = yearsTillNow[row]
    }
}

// MARK: - DetailsPresenterOutput
extension AddViewController: DetailsPresenterOutput {
    func displayData() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayError() {
        print("Error!")
        self.dismiss(animated: true, completion: nil)
    }
}

