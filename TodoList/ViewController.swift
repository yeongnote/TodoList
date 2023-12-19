//
//  ViewController.swift
//  TodoList
//
//  Created by YeongHo Ha on 12/18/23.
//

import UIKit

@objc protocol KeyboardManaging {
    func doneButtonAction()
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, KeyboardManaging {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    
    var list: [String] = ["첫 번째 리스트", "두 번째 리스트", "세 번째 리스트"]
    
    //let keyboardManager = KeyboardManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        // 키보드 외 다른 터치로 키보드 감추기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // Done 버튼을 텍스트 필드에 추가
        textField.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEndOnExit)
        
        // Done 버튼을 텍스트 필드에 추가
        textField.inputAccessoryView = UIView()
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func textFieldEditingDidEnd(_ sender: Any) {
        //텍스트 필드 입력후 리스트에 아이템 추가
        addNewItem()
    }
    
    @IBAction func textFieldtmd(_ sender: Any) {
        //텍스트 필드 입력후 리스트에 아이템 추가
        addNewItem()
    }
    
    @IBAction func addButton(_ sender: Any) {
        // 할 일 추가 버튼 클릭 시  리스트에 아이템 추가
        addNewItem()
    }
    
    func addNewItem() {
        guard let newText = textField.text, !newText.isEmpty else {
            return
        }
        
        // 새로운 아이템을 리스트에 추가
        list.append(newText)
        
        // 리스트 추가시 테이블 뷰 리로드
        tableView.reloadData()
        // 텍스트 필드 초기화
        textField.text = nil
        
    }
    
    // UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    @objc func doneButtonAction() {
        hideKeyboard()
    }
}



