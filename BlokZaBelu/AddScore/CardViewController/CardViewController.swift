import UIKit

enum ScrollDirection {
    case up
    case down
}

//https://github.com/almer101/CardViewController
/**
 To create custom CardViewController subclass this **CardViewController** and
 override *contentView* variable with the custom content view to be presented in the card.
 The rest will be handled by this class.
 */
class CardViewController: UIViewController {
    
    let openedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Drawer-Opened-Indicator")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.alpha = 0
        return imageView
    }()
    
    let closedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "add")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        return imageView
    }()
    
    private let handleArea: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.darkGray2
        return view
    }()
    
    /** The main content of the card. Add this view when subclassing **CardViewController** */
    var contentView: UIView? {
        didSet {
            contentView?.translatesAutoresizingMaskIntoConstraints = false
            if let content = contentView as? UIScrollView {
                content.delegate = self
            }
        }
    }
    
    /** The header of the card, i.e. the visible part of the card when if is **colapsed** */
    var headerView: UIView? { didSet { headerView?.translatesAutoresizingMaskIntoConstraints = false } }
    
    private var closedTransform: CGAffineTransform = .identity
    
    private var animator = UIViewPropertyAnimator()
    private var isOpen = false
    private var animationProgress: CGFloat = 0
    
    private var initialOffset: CGFloat = 0.0
    private var touchesActive: Bool = false
    private var lastOffset: CGFloat = 0.0
    private var scrollDirection: ScrollDirection = .down
    private var animationComplete = true
    private let bottomInset: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupClosedTransform()
    }
    
    public func closeCard() {
        isOpen = true
        animator.stopAnimation(false)
        startAnimationIfNeeded()
    }
    
    public func openCard() {
        isOpen = false
        startAnimationIfNeeded()
    }
    
    private func setupClosedTransform() {
        let visibleHeight = view.frame.size.height - 0
        
        var offset = visibleHeight - handleArea.frame.size.height
        if headerView == nil {
//            offset -= 30
        }
        
        closedTransform = CGAffineTransform(translationX: 0, y: offset)
        view.transform = closedTransform
    }
    
    private func setupUI() {
        let layer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: CGSize(width: 20, height: 20))
        layer.path = path.cgPath
        view.layer.mask = layer
        view.backgroundColor = UIColor.darkGray2

        view.addSubview(handleArea)
        handleArea.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        handleArea.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        handleArea.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        handleArea.addSubview(closedImageView)
        closedImageView.topAnchor.constraint(equalTo: handleArea.topAnchor, constant: 4).isActive = true
        closedImageView.leadingAnchor.constraint(equalTo: handleArea.leadingAnchor).isActive = true
        closedImageView.trailingAnchor.constraint(equalTo: handleArea.trailingAnchor).isActive = true
        closedImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        handleArea.addSubview(openedImageView)
        openedImageView.leadingAnchor.constraint(equalTo: handleArea.leadingAnchor).isActive = true
        openedImageView.trailingAnchor.constraint(equalTo: handleArea.trailingAnchor).isActive = true
        openedImageView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        openedImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        
        if let headerView = headerView {
            handleArea.addSubview(headerView)
            
            headerView.topAnchor.constraint(equalTo: closedImageView.bottomAnchor).isActive = true
            headerView.leadingAnchor.constraint(equalTo: handleArea.leadingAnchor, constant: 32).isActive = true
            headerView.trailingAnchor.constraint(equalTo: handleArea.trailingAnchor, constant: -32).isActive = true
            headerView.bottomAnchor.constraint(equalTo: handleArea.bottomAnchor, constant: -15).isActive = true
            
            let heightConstraint = handleArea.heightAnchor.constraint(equalToConstant: 110)
            heightConstraint.priority = UILayoutPriority(rawValue: 900)
            heightConstraint.isActive = true
            
        } else {
            closedImageView.bottomAnchor.constraint(equalTo: handleArea.bottomAnchor, constant: -10).isActive = true
        }
        
        if let contentView = contentView {
            view.addSubview(contentView)
            
            contentView.topAnchor.constraint(equalTo: handleArea.bottomAnchor, constant: 0).isActive = true
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -0).isActive = true
        }

        handleArea.addGestureRecognizer(InstantPanGestureRecognizer(target: self, action: #selector(panned(recognizer:))))
    }
    
    @objc private func handleTap(recognizer: UITapGestureRecognizer) {
        isOpen = true
        startAnimationIfNeeded()
    }
    
    @objc private func panned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startAnimationIfNeeded()
            pauseAnimator()
        case .changed:
            let fraction = -recognizer.translation(in: handleArea).y / closedTransform.ty
            updateAnimator(with: fraction)
        case .ended, .cancelled:
            let velocity = recognizer.velocity(in: handleArea).y
            let shouldClose = velocity > 0
            if velocity == 0 {
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                return
            }
            if isOpen {
                // view opened
                if !shouldClose, !animator.isReversed { animator.isReversed.toggle() }
                if shouldClose, animator.isReversed { animator.isReversed.toggle() }
            } else {
                // view colapsed
                if shouldClose, !animator.isReversed { animator.isReversed.toggle() }
                if !shouldClose, animator.isReversed { animator.isReversed.toggle() }
            }
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            break
        }
    }
    
    private func pauseAnimator() {
        animator.pauseAnimation()
        animationProgress = animator.fractionComplete
    }
    
    private func updateAnimator(with fractionComplete: CGFloat) {
        var fraction = fractionComplete
        if isOpen { fraction *= -1 }
        if animator.isReversed { fraction *= -1 }
        animator.fractionComplete = fraction + animationProgress
    }
    
    private func startAnimationIfNeeded() {
        if animator.isRunning { return }
        
        view.endEditing(true)
        
        animationComplete = false
        animator = UIViewPropertyAnimator(duration: 0.65, dampingRatio: 1) {
            if self.isOpen {
                // will animate to closed
                self.view.transform = self.closedTransform
                self.openedImageView.alpha = 0
                self.closedImageView.alpha = 1
            } else {
                // will animate to open
                self.view.transform = .identity
                self.openedImageView.alpha = 1
                self.closedImageView.alpha = 0
            }
        }
        
        animator.addCompletion { position in
            if position == .end { self.isOpen.toggle() }
            self.animationComplete = true
        }
        
        animator.startAnimation()
    }
    
}

extension CardViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        touchesActive = true
        initialOffset = scrollView.contentOffset.y
        if initialOffset <= 0 {
            startAnimationIfNeeded()
            pauseAnimator()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !touchesActive { return }
        
        let currentOffset = scrollView.contentOffset.y
        scrollDirection = currentOffset > lastOffset ? .down : .up
        lastOffset = currentOffset
        
        if initialOffset > 0 { return }
        
        let diff = initialOffset - scrollView.contentOffset.y
        let fraction = -diff / closedTransform.ty
        
        updateAnimator(with: fraction)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        touchesActive = false
        if initialOffset > 0 { return }
        let shouldClose = scrollDirection == .up
        
        if isOpen {
            // view opened
            if !shouldClose, !animator.isReversed { animator.isReversed.toggle() }
            if shouldClose, animator.isReversed { animator.isReversed.toggle() }
        } else {
            // view colapsed
            if shouldClose, !animator.isReversed { animator.isReversed.toggle() }
            if !shouldClose, animator.isReversed { animator.isReversed.toggle() }
        }
        
        if !animationComplete {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        } else {
            isOpen = shouldClose ? true : false
            startAnimationIfNeeded()
        }
        
        return
        
    }
}
