// Rem sample Code
import UIKit

class InputViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	var columnNames: [String]!
	var selectedDataTypes: [String]!

	override func viewDidLoad() {
    	super.viewDidLoad()

    	// Spaltennamen und Datentypen initialisieren
    	columnNames = ["Spaltenname 1", "Spaltenname 2", ...]
    	selectedDataTypes = ["VARCHAR", "INT", ...]

    	// Tabelle einrichten
    	tableView.dataSource = self
    	tableView.delegate = self
	}
}

extension InputViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    	return columnNames.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    	let cell = tableView.dequeueReusableCell(withIdentifier: "ColumnCell", for: indexPath)

    	cell.textLabel?.text = columnNames[indexPath.row]

    	let pickerView = UIPickerView()
    	pickerView.dataSource = self
    	pickerView.delegate = self
    	pickerView.tag = indexPath.row

    	cell.accessoryType = .detailDisclosureButton
    	cell.accessoryView = pickerView

    	return cell
	}
}

extension InputViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    	let pickerView = tableView.cellForRow(at: indexPath)?.accessoryView as! UIPickerView
    	pickerView.selectRow(selectedDataTypes[indexPath.row], inComponent: 0, animated: false)
	}
}

extension InputViewController: UIPickerViewDataSource {

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
    	return 1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    	return ["VARCHAR", "INT", "DOUBLE"].count
	}
}

extension InputViewController: UIPickerView

