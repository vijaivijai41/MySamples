
import UIKit
import AVFoundation

public enum CameraError: Error {
    case notAvailable
    
    var errorString : String {
        switch self {
        case .notAvailable:
            return "ImageNotAvailable"
        }
    }
}


public typealias CameraHandler = (Result<UIImage, CameraError>) -> ()

//MARK: CollectionViewCell For image load
class ImageCollection: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}



// MARK: Camera Controller for load camera view
class CameraController: UIViewController, AVCapturePhotoCaptureDelegate {

    @IBOutlet weak var retakeButton: UIButton!
    @IBOutlet weak var captureImageView: UIImageView!
    @IBOutlet weak var baseCamerView: UIView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var cameraRotateButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var captureDonebutton: UIButton!
    
    @IBOutlet weak var picturePreviewView: UIView!
    private var cameraActionHandler: CameraHandler?
    
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var galleryCollection: UICollectionView!
    
    var session: AVCaptureSession!
    var imageOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var images = [UIImage]() {
        didSet {
            DispatchQueue.main.async {
                self.galleryCollection.reloadData()
            }
        }
    }
    
    public static func loadCameraView()-> CameraController? {
        let bundle = Bundle.init(for: CameraController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let controller = storyboard.instantiateViewController(identifier: "CameraController") as? CameraController
        return controller
    }
    
    open class func showCustomCameraView(controller:UIViewController, completionHandler:CameraHandler?) {
        if let cameraView = CameraController.loadCameraView() {
            
            cameraView.addChildViewController(child: cameraView, parent: controller)
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: cameraView.galleryCollection.bounds.size.width / 3, height: cameraView.galleryCollection.bounds.size.height - 20)
            layout.scrollDirection = .horizontal
            cameraView.galleryCollection.collectionViewLayout = layout
            cameraView.cameraActionHandler = completionHandler
            cameraView.session = AVCaptureSession()
            cameraView.session?.sessionPreset = .medium
            cameraView.configureCameraView(position: .front)
            cameraView.flashButton.isHidden = true
            // Do any additional setup after loading the view.
        }
    }
    
    
    func addChildViewController(child:UIViewController , parent: UIViewController) {
        
//        child.view.center = view.center
//        child.view.alpha = 1
//        child.view.transform = CGAffineTransform(scaleX: 0.8, y: 1.2)
        
        parent.addChild(child)
        child.view.frame = UIScreen.main.bounds
        parent.view.addSubview(child.view)
        child.didMove(toParent: parent)
        
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],  animations: {
//        //use if you want to darken the background
//          //self.viewDim.alpha = 0.8
//          //go back to original form
//          child.view.transform = .identity
//        })
    }
    
    
    func removeChildController() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    @IBAction func doneButtonAction(_ sender: UIButton) {
        if let image = self.captureImageView.image {
            cameraActionHandler?(.success(image))
        } else {
            cameraActionHandler?(.failure(CameraError.notAvailable))
        }
        self.removeChildController()
        
    }
    @IBAction func retakeButton(_ sender: Any) {
        picturePreviewView.isHidden = true
        self.view.sendSubviewToBack(picturePreviewView)
        
//        viewContoller.willMove(toParent: nil)
//        viewContoller.view.removeFromSuperview()
//        viewContoller.removeFromParent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    /// Camera view update View
    func setupCameraPreview() {
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.videoOrientation = .portrait
        cameraView.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.session.startRunning()
            //Step 13
        }
        DispatchQueue.main.async {
            self.previewLayer.frame = self.cameraView.bounds
        }
    }
    
    /// Camera Camera change action
    /// - Parameter sender: Button action
    @IBAction func rotateButtonAction(_ sender: UIButton) {
        if let session = session {
            let currentCameraInput: AVCaptureInput = session.inputs[0]
            session.removeInput(currentCameraInput)
            var newCamera: AVCaptureDevice
            newCamera = AVCaptureDevice.default(for: AVMediaType.video)!
            
            if (currentCameraInput as! AVCaptureDeviceInput).device.position == .back {
                UIView.transition(with: self.cameraView, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                    newCamera = self.cameraWithPosition(.front)!
                    self.flashButton.isHidden = true
                }, completion: nil)
                
            } else {
                UIView.transition(with: self.cameraView, duration: 0.5, options: .transitionFlipFromRight, animations: {
                    newCamera = self.cameraWithPosition(.back)!
                    self.flashButton.isHidden = false
                }, completion: nil)
            }
            do {
                try self.session.addInput(AVCaptureDeviceInput(device: newCamera))
            }
            catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Camera view with position for Front and Back camera
    /// - Parameter position: Camera position
    func cameraWithPosition(_ position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let deviceDescoverySession = AVCaptureDevice.DiscoverySession.init(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        
        for device in deviceDescoverySession.devices {
            if device.position == position {
                return device
            }
        }
        return nil
    }
    
    /// Configire camera view for Position wise
    /// - Parameter position: AVCapture device position
    func configureCameraView(position: AVCaptureDevice.Position) {
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position:position) else { return }
        
        do {
            let input =  try AVCaptureDeviceInput(device: frontCamera)
            imageOutput = AVCapturePhotoOutput()
            if session.canAddInput(input) && session.canAddOutput(imageOutput)  {
                session.addInput(input)
                session.addOutput(imageOutput)
                self.setupCameraPreview()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /// Flash Button action
    /// - Parameter sender: Flash Button
    @IBAction func flashButtonAction(_ sender: Any) {
        flashOn(device:AVCaptureDevice.default(for: .video)!)
    }
    
    /// Camera capture button
    /// - Parameter sender: Camer action Button
    @IBAction func yesButtonDitTap(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        imageOutput.capturePhoto(with: settings, delegate: self)
    }
    
    /// Output for capture photo
    /// - Parameters:
    ///   - output: output image for load
    ///   - photo: Photo for image
    ///   - error: Error response
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = UIImage(data: imageData)
        picturePreviewView.isHidden = false
        self.view.bringSubviewToFront(picturePreviewView)
        captureImageView.image = image
//        if let _image = image {
//            self.images.append(_image)
//        }
    }
    
    /// Flash Action for on off
    /// - Parameter device: Device configuration
    private func flashOn(device:AVCaptureDevice) {
           do {
               try device.lockForConfiguration()
               if (device.hasTorch) {
                   device.torchMode = (device.torchMode == .on) ? .off : .on
               }
           } catch {
               //DISABEL FLASH BUTTON HERE IF ERROR
               print("Device tourch Flash Error ");
           }
           device.unlockForConfiguration()
       }
    // View will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //self.session.stopRunning()
    }
}


// Collection View DataSource and Delegate
extension CameraController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollection", for: indexPath) as! ImageCollection
        cell.imageView.image = images[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


