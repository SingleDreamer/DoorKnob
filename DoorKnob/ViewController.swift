//
//  ViewController.swift
//  DoorKnob
//
//  Created by Jessica Ng on 9/24/16.
//  Copyright © 2016 Jessica Ng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var lockStatus: UILabel!
    
    @IBOutlet weak var timeLeaving: UITextField!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    var timer = NSTimer()
    var count = 0000
    var endCount = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Actions
    
    
    @IBAction func timeLeavingSetter(sender: UITextField) {
        let inputView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 240))
        
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRectMake((self.view.frame.size.width/2) - (100/2), 0, 100, 50))
        doneButton.setTitle("Done", forState: UIControlState.Normal)
        doneButton.setTitle("Done", forState: UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        doneButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: "doneButton:", forControlEvents: UIControlEvents.TouchUpInside) // set button click event
        
        sender.inputView = inputView
        
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
        handleDatePicker(datePickerView) // Set the date on start.
    }
    
    
    func doneButton(sender:UIButton)
    {
        timeLeaving.resignFirstResponder() // To resign the inputView on clicking done.
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm"
        timeLeaving.text = dateFormatter.stringFromDate(sender.date)
        endCount = getHourFromDatePicker(sender)*360 + getMinFromDatePicker(sender)*60
        //it counts down in seconds bc i am v lazy
        //endCount = getMinFromDatePicker(sender)
    }
    
    func getHourFromDatePicker(datePicker:UIDatePicker) -> Int
    {
        let date = datePicker.date
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute] , fromDate: date)
        
        return components.hour
    }
    
    func getMinFromDatePicker(datePicker:UIDatePicker) -> Int
    {
        let date = datePicker.date
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute] , fromDate: date)
        
        return components.minute
    }
    
    @IBAction func locker(sender: AnyObject) {
        
        
        if lockLocked(){
            timer.invalidate()
            count = 0000
            updateText()
        }
        else {
            count = endCount
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countDown", userInfo: nil, repeats: true)
        }
        
        switchLock()
    }
    
    func countDown() {
        
        count -= 1
        if (count == 0000) {
            timer.invalidate()
            switchLock()
        }
        
        updateText()
    }
    
    
    func switchLock() {
        if lockStatus.text == "UNLOCKED" {
            lockStatus.text = "LOCKED"
            lockStatus.textColor = UIColor.redColor()
        }
        else if lockStatus.text == "LOCKED"{
            lockStatus.text = "UNLOCKED"
            lockStatus.textColor = UIColor.greenColor()
        }
    }
    
    func lockLocked() -> Bool {
        if lockStatus.text == "UNLOCKED" {
            return false
        }
        else {
            return true
        }
    }
    
    func updateText() {
        
        // Convert from Binary to String
        let text = String(count, radix:10)
        
        /*// Pad "0" to the left, to always have 4 binary digits
        for i in 0..<4 - count(text) {
        text = "0" + text;
        }*/
        
        timeLabel.text = text + "s"
    }
    
    
    
}

