//
//  MedicosViewController.swift
//  OncoManager
//
//  Created by Gabrielle Brandenburg dos Anjos on 7/26/16.
//  Copyright © 2016 Felipe Viberti. All rights reserved.
//

import UIKit

class MedicosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var edit = false
    var i = -1
    
    @IBOutlet weak var medTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        medTableView.delegate = self
        medTableView.dataSource = self
        medTableView.allowsSelection = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MedicosViewController.actOnNotificationSuccessDeleteMedico), name: "notificationSucessDeleteMedico", object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicos.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.medTableView.dequeueReusableCellWithIdentifier("medCell", forIndexPath: indexPath) as! MedicoCell
        cell.nomeMedico.text = medicos[indexPath.row].nome
        cell.email.text = medicos[indexPath.row].email
        cell.especialidade.text = medicos[indexPath.row].especialidade
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.stopEditing(_:)))
        cell.editar.tag = indexPath.row + 1
        cell.editar.addTarget(self, action: #selector(self.editarMedicoPressed(_:)), forControlEvents: .TouchUpInside)
        cell.contentView.addGestureRecognizer(tap)
        
        return cell
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            DaoCloudKit().deleteMedico(medicos[indexPath.row])
        }
    }
    func actOnNotificationSuccessDeleteMedico()
    {
        dispatch_async(dispatch_get_main_queue(),{
            self.medTableView.reloadData()
        })

    }
    
    func stopEditing(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func editarMedicoPressed(sender: UIButton){
        i = sender.tag - 1
        print("sender tag ===== \(i)")
        performSegueWithIdentifier("goToAddMedico", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToAddMedico" && i >= 0 {
            let destinationVC = segue.destinationViewController as! NovoMedicoViewController
            destinationVC.edit = true
            destinationVC.i = i
        }
    }
    
    @IBAction func addMedicoPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("goToAddMedico", sender: self)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        print("Entrou na appear")
        dispatch_async(dispatch_get_main_queue(),{
        self.medTableView.reloadData()
        })
    }

}
