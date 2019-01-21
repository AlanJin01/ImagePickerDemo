//
//  ViewController.swift
//  ImagePickerDemo
//
//  Created by J K on 2019/1/21.
//  Copyright © 2019 KimsStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    private var imagePicker: UIImagePickerController!
    private var tableView: UITableView!

    private var pictures: [UIImage] = [UIImage]() //用来保存图集
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let screen = UIScreen.main.bounds
        
        tableView = UITableView(frame: CGRect(x: 0, y: 80, width: screen.width, height: screen.height - 80))
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        btn.center = CGPoint(x: screen.width/2, y: 40)
        btn.setTitle("Pictures", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.3358535532, green: 0.5258932967, blue: 1, alpha: 1)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.layer.cornerRadius = 15
        btn.addTarget(self, action: #selector(ViewController.buttonFunc), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    //进入相册
    @objc func buttonFunc() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.navigationBar.barTintColor = #colorLiteral(red: 0.3358535532, green: 0.5258932967, blue: 1, alpha: 1)
        imagePicker.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imagePicker.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
        
        //以模态的方式弹出相册
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    //======================================== ImagePicker相关 ================================================================
    //用户在相册中，选择图后调用该方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //配置警告窗口
        let alertControl = UIAlertController(title: "确认选择该图?", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        //配置警告窗口按钮1
        let ok = UIAlertAction(title: "是", style: UIAlertAction.Style.default) { (action: UIAlertAction) in
            //获取原图
            let pic = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            //把获取的图添加到数组pictures中
            self.pictures.append(pic!)
            
            //更新列表
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            //返回主页
            self.dismiss(animated: true, completion: nil)
        }
        //配置警告窗口按钮2
        let cancel = UIAlertAction(title: "否", style: .destructive, handler: nil)
        
        alertControl.addAction(ok)
        alertControl.addAction(cancel)
        
        //在UIImagePickerController控制器中, 以模态方式弹出警告窗口
        picker.present(alertControl, animated: true, completion: nil)
    }
    
    //点击Cancel时返回主页
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
 
    
    //========================================= TableView相关 ================================================================
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "ReusedCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableViewCell
        if cell == nil {
            cell = TableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell!.selectionStyle = .none
        
        cell!.imgView.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width - 100, height: 180)
        cell!.imgView.center.x = tableView.bounds.width/2
        cell!.imgView.center.y = 100
    
        if pictures.count > 0 {
            cell!.imgView.image = self.pictures[indexPath.row]
        }
        return cell!
    }
}

