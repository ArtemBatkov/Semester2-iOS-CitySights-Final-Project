import UIKit

class TestPageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    
    private let list = ["Ru", "En", "Kz"]
    
    
    
    private let table = UITableView()
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PageSetUp()
        
        
    }
    
    private let pickerView = UIPickerView()
    
    
    private func PageSetUp(){
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        //stackSearch
        let stackSearch = UIStackView()
        stackSearch.axis = .vertical
        stackSearch.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(stackSearch)
        
        
        //add picker
        label.translatesAutoresizingMaskIntoConstraints = false
        stackSearch.addSubview(label)
        
        label.text = list[0]
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.isUserInteractionEnabled = true
        
        // Добавление UITapGestureRecognizer на label
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        label.addGestureRecognizer(tapGesture)
        
        
        //add horizontalView
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        horizontalStackView.spacing = 10
        stackSearch.addSubview(horizontalStackView)
        
        //TextField
        let textField = UITextField()
        textField.backgroundColor = .gray
        textField.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.addArrangedSubview(textField)
        
        //add button
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Button", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.addArrangedSubview(button)
        
        
        table.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(table)
        
        NSLayoutConstraint.activate([
            // Ограничения для stackView:
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 50),
            stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
            
            // Ограничения для tableView:
            table.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            table.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            table.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
        
        
        
        NSLayoutConstraint.activate([
            // Ограничения для stackSearch:
            stackSearch.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            stackSearch.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            stackSearch.topAnchor.constraint(equalTo: stackView.topAnchor),
            stackSearch.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            // Ограничения для horizontalStackView:
            horizontalStackView.leadingAnchor.constraint(equalTo: stackSearch.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: stackSearch.trailingAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: stackSearch.bottomAnchor),
            horizontalStackView.heightAnchor.constraint(equalTo: stackSearch.heightAnchor, multiplier: 0.5),
            
            // Ограничения для pickerView:
            label.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            label.topAnchor.constraint(equalTo: stackSearch.topAnchor, constant: 10),
            label.heightAnchor.constraint(equalToConstant: 20),
            
            // Ограничения для textField:
            textField.leadingAnchor.constraint(equalTo: horizontalStackView.leadingAnchor, constant: 10),
            textField.widthAnchor.constraint(equalTo: horizontalStackView.widthAnchor, multiplier: 0.7, constant: -10),
            button.widthAnchor.constraint(equalTo: horizontalStackView.widthAnchor, multiplier: 0.3, constant: -10),
            button.trailingAnchor.constraint(equalTo: horizontalStackView.trailingAnchor, constant: -10)
        ])
        
        table.backgroundColor = .red
        //pickerView.backgroundColor = .yellow
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.isHidden = true
        
        view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Размещение пикера по центру экрана:
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // Отступы слева и справа от краев экрана:
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        
        
        
        //pickerView.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        
        
        
        
        
        
        
        
        
        
    }
    
    @objc func labelTapped() {
        pickerView.isHidden = false
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            label.text = list[row]
            pickerView.isHidden = true
        }
    
    
}


