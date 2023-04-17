import UIKit

protocol UpdateBackgroundAfterEditingDelegate{
    func NewSelectedBackground(image: UIImage?)
}


class EditTripDetailedPageViewController: UIViewController {

    //let images = [UIImage(named: "trip_blank"), UIImage(named: "sight_blank")]
    
    var ThisCity: CityModel?
   
    var updateBackgroundDelegate: UpdateBackgroundAfterEditingDelegate?
     
    private var images = [UIImage]()
    var imgData = [Data?]()
    
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if imgData.isEmpty {
            images.insert(UIImage(named: "trip_blank")!, at: 0)
        }
        else{
            for data in imgData{
                images.insert(UIImage(data: data!)!, at: 0)
            }
        }
        
        var offsetY: CGFloat = 0
        scrollView.frame = CGRect(x: 10, y: 100, width: view.frame.width - 20, height: view.frame.height - 120)
        scrollView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        scrollView.contentSize = CGSize(width: view.frame.width - 20, height: offsetY)
 
        view.addSubview(scrollView)

        
        let buttonWidth: CGFloat = scrollView.frame.width - 20
        let buttonHeight: CGFloat = 550
        

        for i in 0..<images.count {
            let button = createButtonWithImage(images[i])
            button.tag = i
            button.frame = CGRect(x: 10, y: offsetY, width: buttonWidth, height: buttonHeight)
            scrollView.addSubview(button)
            offsetY += buttonHeight + 10
        }

        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: offsetY)
        
        // selectedItem != nil
            if let selectedImage = selectedImage {
                // find the exact radiobutton
                for button in scrollView.subviews {
                    if let button = button as? UIButton{
                        if let image = button.imageView?.image{
                            print("image = \(String(describing: image.pngData())), selectedImage = \(String(describing: selectedImage.pngData()))")
                            if(image.pngData() == selectedImage.pngData()){
                                buttonTapped(button) //click
                                break
                            }
                        }
                    }
                }
            }
       

    }

    func createButtonWithImage(_ image: UIImage) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: scrollView.subviews.count * 360, width: Int(scrollView.frame.width), height: 150)
        button.contentMode = .scaleAspectFit
        button.setImage(image, for: .normal)
        button.setImage(image.alpha(0.5), for: .selected)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }



    @objc func buttonTapped(_ sender: UIButton) {
        for button in scrollView.subviews {
            if let button = button as? UIButton {
                if button.tag == sender.tag {
                    button.isSelected = true
                    selectedImage = sender.imageView?.image
                } else {
                    button.isSelected = false
                }
            }
        }

        if sender.isSelected {
            self.view.contentMode = .scaleAspectFill
            self.view.backgroundColor = UIColor(patternImage: selectedImage?.alpha(0.5) ?? UIImage())
            
        } else {
            self.view.backgroundColor = UIColor.white
        }
    }
    
    var selectedImage: UIImage?
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if(ThisCity != nil){
            ThisCity?.CityDefaultBackgroundData = selectedImage?.pngData()
            TripList.updateProperties(city: ThisCity!)
        }
        updateBackgroundDelegate?.NewSelectedBackground(image: selectedImage)
        //navigationController?.popViewController(animated: true)
    }

    
    
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
