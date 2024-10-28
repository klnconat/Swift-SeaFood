
import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    let seafoodList = [
        "Salmon", "Tuna", "Cod", "Halibut", "Mackerel", "Sardine", "Trout", "Snapper", "Sea Bass", "Swordfish",
        "Flounder", "Haddock", "Grouper", "Barramundi", "Mahi Mahi", "Perch", "Pollock", "Pompano", "Sole", "Tilefish",
        "Anchovy", "Bluefish", "Monkfish", "Wahoo", "Tilapia", "Marlin", "Amberjack", "Rockfish", "Cobia", "Herring",
        "Kingfish", "Lingcod", "Shad", "Bonito", "Scup", "Croaker", "Parrotfish", "Eel", "Sturgeon", "Butterfish",
        "Shrimp", "Prawns", "Lobster", "Crab", "Blue Crab", "Snow Crab", "Dungeness Crab", "King Crab", "Soft-Shell Crab",
        "Crawfish", "Clams", "Mussels", "Oysters", "Scallops", "Abalone", "Conch", "Cockles", "Whelk", "Octopus",
        "Squid", "Cuttlefish", "Sea Urchin", "Sea Cucumber", "Jellyfish", "Krill", "Barnacles", "Sea Snails",
        "Langoustine", "Geoduck", "Arctic Char", "Rainbow Trout", "Yellowfin Tuna", "Bigeye Tuna", "Albacore Tuna",
        "Pacific Cod", "Atlantic Cod", "Sablefish", "Orange Roughy", "Red Mullet", "Dogfish", "Hake", "Black Drum",
        "White Bass", "Striped Bass", "Pacific Halibut", "Atlantic Halibut", "Yellowtail", "Tilefish", "Opah", "Skate",
        "Tilefish", "Wolffish", "Triggerfish", "Tautog", "Spiny Lobster", "Spanner Crab", "Jonah Crab", "Horse Mackerel",
        "Golden Tilefish", "Whiting", "Ling", "Red Snapper", "Ocean Perch", "Bigeye Snapper", "Mud Crab", "Mahi Mahi",
        "Sablefish", "Greenling", "Catfish", "Blue Marlin", "Pike", "Chub Mackerel", "Yellowtail Amberjack",
        "Rock Lobster", "Spider Crab", "Dab", "Atlantic Salmon", "Pacific Salmon", "Steelhead", "Silver Pomfret",
        "Threadfin", "Yellowtail Snapper", "European Eel", "Bream", "Porbeagle Shark", "Shortfin Mako Shark",
        "Leopard Shark", "Dogfish Shark", "Sea Bream", "Golden Pompano", "Coral Trout", "Spanish Mackerel",
        "Japanese Mackerel", "Saba", "Saury", "Silverside", "Smelt", "Weakfish", "Garfish", "Butterfish",
        "Whitefish", "Black Cod", "Ling", "Crayfish", "Northern Red Snapper", "Sand Dab", "Mullet", "Silverfish",
        "Tautog", "Hogfish", "Grunt", "Tilapia", "Wolf Fish"
    ]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else { 
                fatalError("Could not convert")
            }
            detect(image: ciimage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func detect(image: CIImage) {
        do {
            let config = MLModelConfiguration()
            let model = try VNCoreMLModel(for: Inceptionv3(configuration: config).model)
            // Model başarıyla yüklendiğinde devam edin
            
            let request = VNCoreMLRequest(model: model) { request, error in
                guard let result = request.results as? [VNClassificationObservation] else {
                    fatalError("Could not convert")
                }
                
                if let firstResult = result.first {
                    let identifierLowercased = firstResult.identifier.lowercased()
                    
                    if self.seafoodList.contains(where: { identifierLowercased.contains($0.lowercased()) }) {
                        self.navigationItem.title = "SeaFood"
                    } else {
                        self.navigationItem.title = "NOT SeaFood"
                    }
                }
                
            }
            
            let handler = VNImageRequestHandler(ciImage: image)
            
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
            
            
        } catch {
            fatalError("Loading CoreML model failed: \(error)")
        }
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
}

