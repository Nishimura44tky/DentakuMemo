//
//  MemoViewController.swift
//  Dentaku_Memo
//
//  Created by 西村拓也 on 2021/07/02.
//

import UIKit

class MemoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var memoTableView: UITableView!
    var memoArray = [String]()

    let ud = UserDefaults.standard

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoArray.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath)
        cell.textLabel?.text = memoArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: nil)
        //押したら押した状態を解除
        tableView.deselectRow(at: indexPath, animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        memoTableView.delegate = self
        memoTableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        loadMemo()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //destinationのクラッシュ防ぐ
        if segue.identifier == "toDetail"{
            //detailViewControllerを取得
            //as! DetailViewControllerでダウンキャストしている
            let detailViewController = segue.destination as! DetailViewController
            //遷移前に選ばれているCellが取得できる
            let selectedIndexPath = memoTableView.indexPathForSelectedRow!
            detailViewController.selectedMemo = memoArray[selectedIndexPath.row]
            detailViewController.selectedRow = selectedIndexPath.row
        }
    }
    func loadMemo(){
        if ud.array(forKey: "memoArray") != nil{
            //取得 またas!でアンラップしているのでnilじゃない時のみ
            memoArray = ud.array(forKey: "memoArray") as![String]
            //reloadしてくれる
            memoTableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {

            //resultArray内のindexPathのrow番目をremove（消去）する
            memoArray.remove(at: indexPath.row)

            //再びアプリ内に消去した配列を保存
            ud.set(memoArray, forKey: "memoArray")

            //tableViewを更新
            tableView.reloadData()
        }
    }
}

