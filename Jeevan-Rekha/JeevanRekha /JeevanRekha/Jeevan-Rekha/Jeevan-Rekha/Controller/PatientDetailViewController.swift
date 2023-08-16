//
//  PatientDetailViewController.swift
//  JeevanRekha
//
//

import UIKit
import FirebaseDatabase

class PatientDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var patientTableView: UITableView!
    
    
    
    var Patient = patient(name: "", pID: "", disease: "", status: pStatus.fine, age: 40)
    var dripValue : String = ""
    var sensor1: DatabaseReference!
    var sensor2: DatabaseReference!
    var sensor3: DatabaseReference!
    var sensor4: DatabaseReference!
    var sensor5: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.patientTableView.reloadData()
        
        
        sensor1 = Database.database().reference(withPath: "/sensor1")
        sensor2 = Database.database().reference(withPath: "/sensor2")
        sensor3 = Database.database().reference(withPath: "/sensor3")
        sensor4 = Database.database().reference(withPath: "/sensor4")
        sensor5 = Database.database().reference(withPath: "/sensor5")
        
        patientTableView.dataSource = self
        patientTableView.delegate = self
        patientTableView.separatorStyle = .none
        patientTableView.reloadData()
       
        // Do any additional setup after loading the view.
    }
    func storePatient(model : patient ){
        self.Patient = model
    }
    
    let covers : [String] = ["profile","Details","Drip Level","Pulse Rate","Temp","ECG"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = patientTableView.dequeueReusableCell(withIdentifier: "profile") as! ProfileTableViewCell
            
            
            self.sensor5.observe(.value){ (snapshot) in
                if let value = snapshot.value as? Int{
//                    print(value)
                    if value < 99{
                        self.Patient.status = pStatus.fine
                    }
                    else if (value >= 99 && value <= 100){
                        self.Patient.status = pStatus.moderate
                    }
                    else{
                        self.Patient.status = pStatus.crtical
                    }
                    cell.storePatient(model: self.Patient)
                }
            }
            return cell
        }
        else if indexPath.row == 1{
            let cell = patientTableView.dequeueReusableCell(withIdentifier: "Details") as! DetailTableViewCell
            return cell
        }
        else if indexPath.row == 2{
            let cell = patientTableView.dequeueReusableCell(withIdentifier: "Drip Level") as! DripTableViewCell
            let temp = [ "97.1 °F", "97.2 °F", "97.3 °F", "97.4 °F", "96.8 °F", "97.0 °F", "96.9 °F", "96.6 °F","96.7 °F"]
            
            func delayTemp(interval: TimeInterval, closure: @escaping () -> Void) {
                 DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                      closure()
                 }
               
            }
            
            delayTemp(interval: 1.5) {
                cell.BubbleFormed.text = temp.randomElement()
                
            }
            
            delayTemp(interval: 1.5) {
                cell.BubbleFormed.text = temp.randomElement()
                
            }
            
            delayTemp(interval: 1.5) {
                cell.BubbleFormed.text = temp.randomElement()
                
            }
            
            
            

            let drip = ["Active"]
            
            func delay(interval: TimeInterval, closure: @escaping () -> Void) {
                 DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                      closure()
                 }
            }

            delay(interval: 0.8) {
                cell.DripLevel.text = drip.randomElement()
            }
            
            delay(interval: 10) {
                cell.DripLevel.text = drip.randomElement()
            }
            
            self.sensor1.observe(.value){ (snapshot) in
                if let value = snapshot.value as? Int{
//                    print(value)
                    self.dripValue = "\(Float(value)/10)%"
                    
                }
            }
            self.sensor2.observe(.value){ (snapshot) in
                if let value = snapshot.value as? Int{
//                    print(value)
                    if value == 1{
                        cell.BubbleFormed.text = "YES"
                    }
                    else{
                        cell.BubbleFormed.text = "NO"
                    }
                }
            }
            return cell
        }
        else if indexPath.row == 3{
            let cell = patientTableView.dequeueReusableCell(withIdentifier: "Pulse Rate") as! PRTableViewCell
            
            let randomNumDouble  = Int.random(in: 93..<96)
            cell.O2Level.text = "\(randomNumDouble) %"
            self.sensor3.observe(.value){ (snapshot) in
                if let value = snapshot.value as? Int{
//                    print(value)
                    cell.O2Level.text = "\(value)%"
                }
            }
            
            let randomNumInt  = Int.random(in: 70..<100)
            cell.PulseRate.text = "\(randomNumInt)"
            self.sensor4.observe(.value){ (snapshot) in
                if let value = snapshot.value as? Int{
//                    print(value)
                    cell.PulseRate.text = "\(value)"
                }
            }
            return cell
        }
        else if indexPath.row == 4{
            let cell = patientTableView.dequeueReusableCell(withIdentifier: "Temp") as! TempTableViewCell
            self.sensor5.observe(.value){ (snapshot) in
                if let value = snapshot.value as? Int{
//                    print(value)
                    cell.Tempincel.text = "\((value-32)*5/9) C"
                    cell.TempInF.text = "\(value) F"
                }
            }
            return cell
        }
        else{
            let cell = patientTableView.dequeueReusableCell(withIdentifier: "ECG") as! ECGTableViewCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 255
        }
        else if indexPath.row == 1{
            return 182
        }
        else if indexPath.row == 2{
            return 138
        }
        else if indexPath.row == 3{
            return 138
        }
        else if indexPath.row == 4{
            return 110
        }
        else{
            return 138
        }
    }
    
}
