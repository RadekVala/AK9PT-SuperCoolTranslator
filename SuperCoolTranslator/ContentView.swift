//
//  ContentView.swift
//  SuperCoolTranslator
//
//  Created by Radek Vala on 01.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var userInput = ""
    @State var translationResult = ""
    
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .resizable()
                .foregroundStyle(.tint)
                .frame(width: 150,height: 150)
            
            TextField("Enter text for translation...", text: $userInput )
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Translate", action: doRequest)
                .padding()
            
            Text("\(translationResult)")
        }
        .padding()
    }
    
    func doRequest(){
        // api call
        print("btn tapped")
        
        if !userInput.isEmpty {
            
            let originalUrl = "https://api.mymemory.translated.net/get?q=\(userInput)&langpair=cs|en"
            let escapedUrl = originalUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            guard let url = URL(string: escapedUrl!) else {
                print("Invalid URL")
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(TranslationResponse.self, from: data)
                        DispatchQueue.main.async {
                            translationResult = result.responseData.translatedText
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching data: \(error)")
                }
            }.resume()
        }
    }
}

/*
 #Preview {
 ContentView()
 }
 */
