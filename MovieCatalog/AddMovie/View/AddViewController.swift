//
//  AddViewController.swift
//  MovieCatalog
//
//  Created by Katerina on 05.05.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AddViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var titleTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var genreTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var yearPickerView: UIPickerView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    private var yearsTillNow : [String] {
        var years = [String]()
        for i in (1900..<2018).reversed() {
            years.append("\(i)")
        }
        return years
    }
    
    private var currentYear: String = ""
    private var poster: UIImage? = UIImage(named: "placeholder")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setup() {
        descriptionTextView.delegate = self
        descriptionTextView.text = "Please enter description"
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
            self.dismiss(animated: true, completion: nil)
            let newMovie = Movie(title: titleTextField.text!, genre: genreTextField.text, poster: poster, yearOfProduction: currentYear, description: descriptionTextView.text)
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
extension AddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Please enter description"
            textView.textColor = UIColor.lightGray
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

