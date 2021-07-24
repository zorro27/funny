//
//  ViewController.swift
//  Notes
//
//  Created by Роман Зобнин on 15.03.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableList: UITableView!
    
    var array = notesModel.shared.notes
    
    override func loadView() {
        super.loadView()
        
        if notesModel.shared.notes.count == 0 {
            let title = "Добро пожаловать в приложение Notes"
            let note = "Это Ваша первая заметка. Для добавления новой заметки нажмите +. Для редактирования существующей заметки нажмите на саму заметку. Для сохранения новой заметки или изменений, внесенных в заметку, нажмите Save. Для удаления заметки сделайте свайп влево. Удачи!"
            notesModel.shared.save(title: title, note: note)
            array.insert(notesModel.cellNote(title: title, note: note), at: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Notes"
        navigationController!.navigationBar.sizeToFit()
        tableList.tableFooterView = UIView.init(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model1 = array[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let vc = storyboard.instantiateViewController(identifier: "noteViewController") as? noteViewController else {return}
        
        tableList.deselectRow(at: indexPath, animated: true)
        vc.title = "Note"
        vc.num = indexPath.row
        vc.noteTitle = model1.title
        vc.note = model1.note
        vc.compleated = {noteTitle, note in
            self.navigationController?.popToRootViewController(animated: true)
            self.array.remove(at: indexPath.row)
            self.array.insert(notesModel.cellNote(title: noteTitle, note: note), at: indexPath.row)
            self.tableList.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            notesModel.shared.delete(a: indexPath.row)
            self.array.remove(at: indexPath.row)
            self.tableList.deleteRows(at: [indexPath], with: .automatic)
        }
        action.backgroundColor = .red
        return action
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    @IBAction func addNotes(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(identifier: "redactNoteViewController") as? redactNoteViewController else {return}
        vc.title = "New note"
        vc.complet = {noteTitle, note in
            self.navigationController?.popToRootViewController(animated: true)
            self.array.append(notesModel.cellNote(title: noteTitle, note: note))
            self.tableList.reloadData()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! noteTableViewCell
        let arr = array[indexPath.row]
        cell.textLabel?.text = arr.title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        cell.textLabel?.font = UIFont .boldSystemFont(ofSize: 20.0)
        cell.detailTextLabel?.text = arr.note
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 16)
        return cell
    }
}





