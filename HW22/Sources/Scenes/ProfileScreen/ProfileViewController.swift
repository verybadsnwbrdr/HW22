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
        label.leftView = personNameImage
        label.leftViewMode = .always
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    private lazy var personBirthDay: UITextField = {
        let label = UITextField()
        label.isEnabled = isEditEnable
        label.leftView = personBirthDayImage
        label.leftViewMode = .always
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    private lazy var personGender: UITextField = {
        let label = UITextField()
        label.isEnabled = isEditEnable
        label.leftView = personGenderImage
        label.leftViewMode = .always
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    private lazy var personNameImage: UIImageView = {
        let image = UIImage(systemName: "person.fill")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var personBirthDayImage: UIImageView = {
        let image = UIImage(systemName: "birthday.cake.fill")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var personGenderImage: UIImageView = {
        let image = UIImage(systemName: "figure.dress.line.vertical.figure")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var separators: [UIView] = {
        var views: [UIView] = []
        for i in 1...3 {
            var view = UIView()
            view.backgroundColor = .separator
            self.view.addSubview(view)
            views.append(view)
        }
        return views
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .vertical
        stack.alignment = .leading
        stack.contentMode = .scaleAspectFit
        return stack
    }()
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.action = #selector(backButtonAction)
        button.target = self
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
        
        stack.addArrangedSubview(personName)
        stack.addArrangedSubview(separators[0])
        stack.addArrangedSubview(personBirthDay)
        stack.addArrangedSubview(separators[1])
        stack.addArrangedSubview(personGender)
        stack.addArrangedSubview(separators[2])
        
        view.addSubview(stack)
    }
    
    private func setupLayout() {
        profilePhoto.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.width.equalTo(250)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(profilePhoto.snp.bottom).offset(40)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        separators.forEach { separator in
            separator.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.width.equalTo(stack)
            }
        }
        
        [personName, personBirthDay, personGender].forEach { view in
            view.snp.makeConstraints { make in
                make.height.equalTo(40)
                make.width.equalTo(stack.snp.width)
            }
        }
        
        [personNameImage, personBirthDayImage, personGenderImage].forEach { view in
            view.snp.makeConstraints { make in
                make.height.equalTo(25)
                make.width.equalTo(60)
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func editAction() {
        isEditEnable.toggle()
        stack.subviews.forEach { view in
            guard let textField = view as? UITextField else { return }
            textField.isEnabled = isEditEnable
            textField.borderStyle = isEditEnable ? .roundedRect : .none
        }
        
        if isEditEnable {
            rightButtonItem.title = "Save"
        } else {
            presenter?.saveButtonPressed(personName.text,
                                         personBirthDay.text,
                                         personGender.text)
            rightButtonItem.title = "Edit"
        }
    }
    
    @objc private func backButtonAction() {
        presenter?.backToMainScreen()
    }
}

/*
 view.addSubview(personName)
 view.addSubview(personBirthDay)
 view.addSubview(personGender)
 
 personNameImage.snp.makeConstraints { make in
     make.height.equalTo(25)
     make.width.equalTo(50)
 }
 
 personBirthDayImage.snp.makeConstraints { make in
     make.height.equalTo(25)
     make.width.equalTo(50)
 }
 
 personGenderImage.snp.makeConstraints { make in
     make.height.equalTo(25)
     make.width.equalTo(50)
 }
 
separators[0].snp.makeConstraints { make in
    make.height.equalTo(1)
    make.left.equalTo(view).offset(20)
    make.right.equalTo(view).offset(-20)
    make.top.equalTo(personName.snp.bottom)
}

separators[1].snp.makeConstraints { make in
    make.height.equalTo(1)
    make.left.equalTo(view).offset(20)
    make.right.equalTo(view).offset(-20)
    make.top.equalTo(personBirthDay.snp.bottom)
}

separators[2].snp.makeConstraints { make in
    make.height.equalTo(1)
    make.left.equalTo(view).offset(20)
    make.right.equalTo(view).offset(-20)
    make.top.equalTo(personGender.snp.bottom)
}
*/
