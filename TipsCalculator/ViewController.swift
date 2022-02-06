//
//  ViewController.swift
//  TipsCalculator
//
//  Created by ddrop on 06.02.2022.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var billAmountView: UIView!
    var tipsAmountView: UIView!
    var resetButton: UIButton!
    var billAmountLabel: UILabel!
    var tipPercentCell: UISegmentedControl!
    var tipsPercentLabel: UILabel!
    var tipAmountLabel: UILabel!
    var totalLabel: UILabel!
    var numberOfPersonsLabel: UILabel!
    var totalOnPersonLabel: UILabel!
    var billAmountField: UITextField!
    var numberOfPersonsField: UITextField!
    var tipsSlider: UISlider!
    var tipsField: UILabel!
    var tipAmountValueLabel: UILabel!
    var calculateButton: UIButton!
    var totalAmountLabel: UILabel!
    var totalAmountOnPersonLabel: UILabel!

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        view.backgroundColor = UIColor.init(named: "Background")
        
        billAmountView = UIView(frame: .zero)
        tipsAmountView = UIView(frame: .zero)
        resetButton = UIButton(frame: .zero)
        calculateButton = UIButton(frame: .zero)
        billAmountLabel = UILabel(frame: .zero)
        tipPercentCell = UISegmentedControl(frame: .zero)
        tipAmountLabel = UILabel(frame: .zero)
        totalLabel = UILabel(frame: .zero)
        numberOfPersonsLabel = UILabel(frame: .zero)
        tipsPercentLabel = UILabel(frame: .zero)
        totalOnPersonLabel = UILabel(frame: .zero)
        
        billAmountField = UITextField(frame: .zero)
        numberOfPersonsField = UITextField(frame: .zero)
        tipsSlider = UISlider(frame: .zero)
        tipsField = UILabel(frame: .zero)
        tipAmountValueLabel = UILabel(frame: .zero)
        
        totalAmountLabel = UILabel(frame: .zero)
        totalAmountOnPersonLabel = UILabel(frame: .zero)
        
        configureUI()
    }
    
    @objc func updateLabel(sender: UISlider!) {
        let value = Double(sender.value)
        DispatchQueue.main.async {
            self.tipsField.text = "\(Int(value)) %"
        }
    }
    
    @objc func calculate() {
        guard let billAmountText = self.billAmountField.text, let billAmount = Float(billAmountText) else { return }
        guard let numberOfPersonsFieldText = self.numberOfPersonsField.text, let numberOfPersons = Float(numberOfPersonsFieldText) else { return }
        
        let tipPercent = Int(tipsSlider.value)
        let tipAmount = Float(Float(billAmount) / 100 * Float(tipPercent))
        let tipForPersons = tipAmount / numberOfPersons
        
        DispatchQueue.main.async {
            self.tipAmountValueLabel.text = String(Int(tipAmount))
            self.totalAmountLabel.text = String(billAmount + tipAmount)
            self.totalAmountOnPersonLabel.text = String(tipForPersons)
        }
        
    }
    
    //MARK: - Private func
    
    private func configureUI() {
        configureBillAmountView()
        configureTipsAmountView()
        configureResetButton()
        configureCalculateButton()
        configureBillAmountLabel()
        configureTipAmountLabel()
        configureNumberOfPersonsLabel()
        configureTipsPercentLabel()
        configureTotalLabel()
        configureTotalOnPersonLabel()
        configureBillAmountField()
        configureNumberOfPersonsField()
        
        configureSlider()
        configureTipsLabel()
        configureTipAmountValueLabel()
        
        configureTotalAmountLabel()
        configureTotalOnPersonAmountLabel()
    }
    
    private func configureBillAmountView() {
        billAmountView.translatesAutoresizingMaskIntoConstraints = false
        billAmountView.backgroundColor = UIColor.init(named: "Accent")
        billAmountView.layer.cornerRadius = 20.0
        billAmountView.layer.borderWidth = 1.0
        billAmountView.layer.borderColor = UIColor.init(named: "BorderColor")?.cgColor
        
        view.addSubview(billAmountView)
        
        NSLayoutConstraint.activate([
            billAmountView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            billAmountView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            billAmountView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.height / 2),
            billAmountView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15)])
    }
    
    private func configureTipsAmountView() {
        tipsAmountView.translatesAutoresizingMaskIntoConstraints = false
        tipsAmountView.backgroundColor = UIColor.init(named: "Secondary")
        tipsAmountView.layer.cornerRadius = 20.0
        tipsAmountView.layer.borderWidth = 1.0
        tipsAmountView.layer.borderColor = UIColor.init(named: "BorderColor")?.cgColor
        
        view.addSubview(tipsAmountView)
        
        NSLayoutConstraint.activate([
            tipsAmountView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height / 2 - 60),
            tipsAmountView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            tipsAmountView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -view.frame.height / 8),
            tipsAmountView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15)])
    }
    
    private func configureResetButton() {
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(UIColor.init(named: "Secondary"), for: .normal)
        resetButton.backgroundColor = UIColor.init(named: "Accent")
        resetButton.layer.cornerRadius = 10.0
        resetButton.layer.borderWidth = 1.0
        resetButton.layer.borderColor = UIColor.init(named: "BorderColor")?.cgColor
        resetButton.titleLabel?.font = UIFont(name: "Avenir", size: 22)
        resetButton.addTarget(self, action: #selector(ViewController.resetFields), for: .touchUpInside)
        
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: tipsAmountView.bottomAnchor, constant: 35),
            resetButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: view.frame.width / 2 + 5),
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            resetButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10)])
    }
    
    private func configureCalculateButton() {
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.setTitleColor(UIColor.init(named: "Secondary"), for: .normal)
        calculateButton.backgroundColor = UIColor.init(named: "Accent")
        calculateButton.layer.cornerRadius = 10.0
        calculateButton.layer.borderWidth = 1.0
        calculateButton.layer.borderColor = UIColor.init(named: "BorderColor")?.cgColor
        calculateButton.titleLabel?.font = UIFont(name: "Avenir", size: 22)
        
        calculateButton.addTarget(self, action: #selector(ViewController.calculate), for: .touchUpInside)
        
        view.addSubview(calculateButton)
        
        NSLayoutConstraint.activate([
            calculateButton.topAnchor.constraint(equalTo: tipsAmountView.bottomAnchor, constant: 35),
            calculateButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            calculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            calculateButton.rightAnchor.constraint(equalTo: resetButton.leftAnchor, constant: -5)])
    }
    
    private func configureBillAmountLabel() {
        billAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        billAmountLabel.text = "Bill amount"
        billAmountLabel.textColor = UIColor.init(named: "Secondary")
        billAmountLabel.font = UIFont(name: "Avenir", size: 22)
        
        view.addSubview(billAmountLabel)
        
        NSLayoutConstraint.activate([
            billAmountLabel.topAnchor.constraint(equalTo: billAmountView.topAnchor, constant: 35),
            billAmountLabel.leftAnchor.constraint(equalTo: billAmountView.leftAnchor, constant: 25)])
    }
    
    private func configureTipAmountLabel() {
        tipAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        tipAmountLabel.text = "Tip amount"
        tipAmountLabel.textColor = UIColor.init(named: "Accent")
        tipAmountLabel.font = UIFont(name: "Avenir", size: 22)
        
        view.addSubview(tipAmountLabel)
        
        NSLayoutConstraint.activate([
            tipAmountLabel.topAnchor.constraint(equalTo: tipsAmountView.topAnchor, constant: 35),
            tipAmountLabel.leftAnchor.constraint(equalTo: tipsAmountView.leftAnchor, constant: 25)])
    }
    
    private func configureNumberOfPersonsLabel() {
        numberOfPersonsLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfPersonsLabel.text = "Number of persons"
        numberOfPersonsLabel.textColor = UIColor.init(named: "Secondary")
        numberOfPersonsLabel.font = UIFont(name: "Avenir", size: 22)
        
        view.addSubview(numberOfPersonsLabel)
        
        NSLayoutConstraint.activate([
            numberOfPersonsLabel.topAnchor.constraint(equalTo: billAmountLabel.bottomAnchor, constant: 25),
            numberOfPersonsLabel.leftAnchor.constraint(equalTo: billAmountView.leftAnchor, constant: 25)])
    }
    
    private func configureTipsPercentLabel() {
        tipsPercentLabel.translatesAutoresizingMaskIntoConstraints = false
        tipsPercentLabel.text = "Tips %"
        tipsPercentLabel.textColor = UIColor.init(named: "Secondary")
        tipsPercentLabel.font = UIFont(name: "Avenir", size: 22)
        
        view.addSubview(tipsPercentLabel)
        
        NSLayoutConstraint.activate([
            tipsPercentLabel.topAnchor.constraint(equalTo: numberOfPersonsLabel.bottomAnchor, constant: 25),
            tipsPercentLabel.leftAnchor.constraint(equalTo: billAmountView.leftAnchor, constant: 25)])
    }
    
    private func configureTotalLabel() {
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.text = "Total"
        totalLabel.textAlignment = .right
        totalLabel.textColor = UIColor.init(named: "Accent")
        totalLabel.font = UIFont(name: "Avenir", size: 22)
        
        view.addSubview(totalLabel)
        
        NSLayoutConstraint.activate([
            totalLabel.topAnchor.constraint(equalTo: tipAmountLabel.bottomAnchor, constant: 25),
            totalLabel.leftAnchor.constraint(equalTo: tipsAmountView.leftAnchor, constant: 25)])
    }
    
    private func configureTotalOnPersonLabel() {
        totalOnPersonLabel.translatesAutoresizingMaskIntoConstraints = false
        totalOnPersonLabel.text = "Tip on person"
        totalOnPersonLabel.textAlignment = .center
        totalOnPersonLabel.textColor = UIColor.init(named: "Accent")
        totalOnPersonLabel.font = UIFont(name: "Avenir", size: 22)
        
        view.addSubview(totalOnPersonLabel)
        
        NSLayoutConstraint.activate([
            totalOnPersonLabel.topAnchor.constraint(equalTo: tipAmountLabel.bottomAnchor, constant: 25),
            totalOnPersonLabel.rightAnchor.constraint(equalTo: tipsAmountView.rightAnchor, constant: -25)])
    }
    
    private func configureBillAmountField() {
        billAmountField.translatesAutoresizingMaskIntoConstraints = false
        billAmountField.placeholder = "          "
        billAmountField.font = UIFont(name: "Avenir", size: 22)
        billAmountField.layer.cornerRadius = 5.0
        billAmountField.layer.borderWidth = 1.0
        billAmountField.layer.borderColor = UIColor.init(named: "BorderColor")?.cgColor
        billAmountField.textColor = UIColor.init(named: "Accent")
        billAmountField.backgroundColor = UIColor.init(named: "Secondary")
        billAmountField.textAlignment = .center
        billAmountField.keyboardType = .numberPad
        
        view.addSubview(billAmountField)
        
        NSLayoutConstraint.activate([
            billAmountField.topAnchor.constraint(equalTo: billAmountView.topAnchor, constant: 35),
            billAmountField.leftAnchor.constraint(equalTo: billAmountLabel.rightAnchor, constant: 35),
            billAmountField.rightAnchor.constraint(equalTo: billAmountView.rightAnchor, constant: -15)])
    }
    
    private func configureNumberOfPersonsField() {
        numberOfPersonsField.translatesAutoresizingMaskIntoConstraints = false
        numberOfPersonsField.placeholder = "    "
        numberOfPersonsField.font = UIFont(name: "Avenir", size: 22)
        numberOfPersonsField.layer.cornerRadius = 5.0
        numberOfPersonsField.layer.borderWidth = 1.0
        numberOfPersonsField.layer.borderColor = UIColor.init(named: "BorderColor")?.cgColor
        numberOfPersonsField.textColor = UIColor.init(named: "Accent")
        numberOfPersonsField.backgroundColor = UIColor.init(named: "Secondary")
        numberOfPersonsField.textAlignment = .center
        numberOfPersonsField.keyboardType = .numberPad
        numberOfPersonsField.text = "1"
        
        view.addSubview(numberOfPersonsField)
        
        NSLayoutConstraint.activate([
            numberOfPersonsField.topAnchor.constraint(equalTo: billAmountLabel.bottomAnchor, constant: 25),
            numberOfPersonsField.leftAnchor.constraint(equalTo: numberOfPersonsLabel.rightAnchor, constant: 35),
            numberOfPersonsField.rightAnchor.constraint(equalTo: billAmountView.rightAnchor, constant: -15)])
    }
    
    private func configureSlider() {
        tipsSlider.translatesAutoresizingMaskIntoConstraints = false
        tipsSlider.addTarget(self, action: #selector(ViewController.updateLabel(sender:)), for: .valueChanged)
        tipsSlider.minimumValue = 0
        tipsSlider.maximumValue = 100
        tipsSlider.minimumTrackTintColor = UIColor.init(named: "Secondary")
        view.addSubview(tipsSlider)
        
        NSLayoutConstraint.activate([
            tipsSlider.topAnchor.constraint(equalTo: tipsPercentLabel.bottomAnchor, constant: 25),
            tipsSlider.leftAnchor.constraint(equalTo: billAmountView.leftAnchor, constant: 35),
            tipsSlider.rightAnchor.constraint(equalTo: billAmountView.rightAnchor, constant: -35)])
    }
    
    private func configureTipsLabel() {
        tipsField.translatesAutoresizingMaskIntoConstraints = false
        tipsField.text = "\(Int(tipsSlider.value)) %"
        tipsField.textAlignment = .center
        tipsField.textColor = UIColor.init(named: "Secondary")
        tipsField.font = UIFont(name: "Avenir", size: 22)
        
        view.addSubview(tipsField)
        
        NSLayoutConstraint.activate([
            tipsField.topAnchor.constraint(equalTo: numberOfPersonsLabel.bottomAnchor, constant: 25),
            tipsField.leftAnchor.constraint(equalTo: tipsPercentLabel.rightAnchor, constant: 35)])
    }
    
    private func configureTipAmountValueLabel() {
        let kek = Int(billAmountField.text!) ?? 0
        let amount = kek * Int(tipsSlider.value) + kek
        tipAmountValueLabel.translatesAutoresizingMaskIntoConstraints = false
        tipAmountValueLabel.textColor = UIColor.init(named: "Accent")
        tipAmountValueLabel.font = UIFont(name: "Avenir", size: 22)
        tipAmountValueLabel.text = "\(amount)"
        
        view.addSubview(tipAmountValueLabel)
        
        NSLayoutConstraint.activate([
            tipAmountValueLabel.topAnchor.constraint(equalTo: tipsAmountView.topAnchor, constant: 35),
            tipAmountValueLabel.rightAnchor.constraint(equalTo: tipsAmountView.rightAnchor, constant: -25)])
    }
    
    private func configureTotalAmountLabel() {
        totalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        totalAmountLabel.textAlignment = .right
        totalAmountLabel.textColor = UIColor.init(named: "Accent")
        totalAmountLabel.font = UIFont(name: "Avenir", size: 22)
        
        view.addSubview(totalAmountLabel)
        
        NSLayoutConstraint.activate([
            totalAmountLabel.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 25),
            totalAmountLabel.leftAnchor.constraint(equalTo: tipsAmountView.leftAnchor, constant: 25)])
    }
    
    private func configureTotalOnPersonAmountLabel() {
        totalAmountOnPersonLabel.translatesAutoresizingMaskIntoConstraints = false
        totalAmountOnPersonLabel.textAlignment = .right
        totalAmountOnPersonLabel.textColor = UIColor.init(named: "Accent")
        totalAmountOnPersonLabel.font = UIFont(name: "Avenir", size: 22)
        
        view.addSubview(totalAmountOnPersonLabel)
        
        NSLayoutConstraint.activate([
            totalAmountOnPersonLabel.topAnchor.constraint(equalTo: totalOnPersonLabel.bottomAnchor, constant: 25),
            totalAmountOnPersonLabel.rightAnchor.constraint(equalTo: tipsAmountView.rightAnchor, constant: -25)])
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func resetFields() {
        DispatchQueue.main.async {
            self.tipsSlider.value = 1
            self.tipsField.text = "\(Int(self.tipsSlider.value)) %"
            self.billAmountField.text = nil
            self.totalAmountLabel.text = ""
            self.totalAmountOnPersonLabel.text = ""
            self.numberOfPersonsField.text = "1"
            self.tipAmountValueLabel.text = "0"
        }
    }
}
