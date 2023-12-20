//
//  ViewController.swift
//  TodoList
//
//  Created by YeongHo Ha on 12/18/23.
//

import UIKit



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var subTitle: UILabel!
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
        
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDeleteAlert(for: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] (_, _, completion) in
            self?.showDeleteAlert(for: indexPath.row)
            completion(true)
        }
        
        let swipeConfig = UISwipeActionsConfiguration(actions: [delteAction])
        return swipeConfig
    }
    // 리스트 삭제 확인 창 표시
    func showDeleteAlert(for index: Int) {
        let alertController = UIAlertController(title: "삭제 확인", message: "이 항목을 삭제하시겠습니까?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .destructive) { [weak self] _ in
            // "확인" 클릭 시 동작
            self?.deleteItem(at: index)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // 리스트 삭제 메서드
    func deleteItem(at index: Int) {
        list.remove(at: index)
        tableView.reloadData()
    }
    
    
}



