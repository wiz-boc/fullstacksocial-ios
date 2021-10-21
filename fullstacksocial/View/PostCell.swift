//
//  PostCell.swift
//  fullstacksocial
//
//  Created by wizz on 10/13/21.
//

import LBTATools
import Alamofire

protocol PostCellOptionsDelegate: AnyObject {
    func handlePostOptions(cell: PostCell)
}

extension HomeController: PostCellOptionsDelegate {
    func handlePostOptions(cell: PostCell) {
//        guard let indexPath = tableView.indexPath(for: cell) else { return }
//        let post = self.posts[indexPath.row]
//
//        let alertController = UIAlertController(title: "Options", message: nil, preferredStyle: .actionSheet)
//        alertController.addAction(.init(title: "Delete post", style: .destructive, handler: { (_) in
//            let url = "\(Service.shared.baseUrl)/post/\(post.id)"
//
//            AF.request(url,method: .delete).validate(statusCode: 200..<300).responseData { dataResp in
//                //print(dataResp.response)
//                if let err = dataResp.error {
//                    print("Failed to delete:", err)
//                }
//                if dataResp.response?.statusCode == 200 {
//                    self.posts.remove(at: indexPath.row)
//                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
//                }
//
//
//
//            }
//        }))
//        alertController.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
//
//        self.present(alertController, animated: true)
    }
}

class PostCell: UITableViewCell {
    
//    let usernameLabel = UILabel(text: "Username", font: .boldSystemFont(ofSize: 15))
//    let postImageView = UIImageView(image: nil, contentMode: .scaleAspectFill)
//    let postTextLabel = UILabel(text: "Post text spanning multiple lines", font: .systemFont(ofSize: 15), numberOfLines: 0)
//    lazy var optionsButton = UIButton(image: #imageLiteral(resourceName: "post_options"), tintColor: .black, target: self, action: #selector(handleOptions))
//    
//    weak var delegate: PostCellOptionsDelegate?
//    
//    @objc fileprivate func handleOptions() {
//        print("Handle delete options on post cell")
//        delegate?.handlePostOptions(cell: self)
//    }
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.isUserInteractionEnabled = false
//        // make image square
//        postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor).isActive = true
//        
//        stack(hstack(usernameLabel,
//                     UIView(),
//                     optionsButton.withWidth(34))
//                    .padLeft(16).padRight(16),
//              postImageView,
//              stack(postTextLabel).padLeft(16).padRight(16),
//              spacing: 16).withMargins(.init(top: 16, left: 0, bottom: 16, right: 0))
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError()
//    }
    
}
