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

final class ProfileViewController: UIViewController, ProfileViewProtocol {
    
    // MARK: - References
    
    var presenter: ProfilePresenterProtocol?
    
    // MARK: - Setup ProfileView
    
    func setupProfileView(for person: Person) {
        personName.text = person.name
        personBirthDay.text = person.birthDay
        personGender.text = person.gender
        guard let imageData = person.imageData else {
            profilePhoto.image = UIImage(systemName: profileImageCondition.rawValue)
            return
        }
        profileImageCondition = .custom
        profilePhoto.image = UIImage(data: imageData)
    }
    
    // MARK: - Properties
    
    private var isEditEnable = false {
        willSet {
            stack.subviews.forEach { view in
                guard let textField = view as? UITextField else { return }
                textField.isEnabled = newValue
                textField.borderStyle = newValue ? .roundedRect : .none
            }
            profilePhoto.isUserInteractionEnabled = newValue
            rightButtonItem.title = newValue ? "Save" : "Edit"
        }
    }
    
    private var profileImageCondition = ProfileImageConditions.defaultImage
    
    // MARK: - Elements
    
    private lazy var profilePhoto: UIImageView = {
        let imageView = UIImageView()
        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(imageTapped)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 125
        return imageView
    }()
    
    private lazy var personName: UITextField = {
        let label = UITextField()
        label.isEnabled = isEditEnable
        label.placeholder = "Name"
        label.leftView = personNameImage
        label.leftViewMode = .always
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    private lazy var personBirthDay: UITextField = {
        let label = UITextField()
        label.isEnabled = isEditEnable
        label.placeholder = "Birthday"
        label.leftView = personBirthDayImage
        label.leftViewMode = .always
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    private lazy var personGender: UITextField = {
        let label = UITextField()
        label.isEnabled = isEditEnable
        label.placeholder = "Gender"
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
    
    // MARK: - Actions
    
    @objc private func editAction() {
        isEditEnable.toggle()
        if !isEditEnable {
            presenter?.saveButtonPressed(
                personName.text,
                personBirthDay.text,
                personGender.text,
                convertProfileImage()
            )
        }
        toggleProfileImageCondition()
    }
    
    @objc private func backButtonAction() {
        presenter?.backToMainScreen()
    }
    
    @objc private func imageTapped() {
        showChooseImageAlert()
    }
}

// MARK: - Profile Image Condition

private extension ProfileViewController {
    enum ProfileImageConditions: String {
        case defaultImage = "person.crop.circle"
        case editing = "plus.circle"
        case custom
    }
    
    func convertProfileImage() -> Data? {
        guard profileImageCondition == .custom else { return nil }
        return profilePhoto.image?.pngData()
    }
    
    func toggleProfileImageCondition() {
        switch profileImageCondition {
        case .defaultImage:profileImageCondition = .editing
        case .editing: profileImageCondition = .defaultImage
        case .custom: return
        }
        profilePhoto.image = UIImage(systemName: profileImageCondition.rawValue)
    }
}

// MARK: - ChooseImageAlert

private extension ProfileViewController {
    func showChooseImageAlert() {
        let alert = UIAlertController(title: nil, message: "Chose image", preferredStyle: .actionSheet)
        let photoLibAction = UIAlertAction(title: "From photo", style: .default) { [unowned self] _ in
            choseImage(sourse: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        alert.addAction(photoLibAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}

// MARK: - Delegates

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func choseImage(sourse: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourse) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourse
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        profilePhoto.image = info[.editedImage] as? UIImage
        profileImageCondition = .custom
        dismiss(animated: true)
    }
}

// MARK: - Layout

extension ProfileViewController {
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
}
