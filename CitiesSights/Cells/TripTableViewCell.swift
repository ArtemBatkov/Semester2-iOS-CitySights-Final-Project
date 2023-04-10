//
//  TripTableViewCell.swift
//  CitiesSights
//
//  Created by user233573 on 4/8/23.
//

import UIKit

class TripTableViewCell: UITableViewCell {
    
    private let showPolyhones = !true
    
    private let stackView = UIStackView()
    public var Avatar: UIImageView = UIImageView()
    private var Title: UILabel = UILabel()
    
    public var avatar: Data? = nil {
        didSet{
            if let avatarData = avatar {
                Avatar.image = UIImage(data: avatarData)
            } else {
                Avatar.image = defAvatar
            }
        }
    }
    
    //public var title: String = ""
    
    public var title: String = "" {
        didSet {
            Title.text = title
        }
    }
    
    
    
    public var defAvatar = UIImage(named: "trip_blank")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Title.text = title
        SetUpCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func SetUpCell(){
        //stack adj
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20)
        ])
        
        //horizontal stack
        var horizontal = UIStackView()
        horizontal.axis = .horizontal
        horizontal.spacing = 5
        horizontal.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(horizontal)
        NSLayoutConstraint.activate([
            horizontal.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            horizontal.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            horizontal.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10),
            horizontal.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10),
            horizontal.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -20)
        ])
        horizontal.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        horizontal.isLayoutMarginsRelativeArrangement = true
        
        //Image
        
        Avatar.contentMode = .scaleAspectFit
        Avatar.translatesAutoresizingMaskIntoConstraints = false
        horizontal.addArrangedSubview(Avatar)
        Avatar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        Avatar.widthAnchor.constraint(equalTo: horizontal.widthAnchor, multiplier: 0.3).isActive = true
        Avatar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //Title
        //Title.text = title
        Title.font = UIFont.boldSystemFont(ofSize: 25)
        Title.textAlignment = .center
        Title.translatesAutoresizingMaskIntoConstraints = false
        horizontal.addArrangedSubview(Title)
        Title.widthAnchor.constraint(equalTo: horizontal.widthAnchor, multiplier: 0.7).isActive = true
        
        if(showPolyhones){
            stackView.backgroundColor = .red
            horizontal.backgroundColor = .blue
            Avatar.backgroundColor = .systemYellow
            Title.backgroundColor = .gray
        }
    }
}
