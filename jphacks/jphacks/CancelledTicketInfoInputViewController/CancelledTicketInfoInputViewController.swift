//
//  CancelledTicketInfoInputViewController.swift
//  jphacks
//
//  Created by 山下陽央 on 2019/10/25.
//  Copyright © 2019 山下陽央. All rights reserved.
//

import UIKit

class CancelledTicketInfoInputViewController: UIViewController, UITextFieldDelegate {
    private var textfields = [UITextField]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureObserver()
        var buggetDataList: [String] = []

        for i in stride(from: 1000, to: 501000, by: 1000) {
            buggetDataList += [String(i)]
        }
        budgetPicker.setup(dataList: buggetDataList)
        
        var pplDataList: [String] = []
        
        for k in 1..<21 {
            pplDataList += [String(k)]
        }
        
        numOfPplPicker.setup(dataList: pplDataList)
        
        var placeList: [String] = []
        for code in AirportCodeList.allCases {
            placeList += [code.rawValue]
        }
        
        departurePicker.setup(dataList: placeList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        textfields += [departurePicker, budgetPicker, returnDatePicker, numOfPplPicker]
    }
    
    @IBOutlet weak var departurePicker: PickerTextField!
    @IBOutlet weak var budgetPicker: PickerTextField!
    @IBOutlet weak var returnDatePicker: DatePickerKeyboard!
    @IBOutlet weak var numOfPplPicker: PickerTextField!
    
    @IBOutlet weak var VFView: UIVisualEffectView! {
        didSet {
            VFView.layer.cornerRadius = 8
            VFView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var confirmButton: UIButton! {
        didSet {
            confirmButton.layer.cornerRadius = 8
        }
    }
    
    func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                 name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                 name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification?) {
        guard let rect = (notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            let transform = CGAffineTransform(translationX: 0, y: -(rect.size.height - 150))
            self.view.transform = transform
        }
    }

    @objc func keyboardWillHide(_ notification: Notification?) {
        guard let duration = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            self.view.transform = CGAffineTransform.identity
        }
    }
    
    @IBAction func didTapSearchButton(_ sender: Any) {
        search()
    }
    
    private func search() {
        guard let departurePickerText = departurePicker.text, !departurePickerText.isEmpty,
            let budgetPickerText = budgetPicker.text, !budgetPickerText.isEmpty,
            let returnDatePickerText = returnDatePicker.text, !returnDatePickerText.isEmpty,
            let numOfPplPickerText = numOfPplPicker.text, !numOfPplPickerText.isEmpty else {
                let alert = UIAlertController(title: "未入力の項目があります",
                                              message: "全フォームに情報を入力してください",
                                              preferredStyle: .alert)
                
                alert.addAction(okAction())
                present(alert, animated: true, completion: nil)
                return
        }
        
        for textField in textfields {
            textField.resignFirstResponder()
        }
        
        let airportCode = AirportCodeList(rawValue: departurePickerText)!
        
        InitialInfo.shared.airportName = airportCode.code
        InitialInfo.shared.returnDate = returnDatePickerText
        
        TripInfoPostClient.post(depPlace: airportCode.code,
                                budget: budgetPickerText,
                                retDate: returnDatePicker.getDateString(),
                                people: numOfPplPickerText,
                                completionHandler: { [weak self] () in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                        TripGetPostClient.get(completionHandler: {
                                            let vc = PlanCandidatesTableViewController()
                                            self?.navigationController?.pushViewController(vc, animated: true)
                                        }) {
                                            self?.showErrorAlert()
                                        }
                                    }
        }) {
            self.showErrorAlert()
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "エラー",
                                      message: "データを取得できませんでした",
                                      preferredStyle: .alert)
        
        alert.addAction(okAction())
        present(alert, animated: true, completion: nil)
    }
    
    private func okAction() -> UIAlertAction {
        return UIAlertAction(title: "OK", style: .default, handler: nil)
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextTextField = view.viewWithTag(nextTag) {
            nextTextField.becomeFirstResponder()
        }
        return true
    }
}
