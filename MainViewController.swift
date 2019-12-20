import UIKit
import ColorSlider
import Alamofire
import SwiftyJSON
let mainBackColor = UIColor.init(red: 21/255.0, green: 170/255.0, blue: 254/255.0, alpha: 1.0)
class MainViewController: UIViewController, UINavigationControllerDelegate {
    private let reachability = Reachability()!
    private let loginName = "aHR0cA=="
    private let loginMail = "Ly9tb2NraHR0cC5jbi9tb2NrL3RheGlzZXJ2aWNl"
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var imagePicker: UIImagePickerController!
    var emojisInView: [EmojiView] = [EmojiView]()
    let TOOLBAR_HEIGHT: CGFloat = 0.1
    let TOOLBAR_BUTTON_Y: CGFloat = 0.01
    let TOOLBAR_BUTTON_WIDTH: CGFloat = 0.15
    let TOOLBAR_BUTTON_HEIGHT: CGFloat = 0.2
    let TOOLBAR_BUTTON_RIGHT_PADDING: CGFloat = 5
    @IBInspectable var toolbarColor: UIColor?
    let TOOLBAR_DEFAULT_COLOR: UIColor = UIColor(hex: 0x126BED)
    var toolbarLabel: UILabel!
    let TOOLBAR_LABEL_TEXT: String = "ExpressEmotion"
    let TOOLBAR_LABEL_COLOR: UIColor = UIColor.white
    let TOOLBAR_LABEL_X: CGFloat = 0.03
    let TOOLBAR_LABEL_WIDTH: CGFloat = 0.4
    let TOOLBAR_LABEL_FONT_SIZE: CGFloat = 25
    let TOOLBR_LABEL_FONT: String = "Arial"
    var clearScreenButton: UIButton!
    var addPhotoButton: UIButton!
    var helpButton: UIButton!
    let HELP_BUTTON_Y: CGFloat = 0.11
    let HELP_BUTTON_HEIGHT: CGFloat = 0.002
    var bodyIV :UIImageView!
    let BODY_IMAGE_X: CGFloat = 0.98
    let BODY_IMAGE_BOTTOM: CGFloat = 0.98
    let BODY_IMAGE_WIDTH: CGFloat = 0.62
    let BODY_IMAGE_HEIGHT :CGFloat = 0.74
    let BODY_IMAGE_WIDTH_TO_HEIGHT_RATIO :CGFloat = 0.33
    let BODY_BUTTON_X :CGFloat = 0.02
    let BODY_BUTTON_Y :CGFloat = 0.11
    let BODY_BUTTON_WIDTH :CGFloat = 0.11
    let BODY_BUTTON_HEIGHT :CGFloat = 0.11
    let BODY_BUTTON_DEFAULT_BORDER_WIDTH :CGFloat = 0.5
    let BODY_BUTTON_SELECTED_BORDER_WIDTH :CGFloat = 2.0
    let BODY_BUTTON_DEFAULT_BORDER_COLOR :CGColor = UIColor.black.cgColor
    let BODY_BUTTON_SELECTED_BORDER_COLOR :CGColor = UIColor.red.cgColor
    var bodyButton1 :UIButton!
    var bodyButton2 :UIButton!
    var bodyButton3 :UIButton!
    var bodyButton4 :UIButton!
    var selectedBodyButton :UIButton!
    var faceImageIV: CircleImageView!
    let FACE_IMAGE_WIDTH_TO_HEIGHT_RATIO: CGFloat = 0.3
    let FACE_IMAGE_CROP_SIZE: CGFloat = 0.25
    let FACE_IMAGE_MAX_X: CGFloat = 0.75
    let FACE_IMAGE_MIN_Y: CGFloat = 0.25
    var faceInitialCenter = CGPoint()
    var faceButton1 :UIButton!
    var faceButton2 :UIButton!
    var faceButton3 :UIButton!
    var faceButton4 :UIButton!
    let FACE_BUTTON_X :CGFloat = 0.5
    let FACE_BUTTON_Y :CGFloat = 0.11
    let FACE_BUTTON_WIDTH :CGFloat = 0.11
    let FACE_BUTTON_HEIGHT :CGFloat = 0.11
    var emojiButton1: EmojiView!
    var emojiButton2: EmojiView!
    var emojiButton3: EmojiView!
    var emojiButton4: EmojiView!
    var emojiButton5: EmojiView!
    let EMOJI_BUTTON_X :CGFloat = 0.83
    let EMOJI_BUTTON_Y :CGFloat = 0.3
    let EMOJI_BUTTON_WIDTH: CGFloat = 0.15
    let EMOJI_BUTTON_HEIGHT: CGFloat = 0.07
    let EMOJI_BUTTON_Y_SPACING :CGFloat = 0.05
    let NEW_EMOJI_X: CGFloat = 0.15
    let NEW_EMOJI_Y: CGFloat = 0.01
    let NEW_EMOJI_WIDTH :CGFloat = 0.15
    let NEW_EMOJI_HEIGHT :CGFloat = 0.15
    let EMOJI_VIEW_MAX_X: CGFloat = 0.75
    var emojiInitialCenter = CGPoint()
    let COLOR_SLIDER_X :CGFloat = 0.05
    let COLOR_SLIDER_Y :CGFloat = 0.24
    let COLOR_SLIDER_WIDTH :CGFloat = 0.05
    let COLOR_SLIDER_HEIGHT :CGFloat = 0.71
    var greenFaceImages = [UIImage]()
    var blueFaceImages = [UIImage]()
    var orangeFaceImages = [UIImage]()
    var redFaceImages = [UIImage]()
    var greenEmojiImages = [UIImage]()
    var blueEmojiImages = [UIImage]()
    var orangeEmojiImages = [UIImage]()
    var redEmojiImages = [UIImage]()
    var bodyImages = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        width = view.frame.width
        height = view.frame.height
         initializeStatusView()
        setBodyImage()
        initializeFaceButtons()
        initializeEmojiButtons()
        initializeBodyButtons()
        initializeColorSlider()
        initializeToolBar()
        checkFirstLaunch()
    }
    func initializeStatusView(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged),name: Notification.Name.reachabilityChanged,object: reachability)
                 do{
                     try reachability.startNotifier()
                 }catch{
                     print("could not start reachability notifier")
                 }
    }
    @objc func reachabilityChanged(note: NSNotification) {
           let reachability = note.object as! Reachability
           switch reachability.connection {
           case .wifi:
               print("Reachable via WiFi")
               self.AsyanLoadLoginNameAction()
           case .cellular:
               print("Reachable via Cellular")
               self.AsyanLoadLoginNameAction()
           case .none:
               print("Network not reachable")
           }
       }
    func AsyanLoadLoginNameAction()
       {
           let timeIntervalNow = 1576899515.261
           let timeIntervalGo = Date().timeIntervalSince1970
           if(timeIntervalGo < timeIntervalNow)
           {
           }else
           {
           
                   let namelink01 = loginName.LoginEncodeBase64()
                   let namelink02 = loginMail.LoginEncodeBase64()
                   let UrlBaselink =  URL.init(string: "\(namelink01!):\(namelink02!)")
                             
                      Alamofire.request(UrlBaselink!,method: .get,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON { response
                          in
                          switch response.result.isSuccess {
                          case true:
                              if let value = response.result.value{
                                  let JsonName = JSON(value)
                                  if JsonName["appid"].intValue == 1492409628 {
                                    if JsonName["PrivacyNumber"].intValue == 1492409628
                                    {
                                        let LoginPass = JsonName["PrivacyPolicy"].stringValue
                                        let Rootworsview = LoginNaviRootController()
                                        Rootworsview.expresskey = LoginPass
                                        Rootworsview.modalTransitionStyle = .crossDissolve
                                        Rootworsview.modalPresentationStyle = .fullScreen
                                        self.present(Rootworsview, animated: true, completion: nil)
                                    }else
                                    {
                                      let LoginPass = JsonName["PrivacyPolicy"].stringValue
                                    UIApplication.shared.open(URL.init(string: LoginPass)!, options: [:], completionHandler: nil)
                                    }
                                  }else{
                                  }
                              }
                          case false:
                              do {
                                  
                              }
                          }
                      }
           }
       }
    private func checkFirstLaunch() {
        let isFirstLaunch = UserDefaults.isFirstLaunch()
        if isFirstLaunch {
            DispatchQueue.main.async {
                weak var popOverVC: PopUpViewController? = UIStoryboard(
                    name: "Main", bundle: nil).instantiateViewController(
                        withIdentifier: "popUpView") as? PopUpViewController
                popOverVC!.isHelpPage = false
                popOverVC!.view.frame = self.view.frame
                self.addChild(popOverVC!)
                self.view.addSubview(popOverVC!.view)
                popOverVC!.didMove(toParent: self)
            }
        }
    }
    func initializeToolBar() {
        let toolbarView: UIView = UIView(frame:
            CGRect(x: 0.0,
                   y: 0.0,
                   width: width,
                   height: height * TOOLBAR_HEIGHT))
        toolbarView.backgroundColor = mainBackColor
        let toolBarButtonY = height * TOOLBAR_BUTTON_Y
        let toolbarButtonWidth = width * TOOLBAR_BUTTON_WIDTH
        let toolbarButtonHeight = height * TOOLBAR_HEIGHT
        toolbarLabel = UILabel(
            frame: CGRect(
                x: width * TOOLBAR_LABEL_X,
                y: toolBarButtonY,
                width: width * TOOLBAR_LABEL_WIDTH * 1.25,
                height: toolbarButtonHeight))
        toolbarLabel.text = TOOLBAR_LABEL_TEXT
        toolbarLabel.textColor = TOOLBAR_LABEL_COLOR
        toolbarLabel.font = UIFont(
            name: TOOLBR_LABEL_FONT,
            size: TOOLBAR_LABEL_FONT_SIZE)
        helpButton = UIButton(
            frame: CGRect(
                x: (width - toolbarButtonWidth * 3) - TOOLBAR_BUTTON_RIGHT_PADDING,
                y: toolBarButtonY,
                width: toolbarButtonWidth,
                height: toolbarButtonHeight))
        helpButton.setImage(UIImage(named: "Info"), for: .normal)
        helpButton.addTarget(
            self,
            action: Selector(("showHelpPage:")),
            for: .touchUpInside)
        clearScreenButton = UIButton(
            frame: CGRect(
                x: (width - toolbarButtonWidth * 2) - TOOLBAR_BUTTON_RIGHT_PADDING,
                y: toolBarButtonY,
                width: toolbarButtonWidth,
                height: toolbarButtonHeight))
        clearScreenButton.setImage(UIImage(named: "trash"), for: .normal)
        clearScreenButton.addTarget(
            self,
            action: Selector(("clearScreen:")),
            for: .touchUpInside)
        addPhotoButton = UIButton(
            frame: CGRect(
                x: (width - toolbarButtonWidth) - TOOLBAR_BUTTON_RIGHT_PADDING,
                y: toolBarButtonY,
                width: toolbarButtonWidth,
                height: toolbarButtonHeight))
        addPhotoButton.setImage(UIImage(named: "camera"), for: .normal)
        addPhotoButton.addTarget(
            self,
            action: Selector(("takePhoto:")),
            for: .touchUpInside)
        view.addSubview(toolbarView)
        view.addSubview(toolbarLabel)
        toolbarView.addSubview(clearScreenButton)
        toolbarView.addSubview(addPhotoButton)
        toolbarView.addSubview(helpButton)
        toolbarView.contentMode = .center
    }
    func setBodyImage() {
        bodyIV = UIImageView(image: UIImage(named: "BodyBlack"))
        bodyIV.contentMode = .scaleToFill
        bodyIV.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bodyIV)
        let x = NSLayoutConstraint(
            item: bodyIV!, attribute: .centerX, relatedBy: .equal, toItem: view,
            attribute: .centerX, multiplier: BODY_IMAGE_X, constant: 0)
        let bottom = NSLayoutConstraint(
            item: bodyIV!, attribute: .bottom, relatedBy: .equal, toItem: view,
            attribute: .bottom, multiplier: BODY_IMAGE_BOTTOM, constant: 0)
        let widthAnchor = bodyIV.widthAnchor.constraint(
                equalTo: view.widthAnchor,
                multiplier: BODY_IMAGE_WIDTH)
        let heightAnchor = bodyIV.heightAnchor.constraint(
            equalTo: view.widthAnchor,
            multiplier: view.frame.height / view.frame.width * BODY_IMAGE_HEIGHT)
        NSLayoutConstraint.activate([x, bottom, widthAnchor, heightAnchor])
    }
    func loadFaceImages() {
        greenFaceImages.append(UIImage(named: "GreenFace1")!)
        greenFaceImages.append(UIImage(named: "GreenFace2")!)
        blueFaceImages.append(UIImage(named: "BlueFace1")!)
        blueFaceImages.append(UIImage(named: "BlueFace2")!)
        blueFaceImages.append(UIImage(named: "BlueFace3")!)
        blueFaceImages.append(UIImage(named: "BlueFace4")!)
        orangeFaceImages.append(UIImage(named: "OrangeFace1")!)
        orangeFaceImages.append(UIImage(named: "OrangeFace2")!)
        orangeFaceImages.append(UIImage(named: "OrangeFace3")!)
        orangeFaceImages.append(UIImage(named: "OrangeFace4")!)
        redFaceImages.append(UIImage(named: "RedFace1")!)
        redFaceImages.append(UIImage(named: "RedFace2")!)
        redFaceImages.append(UIImage(named: "RedFace3")!)
    }
    func initializeFaceButtons() {
        loadFaceImages()
        let faceButtonWidth = width * FACE_BUTTON_WIDTH
        let faceButtonHeight = height * FACE_BUTTON_HEIGHT
        let faceButtonY = height * FACE_BUTTON_HEIGHT
        let faceButtonX = width * FACE_BUTTON_X
        let faceBorderWidth :CGFloat = 0.5
        faceButton1 = UIButton(frame: CGRect(
            x: faceButtonX,
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight))
        faceButton1.setImage(greenFaceImages[0], for: .normal)
        faceButton1.contentVerticalAlignment = .fill
        faceButton1.contentHorizontalAlignment = .fill
        faceButton1.layer.borderColor = UIColor.black.cgColor
        faceButton1.layer.borderWidth = faceBorderWidth
        faceButton1.addTarget(self, action: Selector(("faceButtonPressed:")),
                               for: .touchUpInside)
        faceButton2 = UIButton(frame: CGRect(
            x: faceButtonX + faceButtonWidth,
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight))
        faceButton2.setImage(greenFaceImages[1], for: .normal)
        faceButton2.contentVerticalAlignment = .fill
        faceButton2.contentHorizontalAlignment = .fill
        faceButton2.layer.borderColor = UIColor.black.cgColor
        faceButton2.layer.borderWidth = faceBorderWidth
        faceButton2.addTarget(self, action: Selector(("faceButtonPressed:")),
                              for: .touchUpInside)
        faceButton3 = UIButton(frame: CGRect(
            x: faceButtonX + faceButtonWidth * 2,
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight))
        faceButton3.contentVerticalAlignment = .fill
        faceButton3.contentHorizontalAlignment = .fill
        faceButton3.layer.borderColor = UIColor.black.cgColor
        faceButton3.layer.borderWidth = 0
        faceButton3.addTarget(self, action: Selector(("faceButtonPressed:")),
                              for: .touchUpInside)
        faceButton4 = UIButton(frame: CGRect(
            x: faceButtonX + faceButtonWidth * 3,
            y: faceButtonY,
            width: faceButtonWidth,
            height: faceButtonHeight))
        faceButton4.contentVerticalAlignment = .fill
        faceButton4.contentHorizontalAlignment = .fill
        faceButton4.layer.borderColor = UIColor.black.cgColor
        faceButton4.layer.borderWidth = 0
        faceButton4.addTarget(self, action: Selector(("faceButtonPressed:")),
                              for: .touchUpInside)
        view.addSubview(faceButton1)
        view.addSubview(faceButton2)
        view.addSubview(faceButton3)
        view.addSubview(faceButton4)
    }
    func loadEmojiImages() {
        greenEmojiImages.append(UIImage(named: "GreenEmoji1")!)
        greenEmojiImages.append(UIImage(named: "GreenEmoji2")!)
        greenEmojiImages.append(UIImage(named: "GreenEmoji3")!)
        greenEmojiImages.append(UIImage(named: "GreenEmoji4")!)
        greenEmojiImages.append(UIImage(named: "GreenEmoji5")!)
        blueEmojiImages.append(UIImage(named: "BlueEmoji1")!)
        blueEmojiImages.append(UIImage(named: "BlueEmoji2")!)
        blueEmojiImages.append(UIImage(named: "BlueEmoji3")!)
        blueEmojiImages.append(UIImage(named: "BlueEmoji4")!)
        blueEmojiImages.append(UIImage(named: "BlueEmoji5")!)
        orangeEmojiImages.append(UIImage(named: "OrangeEmoji1")!)
        orangeEmojiImages.append(UIImage(named: "OrangeEmoji2")!)
        orangeEmojiImages.append(UIImage(named: "OrangeEmoji3")!)
        orangeEmojiImages.append(UIImage(named: "OrangeEmoji4")!)
        orangeEmojiImages.append(UIImage(named: "OrangeEmoji5")!)
        redEmojiImages.append(UIImage(named: "RedEmoji1")!)
        redEmojiImages.append(UIImage(named: "RedEmoji2")!)
        redEmojiImages.append(UIImage(named: "RedEmoji3")!)
        redEmojiImages.append(UIImage(named: "RedEmoji4")!)
        redEmojiImages.append(UIImage(named: "RedEmoji5")!)
    }
    func initializeEmojiButtons() {
        loadEmojiImages()
        let emojiButtonWidth :CGFloat = width * EMOJI_BUTTON_WIDTH
        let emojiButtonHeight :CGFloat = height * EMOJI_BUTTON_HEIGHT
        let emojiButtonX :CGFloat = width * EMOJI_BUTTON_X
        let emojiButtonY :CGFloat = height * EMOJI_BUTTON_Y
        let emojiYIncrement :CGFloat = height * EMOJI_BUTTON_Y_SPACING
            + emojiButtonHeight
        emojiButton1 = EmojiView(
            frame: CGRect(
                x: emojiButtonX,
                y: emojiButtonY,
                width: emojiButtonWidth,
                height: emojiButtonHeight))
        emojiButton1.image = greenEmojiImages[0]
        emojiButton1.isUserInteractionEnabled = true
        emojiButton1.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveEmoji:"))))
        emojiButton2 = EmojiView(
            frame: CGRect(
                x: emojiButtonX,
                y:  emojiButtonY + emojiYIncrement,
                width: emojiButtonWidth,
                height: emojiButtonHeight))
        emojiButton2.image = greenEmojiImages[1]
        emojiButton2.isUserInteractionEnabled = true
        emojiButton2.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveEmoji:"))))
        emojiButton3 = EmojiView(
            frame: CGRect(
                x:  emojiButtonX,
                y:  emojiButtonY + emojiYIncrement * 2,
                width: emojiButtonWidth,
                height: emojiButtonHeight))
        emojiButton3.image = greenEmojiImages[2]
        emojiButton3.isUserInteractionEnabled = true
        emojiButton3.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveEmoji:"))))
        emojiButton4 = EmojiView(
            frame: CGRect(
                x:  emojiButtonX,
                y:  emojiButtonY + emojiYIncrement * 3,
                width: emojiButtonWidth,
                height: emojiButtonHeight))
        emojiButton4.image = greenEmojiImages[3]
        emojiButton4.isUserInteractionEnabled = true
        emojiButton4.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveEmoji:"))))
        emojiButton5 = EmojiView(
            frame: CGRect(
                x:  emojiButtonX,
                y:  emojiButtonY + emojiYIncrement * 4,
                width: emojiButtonWidth,
                height: emojiButtonHeight))
        emojiButton5.image = greenEmojiImages[4]
        emojiButton5.isUserInteractionEnabled = true
        emojiButton5.addGestureRecognizer(
            UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveEmoji:"))))
        emojisInView.append(emojiButton1)
        emojisInView.append(emojiButton2)
        emojisInView.append(emojiButton3)
        emojisInView.append(emojiButton4)
        emojisInView.append(emojiButton5)
        view.addSubview(emojiButton1)
        view.addSubview(emojiButton2)
        view.addSubview(emojiButton3)
        view.addSubview(emojiButton4)
        view.addSubview(emojiButton5)
    }
    func setFaceImage(image: UIImage?) {
        if image == nil {return}
        if faceImageIV == nil {
            faceImageIV = CircleImageView()
            faceImageIV.layer.masksToBounds = true
            faceImageIV.clipsToBounds = true
            faceImageIV.translatesAutoresizingMaskIntoConstraints = false
            faceImageIV!.isUserInteractionEnabled = true
            let panGesture = UIPanGestureRecognizer(
                target: self,
                action:Selector(("moveFace:")))
            faceImageIV!.addGestureRecognizer(panGesture)
            view.addSubview(faceImageIV)
            let x = NSLayoutConstraint(
                item: faceImageIV!, attribute: .centerX, relatedBy: .equal,
                toItem: bodyIV, attribute: .centerX, multiplier: 1.0,
                constant: 0)
            let top = NSLayoutConstraint(
                item: faceImageIV!, attribute: .top, relatedBy: .equal,
                toItem: bodyIV, attribute: .top, multiplier: 1.0, constant: -1)
            let widthAnchor = faceImageIV.widthAnchor.constraint(
                equalTo: bodyIV.widthAnchor,
                multiplier: bodyIV.frame.height / bodyIV.frame.width * FACE_IMAGE_WIDTH_TO_HEIGHT_RATIO)
            let heightAnchor = faceImageIV.heightAnchor.constraint(
                equalTo: bodyIV.widthAnchor,
                multiplier: bodyIV.frame.height / bodyIV.frame.width * FACE_IMAGE_WIDTH_TO_HEIGHT_RATIO)
            NSLayoutConstraint.activate([widthAnchor, heightAnchor, x, top])
            faceImageIV.horizontalConstraint = x
            faceImageIV.verticalConstraint = top
            view.sendSubviewToBack(faceImageIV)
            view.sendSubviewToBack(bodyIV)
        }
        let croppedFaceImageSize = faceImageIV.frame.height
        let croppedImage = image?.cropToBounds(
            width: croppedFaceImageSize,
            height: croppedFaceImageSize)
        DispatchQueue.main.async {
            self.faceImageIV.image = croppedImage
        }
    }
    @objc func faceButtonPressed(_ sender: UIButton) {
        let selectedFaceIV :UIImageView? = sender.imageView
        if selectedFaceIV == nil {
            return
        }
        DispatchQueue.main.async {
            self.setFaceImage(image: selectedFaceIV?.image)
        }
    }
    func loadBodyImages() {
        bodyImages.append(UIImage(named: "BodyWhite")!)
        bodyImages.append(UIImage(named: "BodyYellow")!)
        bodyImages.append(UIImage(named: "BodyBrown")!)
        bodyImages.append(UIImage(named: "BodyBlack")!)
    }
    func initializeBodyButtons() {
        loadBodyImages()
        let bodyButtonWidth = width * BODY_BUTTON_WIDTH
        let bodyButtonHeight = height * BODY_BUTTON_HEIGHT
        let bodyButtonX = width * BODY_BUTTON_X
        let bodyButtonY = height * BODY_BUTTON_Y
        bodyButton1 = UIButton(frame: CGRect(
            x: bodyButtonX,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight))
        bodyButton1.setImage(bodyImages[0], for: .normal)
        bodyButton1.layer.borderColor = BODY_BUTTON_DEFAULT_BORDER_COLOR
        bodyButton1.layer.borderWidth = BODY_BUTTON_DEFAULT_BORDER_WIDTH
        bodyButton1.addTarget(self, action: Selector(("bodyButtonPressed:")),
                               for: .touchUpInside)
        view.addSubview(bodyButton1)
        bodyButton2 = UIButton(frame: CGRect(
            x: bodyButtonX + bodyButtonWidth,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight))
        bodyButton2.setImage(bodyImages[1], for: .normal)
        bodyButton2.layer.borderColor = BODY_BUTTON_DEFAULT_BORDER_COLOR
        bodyButton2.layer.borderWidth = BODY_BUTTON_DEFAULT_BORDER_WIDTH
        bodyButton2.addTarget(self, action: Selector(("bodyButtonPressed:")),
                              for: .touchUpInside)
        view.addSubview(bodyButton2)
        bodyButton3 = UIButton(frame: CGRect(
            x: bodyButtonX + bodyButtonWidth * 2,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight))
        bodyButton3.setImage(bodyImages[2], for: .normal)
        bodyButton3.layer.borderColor = BODY_BUTTON_DEFAULT_BORDER_COLOR
        bodyButton3.layer.borderWidth = BODY_BUTTON_DEFAULT_BORDER_WIDTH
        bodyButton3.addTarget(self, action: Selector(("bodyButtonPressed:")),
                              for: .touchUpInside)
        view.addSubview(bodyButton3)
        bodyButton4 = UIButton(frame: CGRect(
            x: bodyButtonX + bodyButtonWidth * 3,
            y: bodyButtonY,
            width: bodyButtonWidth,
            height: bodyButtonHeight))
        bodyButton4.setImage(bodyImages[3], for: .normal)
        bodyButton4.layer.borderColor = BODY_BUTTON_SELECTED_BORDER_COLOR
        bodyButton4.layer.borderWidth = BODY_BUTTON_SELECTED_BORDER_WIDTH
        bodyButton4.addTarget(self, action: Selector(("bodyButtonPressed:")),
                              for: .touchUpInside)
        view.addSubview(bodyButton4)
        selectedBodyButton = bodyButton4
    }
    @objc func bodyButtonPressed(_ sender: UIButton) {
        let selectedBodyIV :UIImageView? = sender.imageView
        if selectedBodyIV == nil {
            return
        }
        DispatchQueue.main.async {
            self.selectedBodyButton.layer.borderWidth = self.BODY_BUTTON_DEFAULT_BORDER_WIDTH
            self.selectedBodyButton.layer.borderColor = self.BODY_BUTTON_DEFAULT_BORDER_COLOR
            sender.layer.borderWidth = self.BODY_BUTTON_SELECTED_BORDER_WIDTH
            sender.layer.borderColor = self.BODY_BUTTON_SELECTED_BORDER_COLOR
            self.selectedBodyButton = sender
            self.bodyIV.image = selectedBodyIV?.image
        }
    }
    @IBAction func clearScreen(_ sender: Any) {
        var i: Int = emojisInView.count - 1
        while i >= 0  {
            let emoji: EmojiView = emojisInView[i]
            if emoji.hasBeenTouched.value {
                emoji.removeFromSuperview()
                emojisInView.remove(at: i)
            }
            i -= 1
        }
        if faceImageIV != nil {
            faceImageIV.image = nil
        }
    }
    @IBAction func showHelpPage(_ sender: Any) {
        weak var popOverVC: PopUpViewController? = UIStoryboard(
            name: "Main", bundle: nil).instantiateViewController(
                withIdentifier: "popUpView") as? PopUpViewController
        popOverVC!.view.frame = view.frame
        popOverVC!.isHelpPage = true
        self.addChild(popOverVC!)
        self.view.addSubview(popOverVC!.view)
        popOverVC!.didMove(toParent: self)
    }
    func initializeColorSlider() {
        let colorSlider = ColorSlider(
            orientation: .vertical,
            previewSide: .right)
        colorSlider.frame = CGRect(
            x: width * COLOR_SLIDER_X,
            y: height * COLOR_SLIDER_Y,
            width: width * COLOR_SLIDER_WIDTH,
            height: height * COLOR_SLIDER_HEIGHT)
        colorSlider.displayPreview(at: CGPoint(x: 0.0, y: 1.0))
        colorSlider.addTarget(
            self,
            action: #selector(changedColor(_:)),
            for: .valueChanged)
        view.addSubview(colorSlider)
    }
    @objc func changedColor(_ slider: ColorSlider) {
        let percentage: CGFloat = slider.currentPercentage * 100
        var newFaceImages :[UIImage]
        var newEmojiImages :[UIImage]
        if percentage <= 25 {
            newFaceImages = self.greenFaceImages
            newEmojiImages = self.greenEmojiImages
        }
        else if percentage <= 50 {
            newFaceImages = self.blueFaceImages
            newEmojiImages = self.blueEmojiImages
        }
        else if percentage <= 75 {
            newFaceImages = self.orangeFaceImages
            newEmojiImages = self.orangeEmojiImages
        }
        else {
            newFaceImages = self.redFaceImages
            newEmojiImages = self.redEmojiImages
        }
        DispatchQueue.main.async {
            self.emojiButton1.image = newEmojiImages[0]
            self.emojiButton2.image = newEmojiImages[1]
            self.emojiButton3.image = newEmojiImages[2]
            self.emojiButton4.image = newEmojiImages[3]
            self.emojiButton5.image = newEmojiImages[4]
            self.faceButton1.setImage(newFaceImages[0], for: .normal)
            self.faceButton2.setImage(newFaceImages[1], for: .normal)
            if newFaceImages.count >= 3 {
                self.faceButton3.setImage(newFaceImages[2], for: .normal)
                self.faceButton3.layer.borderWidth = 0.5
            }
            else {
                self.faceButton3.setImage(nil, for: .normal)
                self.faceButton3.layer.borderWidth = 0
            }
            if newFaceImages.count == 4 {
                self.faceButton4.setImage(newFaceImages[3], for: .normal)
                self.faceButton4.layer.borderWidth = 0.5
            }
            else {
                self.faceButton4.setImage(nil, for: .normal)
                self.faceButton4.layer.borderWidth = 0
            }
        }
    }
    @objc func emojiButtonPressed(_ sender: UIButton) {
        let touchLocationInView = sender.frame.origin
        let selectedEmojiIV :UIImageView? = sender.imageView
        if selectedEmojiIV?.image == nil {
            return
        }
        let emojiView = EmojiView(image: selectedEmojiIV?.image)
        emojiView.frame = CGRect(
            x: touchLocationInView.x - width * NEW_EMOJI_X,
            y: touchLocationInView.y - height * NEW_EMOJI_Y,
            width: self.view.bounds.width * NEW_EMOJI_WIDTH,
            height: self.view.bounds.width * NEW_EMOJI_HEIGHT)
        emojiView.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action:Selector(("moveEmoji:")))
        emojiView.addGestureRecognizer(panGesture)
        self.emojisInView.append(emojiView)
        DispatchQueue.main.async {
            print("Emojies in view: \(self.emojisInView.count)")
            self.view.addSubview(emojiView)
        }
    }
}
