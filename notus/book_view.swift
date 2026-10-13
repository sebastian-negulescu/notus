//
//  book_view.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-10-11.
//

import SwiftUI

class PageViewController: UIViewController {
}

struct BookView: UIViewControllerRepresentable {
    let bookDataSource: BookViewDataSource
    
    init(book: Book) {
        bookDataSource = BookViewDataSource()
    }
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let page_view = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        
        page_view.dataSource = bookDataSource
        
        return page_view
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) -> Void {
    }
}

class BookViewDataSource: UIPageViewController, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // forwards one page
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // backwards one page
        return nil
    }
}
