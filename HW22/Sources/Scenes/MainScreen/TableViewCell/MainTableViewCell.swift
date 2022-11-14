//
//  MainTableViewCell.swift
//  HW22
//
//  Created by Anton on 13.11.2022.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    
    static let identifier = "MainTableViewCell"
    
    // MARK: - SetupCell
    
    func setupCell(with person: Person) {
        label.text = person.name
    }
    
    // MARK: - Elements
    
    private lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupHierarchy() {
        addSubview(label)
    }
    
    private func setupLayout() {
        label.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(20)
            make.right.equalTo(snp.right).offset(-60)
            make.centerY.equalTo(snp.centerY)
        }
    }
    
    // MARK: - PrepareForReuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
}
