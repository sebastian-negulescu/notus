//
//  tutorial_view.swift
//  notus
//
//  Created by Sebastian Negulescu on 2026-10-13.
//

import SwiftUI

struct ViewTutorialPageViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIPageViewController {
        let tutorial_page_view_controller = TutorialPageViewController()
        return tutorial_page_view_controller
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) -> Void {
    }
}

class SolidColorViewController: UIViewController {
    private let color: UIColor

    init(color: UIColor = .systemBlue) {
        self.color = color
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.color = .systemBlue
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
    }
}

class TutorialPageViewController: UIPageViewController {
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newColoredViewController(color: .green),
                self.newColoredViewController(color: .red),
                self.newColoredViewController(color: .blue)]
    }()

    private func newColoredViewController(color: UIColor) -> UIViewController {
        return SolidColorViewController(color: color)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        dataSource = self
            
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                direction: .forward,
                animated: true,
                completion: nil)
        }
    }
}
    
// MARK: UIPageViewControllerDataSource

extension TutorialPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewControllerAfter) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
        
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewControllerBefore) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
}

#Preview {
    ViewTutorialPageViewController()
        .ignoresSafeArea()
}
