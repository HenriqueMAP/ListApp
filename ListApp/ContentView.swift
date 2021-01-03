//
//  ContentView.swift
//  ListApp
//
//  Created by Henrique Matheus Alves Pereira on 02/01/21.
//


import Combine
import SwiftUI

class DataSource: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()
    var pictures = [String]()
    
    init() {
        let fm = FileManager.default
        
        if let path = Bundle.main.resourcePath, let items = try? fm.contentsOfDirectory(atPath: path) {
            for item in items {
                if item.hasPrefix("nerd") {
                    pictures.append(item)
                }
            }
        }
        
        didChange.send(())
    }
}

struct DetailView: View {
    var selectedImage: String
    
    var body: some View {
        let img = UIImage(named: selectedImage)!
        Image(uiImage: img)
    }
}

struct ContentView: View {
    @ObservedObject var dataSource = DataSource()
    
    var body: some View {
        NavigationView{
            List(dataSource.pictures, id: \.self){ picture in
                NavigationLink(LocalizedStringKey(picture), destination: DetailView(selectedImage: picture))
                Text(picture)
                }.navigationBarTitle(Text("Storm Viewer"))
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
