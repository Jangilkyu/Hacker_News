//
//  StoryViewController.swift
//  NewsApp
//
//  Created by 장일규 on 2022/01/29.
//

import Foundation
import UIKit
import WebKit

class StoryViewController: UIViewController {
    
    var storyId: Int!
    var restProcessor: RestProcessor!
    
    convenience init(_ storyId: Int,
                     _ restProcessor: RestProcessor
    ) {
        self.init()
        self.storyId = storyId
        self.restProcessor = restProcessor
        
        setup()
    }
    
    let webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        return webView
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        
        return textView
    }()
    
    func addWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.addSpinner()
    }
    
    func addTextView() {
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func setup() {
        configureWebView()
        configureRestProcessor()
    }
    
    func configureWebView() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    func configureRestProcessor() {
        self.restProcessor.delegate = self
        self.restProcessor.fetchData(urlString: ProjectURL.getStory(itemNumber: storyId).description, usage: .getStory(itemNumber: storyId))
    }
    
}

extension StoryViewController: RestProcessorDelegate {
    func didSucessWith(
        data: Data,
        response: URLResponse,
        usage: ProjectURL) {
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
            
            switch usage {
                case .getStory:
                    guard let decoded = try? JSONDecoder().decode(Story.self, from: data) else { return }
                                
                if let myURL = decoded.url,
                    let url = URL(string: myURL){
                    let myReqeust = URLRequest(url: url)
                        DispatchQueue.main.async {
                            self.webView.load(myReqeust)
                            self.addWebView()
                        }
                }else if let text = decoded.text {
                    DispatchQueue.main.async {
                        self.textView.text = text
                        self.addTextView()
                    }
                }

            default:
                break
                
            }
        
    }
    
    func didFailwith(
        error: Error?,
        response: URLResponse?,
        usage: ProjectURL) {
        
    }
}

extension StoryViewController:
    WKUIDelegate, WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        didFinish navigation: WKNavigation!
    ) {
        print("did load")
        webView.removeSpinner()
    }
    
}
