//
//  UserPostCell.swift
//  fullstacksocial
//
//  Created by wizz on 10/17/21.
//


import LBTATools

protocol PostDelegate {
    func showComments(post: Post)
    func showOptions(post: Post)
    func handleLike(post: Post)
    func showLikes(post: Post)
}

class UserPostCell: LBTAListCell<Post> {
    
    let profileImageView = CircularImageView(width: 44, image: #imageLiteral(resourceName: "user"))
    
    let usernameLabel = UILabel(text: "Username", font: .boldSystemFont(ofSize: 15))
    let postImageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
    let postTextLabel = UILabel(text: "Post text spanning multiple lines", font: .systemFont(ofSize: 15), numberOfLines: 0)
    
    lazy var optionsButton = UIButton(image: #imageLiteral(resourceName: "post_options"), tintColor: .black, target: self, action: #selector(handleOptions))
    
    lazy var commentButton = UIButton(image: #imageLiteral(resourceName: "comment-bubble"), tintColor: .black, target: self, action: #selector(handleComment))
        
    lazy var likeButton = UIButton(image: #imageLiteral(resourceName: "like-outline"), tintColor: .black, target: self, action: #selector(handleLike))
    
    lazy var numLikesButton = UIButton(title: "0 likes", titleColor: .black, font: .boldSystemFont(ofSize: 14), target: self, action: #selector(handleShowLikes))
    
    @objc fileprivate func handleShowLikes() {
        (parentController as? PostDelegate)?.showLikes(post: item)
    }
    
    @objc fileprivate func handleLike() {
        (parentController as? PostDelegate)?.handleLike(post: item)
    }
        
    @objc fileprivate func handleComment() {
        (parentController as? PostDelegate)?.showComments(post: item)
    }
    
    @objc fileprivate func handleOptions() {
        (parentController as? PostDelegate)?.showOptions(post: item)
    }
    
    let fromNowLabel = UILabel(text: "Posted 5d ago", textColor: .gray)
    
    override var item: Post! {
        didSet {
            usernameLabel.text = item.user.fullName
            postImageView.sd_setImage(with: URL(string: item.imageUrl))
            postTextLabel.text = item.text
            
            profileImageView.sd_setImage(with: URL(string: item.user.profileImageUrl ?? ""))
            
            fromNowLabel.text = item.fromNow
            
            if item.hasLiked == true {
                likeButton.setImage(#imageLiteral(resourceName: "like-filled"), for: .normal)
                likeButton.tintColor = .red
            } else {
                likeButton.setImage(#imageLiteral(resourceName: "like-outline"), for: .normal)
                likeButton.tintColor = .black
            }
            
            numLikesButton.setTitle("\(item.numLikes) likes", for: .normal)
            
        }
    }
    
    var imageHeightAnchor: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // when cell is laying out everything make the image square
        imageHeightAnchor.constant = frame.width
    }
    
    override func setupViews() {
        
        // estimation height doesn't like constraining to widthAnchor, so instead we'll make height 0 during setup
        imageHeightAnchor = postImageView.heightAnchor.constraint(equalToConstant: 0)
        imageHeightAnchor.isActive = true
        
        stack(hstack(profileImageView,
                     stack(usernameLabel, fromNowLabel),
                     UIView(),
                     optionsButton.withWidth(34),
                     spacing: 12).padLeft(16).padRight(16),
              postImageView,
              stack(postTextLabel).padLeft(16).padRight(16),
              hstack(likeButton, commentButton, UIView(), spacing: 12).padLeft(16),
              hstack(numLikesButton, UIView()).padLeft(16),
              spacing: 16).withMargins(.init(top: 16, left: 0, bottom: 16, right: 0))
        
        addSeparatorView(leadingAnchor: usernameLabel.leadingAnchor)
    }
    
}
