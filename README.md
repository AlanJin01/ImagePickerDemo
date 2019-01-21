# ImagePickerDemo
This simple demo can pick up the photo from the album and add it to the TableView

此demo功能就是从相册里选取一张图，并添加到表格

![image](https://github.com/Kimsswift/ImagePickerDemo/blob/master/ImagePickerDemo/g1.gif)

代码:

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
