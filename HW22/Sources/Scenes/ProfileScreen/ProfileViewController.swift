//
//  ProfileViewController.swift
//  HW22
//
//  Created by Anton on 13.11.2022.
//

import UIKit
import SnapKit

protocol ProfileViewProtocol: AnyObject {
    func setupProfileView(for person: Person)
}

class ProfileViewController: UIViewController, ProfileViewProtocol {
    
    // MARK: - References
    
    var presenter: ProfilePresenterProtocol?
    
    // MARK: - Setup ProfileView
    
    func setupProfileView(for person: Person) {
        personName.text = person.name
        personBirthDay.text = person.birthDay
        personGender.text = person.gender
    }
    
    // MARK: - Properties
    
    private var isEditEnable = false
    
    // MARK: - Elements
    
    private lazy var profilePhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var personName: UITextField = {
        let label = UITextField()
        label.isEnabled = isEditEnable
        return label
    }()
    
    private lazy var personBirthDay: UITextField = {
        let label = UITextField()
        label.isEnabled = isEditEnable
        return label
    }()
    
    private lazy var personGender: UITextField = {
        let label = UITextField()
        label.isEnabled = isEditEnable
        return label
    }()
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "arrow.left")
        return button
    }()
    
    private lazy var rightButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.action = #selector(editAction)
        button.target = self
        button.title = "Edit"
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    private func setupHierarchy() {
        view.addSubview(profilePhoto)
        view.addSubview(personName)
        view.addSubview(personBirthDay)
        view.addSubview(personGender)
    }
    
    private func setupLayout() {
        profilePhoto.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.width.equalTo(200)
        }
        
        personName.snp.makeConstraints { make in
            make.top.equalTo(profilePhoto.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
        }
        
        personBirthDay.snp.makeConstraints { make in
            make.top.equalTo(personName.snp.bottom).offset(20)
            make.left.equalTo(personName)
        }
        
        personGender.snp.makeConstraints { make in
            make.top.equalTo(personBirthDay.snp.bottom).offset(20)
            make.left.equalTo(personName)
        }
    }
    
    // MARK: - Actions
    
    @objc private func editAction() {
        isEditEnable.toggle()
        if isEditEnable {
            rightButtonItem.title = "Save"
        } else {
            rightButtonItem.title = "Edit"
        }
        print(isEditEnable)
    }
}
