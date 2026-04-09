import UIKit

class SettingsViewController: UITableViewController {

    private let sections = ["通用", "关于"]
    private let items: [[String]] = [
        ["语言", "通知设置", "清除缓存"],
        ["版本信息", "隐私政策", "用户协议"],
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设置"
        view.backgroundColor = UIColor(red: 0.051, green: 0.051, blue: 0.059, alpha: 1.0)
        tableView.separatorColor = UIColor(white: 0.17, alpha: 1.0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = UIColor(red: 0.102, green: 0.102, blue: 0.118, alpha: 1.0)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
