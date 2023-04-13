//
//  TimeCircuitsViewController.swift
//  Outatime
//
//  Created by Harm on 4/11/23.
//

import UIKit

class TimeCircuitsViewController: UIViewController {
    
    @IBOutlet weak var destinationTimeLabel: UILabel!
    @IBOutlet weak var presentTimeLabel: UILabel!
    @IBOutlet weak var lastTimeDepartedLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    var currentSpeed: Int = 0
    
    private var timer: Timer?
    
    var dateFormatter: DateFormatter {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM d, yyyy"
        
        formatter.timeZone = TimeZone.current
        
        return formatter
        
    }
    
    // MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentTimeLabel.text = dateFormatter.string(from: Date())
        speedLabel.text = "\(currentSpeed) MPH"
        lastTimeDepartedLabel.text = "--- -- ----"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func travelBackTapped(_ sender: UIButton) {
        startTimer()
    }
    
    func startTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: updateSpeed(timer:))
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func showAlert() {
        
        guard let message = presentTimeLabel.text else { return }
        
        let alert = UIAlertController(title: "Time Travel Successful", message: "Your new date is \(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Oki, thx", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    func updateSpeed(timer: Timer) {
        if currentSpeed < 88 {
            currentSpeed += 1
            speedLabel.text = "\(currentSpeed) MPH"
            //            startTimer()
        } else {
            resetTimer()
            lastTimeDepartedLabel.text = presentTimeLabel.text
            presentTimeLabel.text = destinationTimeLabel.text
            currentSpeed = 0
        }
    }
        
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            let datePickerVC = segue.destination as? DatePickerViewController
            datePickerVC?.delegate = self
            
        }
}


extension TimeCircuitsViewController: DatePickerDelegate {
    
    func destinationDateWasChosen(date: Date) {
        destinationTimeLabel.text = dateFormatter.string(from: date)
    }
    
}
