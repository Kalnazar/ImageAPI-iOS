import UIKit

final class ViewController: UIViewController {

    @IBOutlet var choosedImage: UIImageView!
    @IBOutlet weak var choosedCountry: UILabel!
    
    var results: [Result] = []
    var manager = Manager()
    var country = "switzerland"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegateSetValue = self
        fetchPhotos(query: country)
    }
    
    func fetchPhotos(query: String) {
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=30&query=\(query)&client_id=iBdu_JxBBTS4Y9P7Xmy4Rf-GpnPfSwVIQTO_WfiRTuA"
        
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self.results = jsonResult.results
                }
            }
            catch {
                print("Error!")
            }
        }
        task.resume()
    }
    
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.choosedImage.image = image
            }
        }.resume()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        let button = sender.tag
        let randomInt = Int.random(in: 0..<30)
        print(randomInt)
        
        if (button == 0){
            manager.setValue(isSwitzerland: true)
            fetchPhotos(query: country)
            configure(with: results[randomInt].urls.full)
        } else{
            manager.setValue(isSwitzerland: false)
            fetchPhotos(query: country)
            configure(with: results[randomInt].urls.full)
        }
    }
    
}

extension ViewController: SetValue{
    func setDelegate(country: String, title: String) {
        self.country = country
        self.choosedCountry.text = title
    }
}
