//
//  UIString+Extension.swift
//  LyberCrypto
//
//  Created by Rahul's Mac on 27/08/21.
//

import Foundation
import UIKit

extension String{
    
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    ///        "abcd".hasNumbers -> false
    ///        "123abc".hasNumbers -> true
    var hasNumbers: Bool {
          return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
      }
    
    ///        "123abc".hasLetters -> true
    ///        "123".hasLetters -> false
    var hasLetters: Bool {
        return rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
    }
    
    ///        "Hello 😀".containEmoji -> true
    var containEmoji: Bool {
        // http://stackoverflow.com/questions/30757193/find-out-if-character-in-string-is-emoji
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                 0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                 0x1F680...0x1F6FF, // Transport and Map
                 0x1F1E6...0x1F1FF, // Regional country flags
                 0x2600...0x26FF, // Misc symbols
                 0x2700...0x27BF, // Dingbats
                 0xE0020...0xE007F, // Tags
                 0xFE00...0xFE0F, // Variation Selectors
                 0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                 127_000...127_600, // Various asian characters
                 65024...65039, // Variation selector
                 9100...9300, // Misc items
                 8400...8447: // Combining Diacritical Marks for Symbols
                return true
            default:
                continue
            }
        }
        return false
    }
    
    ///        "abc".isAlphabetic -> true
    ///        "123abc".isAlphabetic -> false
    ///
    var isAlphabetic: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        return hasLetters && !hasNumbers
    }
    
    ///        // useful for passwords
    ///        "123abc".isAlphaNumeric -> true
    ///        "abc".isAlphaNumeric -> false
    ///
    var isAlphaNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }
    
    ///        "   hello  \n".trimmed -> "hello"
    ///
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    ///        "SomeText".copyToPasteboard() // copies "SomeText" to pasteboard
    ///
    func copyToPasteboard() {
        #if os(iOS)
        UIPasteboard.general.string = self
        #elseif os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(self, forType: .string)
        #endif
    }
    
    
    ///        "hello world".firstCharacterUppercased() -> "Hello world"
    ///        "".firstCharacterUppercased() -> ""
    ///
    mutating func firstCharacterUppercased() {
        guard let first = first else { return }
        self = String(first).uppercased() + dropFirst()
    }
    
    ///        String.random(ofLength: 18) -> "u7MMZYvGo9obcOcPj8"
    ///
    /// - Parameter length: number of characters in string.
    /// - Returns: random string of given length.
    static func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            randomString.append(base.randomElement()!)
        }
        return randomString
    }
    
    var strikethrough: NSAttributedString {
        return NSAttributedString(
            string: self,
            attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
    }
    
    public func toTime(inputFormate:String, outPutFormate:String) -> String{
        var finalstring = ""
        let InputdateForamte = DateFormatter()
        InputdateForamte.dateFormat = inputFormate
        let outputdateForamte = DateFormatter()
        outputdateForamte.dateFormat = outPutFormate
        if let inputdate = InputdateForamte.date(from: self){
            finalstring = outputdateForamte.string(from: inputdate)
        }
        return finalstring
    }
    
    var htmlToAttributedString: NSAttributedString? {
        let modifiedString = self
        //        let modifiedString = "<style>body{text-align: right; }</style>\(self)";
        
        //        if selectedLanguage.code == languages[0].code{
        //            modifiedString = "<blockquote dir=rtl>\(self)"
        //        }
        
        guard let data = modifiedString.data(using: .utf8) else { return NSAttributedString() }
        //        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func isValidName() -> Bool {
        let emailRegEx = "^[A-Z  a-z]{3,30}$"
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
    
    func isValidEmailId() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
    
    ///        "john@doe.com".isValidEmail -> true
    ///
    var isValidEmail: Bool {
        // http://emailregex.com/
        let regex =
            "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    func isValidPassword() -> Bool{
        let passRegEx = "(?=.*[A-Z])(?=.*[d$@$!%*?&#.><,)/+*(])(?=.*[0-9])(?=.*[a-z]).{8,16}"
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let validatePassord = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
        return isvalidatePass
    }
    
    //    func isValidPassword() -> Bool {
    //        //Minimum 8 characters at least 1 Alphabet and 1 Number:
    //        let passRegEx = "[A-Z0-9a-z._%+-@!#$^&*.-]{8,18}$"
    //        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
    //        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
    //        return isvalidatePass
    //    }
    
    //    func validateAnyOtherTextField(otherField: String) -> Bool {
    //        let otherRegexString = "^[A-Z 0-9 a-z ]{1,30}$"
    //        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", otherRegexString)
    //        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
    //        return isValidateOtherString
    //    }
    
    func isValidPhoneNumber() -> Bool {
        let phoneNumberRegex = "^[0-9]{10}$"
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = validatePhone.evaluate(with: trimmedString)
        return isValidPhone
    }
    
}

extension Collection {
    public subscript (safe index: Self.Index) -> Iterator.Element? {
        (startIndex ..< endIndex).contains(index) ? self[index] : nil
    }
}
//let values = ["A", "B", "C"]
//values.getValue(at: 2) // "C"
//values.getValue(at: 3) // nil
