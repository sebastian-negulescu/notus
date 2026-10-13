# Devlog

## Style Guide

- `PascalCase` for structs/classes
- `camelCase` for methods/properties
- `snake_case` for variables/parameters

## October, 2026

### 11

`UIViewRepresentable` is the way to wrap UIKit views into SwiftUI views.
`UIViewControllerRepresentable` is the same but for UIKit view controllers.

For the page turning, there are two options to control:
- [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
    - linear slide/snap
    - continuous scroll
    - flexible page layout
    - recycles `UICollectionViewCell` elements
- [UIPageViewController](https://developer.apple.com/documentation/uikit/uipageviewcontroller)
    - 3D page curl
    - no continuous scroll
    - one or two discreet pages
    - whole `UIViewController` per page

It might be more fun to start with the `UIPageViewController`.
I'll have to see which one I like more.

#### How do we atomize?

Minimum example: 3-page book with the coloured backgrounds (red, green, blue) that I can flip between the pages seamlessly.
Then we distill that and play around with options until it feels good (easier said than done).
From that, we can performance test.

#### UIPageViewController

Requires a data source (the pages, duh!).
Can also take a delegate, but I don't think we need that since we're not responding to user events yet.

### 13

UIKit is a little different than SwiftUI.
There's a lot to get adjusted to in terms of getting things up and running.
I'm also a lot more exposed to the Swift language, which is a good thing I think, I'm just not great at Swift yet.

In terms of my understanding of the UIPageViewController, it deals in other view controllers.

Found an example of how to use, going to copy it then slowly change it for myself.

Got the example working with a preview, now just draw the rest of the owl...
Turns out the page turn functions are labelled incorrectly:
- `func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore: UIViewController) -> UIViewController?`: asking for the view controller before
- `func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter: UIViewController) -> UIViewController?`: asking for the view controller after

Going to call it here for now, next need to have a think about how we want the page and book structs to look and how they're going to flow through the views.
Potential flow: `DeskView -> BookView -> PageView -> DrawingView`


