import UIKit
import CoreTelephony

@objc public protocol MRCountryPickerDelegate {
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage)
}

public struct Country { // TODO takac added by me !!
    public var code: String?
    public var name: String?
    public var phoneCode: String?
    public var flag: UIImage? {
        guard let code = self.code else { return nil }
        return UIImage(named: "SwiftCountryPicker.bundle/Images/\(code.uppercased())", in: Bundle(for: MRCountryPicker.self), compatibleWith: nil)
    }

    init(code: String?, name: String?, phoneCode: String?) {
        self.code = code
        self.name = name
        self.phoneCode = phoneCode
    }
}

open class MRCountryPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    // TODO takac added by me !!
    var countriesCodesEU = ["BE", "BG", "CY", "CZ", "DK", "EE", "FI", "FR", "GR", "NL", "HR", "IE", "LT", "LV", "LU", "HU", "MT", "DE", "PL", "PT", "AT", "RO", "SK", "SI", "GB", "ES", "SE", "IT"]
    var onlyEU = false

    var countries: [Country]!
    open var selectedLocale: Locale?
    open weak var countryPickerDelegate: MRCountryPickerDelegate?
    open var showPhoneNumbers: Bool = true
    open var selectedCountry: Country? // TODO takac added by me !!
    
    override public init(frame: CGRect) { // TODO takac added by me !!
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    public init (frame: CGRect, onlyEU: Bool = false){ // TODO takac added by me !!
        super.init(frame: frame)
        self.onlyEU = onlyEU
        setup()
    }

    func setup() {
        countries = countryNamesByCode()

        if let code = Locale.current.languageCode {
            self.selectedLocale = Locale(identifier: code)
        }

        super.dataSource = self
        super.delegate = self
    }
    
    // MARK: - Locale Methods

    open func setLocale(_ locale: String) {
        self.selectedLocale = Locale(identifier: locale)
    }

    // MARK: - Country Methods
    
    open func setCountry(_ code: String) {
        for index in 0..<countries.count {
            if countries[index].code == code {
                return self.setCountryByRow(row: index)
            }
        }
    }

    open func setCountryByPhoneCode(_ phoneCode: String) {
        for index in 0..<countries.count {
            if countries[index].phoneCode == phoneCode {
                return self.setCountryByRow(row: index)
            }
        }
    }

    open func setCountryByName(_ name: String) {
        for index in 0..<countries.count {
            if countries[index].name == name {
                return self.setCountryByRow(row: index)
            }
        }
    }

    func setCountryByRow(row: Int) {
        self.selectRow(row, inComponent: 0, animated: true)
        let country = countries[row]
        self.selectedCountry = country // TODO takac added by me !!
        if let countryPickerDelegate = countryPickerDelegate {
            countryPickerDelegate.countryPhoneCodePicker(self, didSelectCountryWithName: country.name!, countryCode: country.code!, phoneCode: country.phoneCode!, flag: country.flag!)
        }
    }
    
    // Populates the metadata from the included json file resource
    
    func countryNamesByCode() -> [Country] {
        var countries = [Country]()
        let frameworkBundle = Bundle(for: type(of: self))
        guard let jsonPath = frameworkBundle.path(forResource: "SwiftCountryPicker.bundle/Data/countryCodes", ofType: "json"), let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
            return countries
        }
        
        do {
            if let jsonObjects = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray {

                    for jsonObject in jsonObjects {
                        
                        guard let countryObj = jsonObject as? NSDictionary else {
                            return countries
                        }
                        
                        guard let code = countryObj["code"] as? String, let phoneCode = countryObj["dial_code"] as? String, let name = countryObj["name"] as? String else {
                            return countries
                        }

                        let country = Country(code: code, name: name, phoneCode: phoneCode)
                        if self.onlyEU { // filter EU  TODO takac added by me !!
                            if self.countriesCodesEU.contains(code) {
                                countries.append(country)
                            }
                        } else {
                            countries.append(country)
                        }
                    }

                }
        } catch {
            return countries
        }
        return countries
    }
    
    // MARK: - Picker Methods
    
    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    open func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var resultView: SwiftCountryView
        
        if view == nil {
            resultView = SwiftCountryView()
        } else {
            resultView = view as! SwiftCountryView
        }
        
        resultView.setup(countries[row], locale: self.selectedLocale)
        if !showPhoneNumbers {
            resultView.countryCodeLabel.isHidden = true
        }
        return resultView
    }
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let country = countries[row]
        self.selectedCountry = country // TODO takac added by me !!
        if let countryPickerDelegate = countryPickerDelegate {
            countryPickerDelegate.countryPhoneCodePicker(self, didSelectCountryWithName: country.name!, countryCode: country.code!, phoneCode: country.phoneCode!, flag: country.flag!)
        }
    }
}
