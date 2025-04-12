// MARK: - Comments
//  ViewController.swift
//  ejercicio1
//
//  Created by Vidal Ruiz Vargas on 11/04/2025.
//  Descripción: Pantalla de inicio de sesión construida completamente en código, sin storyboard.
//               Incluye un título, campos de texto para correo y contraseña, y un botón para iniciar sesión.
//               Puede rotar.

import UIKit

class ViewController: UIViewController {
    
    // MARK: - UI Elements
    
    /// Etiqueta principal con el título de la aplicación
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "el App más bonita del mundo"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Campo de texto para que el usuario introduzca su correo
    let correoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "correo"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    /// Campo de texto para que el usuario introduzca su contraseña
    let contrasenaTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "contraseña"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    /// Botón para iniciar sesión
    let LoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Iniciar sesión", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - View Lifecycle
    
    /// Método llamado al cargar la vista. Configura la interfaz y agrega la acción del botón.
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        
        // Cargar valores guardados (si existen)
        let correoGuardado = UserDefaults.standard.string(forKey: "correoGuardado")
        let contrasenaGuardada = UserDefaults.standard.string(forKey: "contrasenaGuardada")
        
        correoTextField.text = correoGuardado
        contrasenaTextField.text = contrasenaGuardada
        
        LoginButton.addTarget(self, action: #selector(LoginButton_OnTouchUpInside), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let correoGuardado = UserDefaults.standard.string(forKey: "correoGuardado") ?? ""
        let contrasenaGuardada = UserDefaults.standard.string(forKey: "contrasenaGuardada") ?? ""
        
        if !correoGuardado.isEmpty && !contrasenaGuardada.isEmpty {
            openWelcomeView()
        }
    }
    // MARK: - Layout
    
    /// Método que organiza los elementos en pantalla usando Auto Layout
    func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(correoTextField)
        view.addSubview(contrasenaTextField)
        view.addSubview(LoginButton)
        
        NSLayoutConstraint.activate([
            // Posición del título
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Campo de correo
            correoTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            correoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            correoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            // Campo de contraseña
            contrasenaTextField.topAnchor.constraint(equalTo: correoTextField.bottomAnchor, constant: 20),
            contrasenaTextField.leadingAnchor.constraint(equalTo: correoTextField.leadingAnchor),
            contrasenaTextField.trailingAnchor.constraint(equalTo: correoTextField.trailingAnchor),
            
            // Botón de iniciar sesión
            LoginButton.topAnchor.constraint(equalTo: contrasenaTextField.bottomAnchor, constant: 30),
            LoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            LoginButton.widthAnchor.constraint(equalToConstant: 150),
            LoginButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - Actions
    
    /// Acción ejecutada cuando se presiona el botón de iniciar sesión
    @objc func LoginButton_OnTouchUpInside() {
        let correo = correoTextField.text ?? ""
        let contrasena = contrasenaTextField.text ?? ""
        
        if correo.isEmpty || contrasena.isEmpty {
            let alerta = UIAlertController(title: "Campos requeridos",
                                           message: "Por favor, ingresa tu correo y contraseña.",
                                           preferredStyle: .alert)

            alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            self.present(alerta, animated: true, completion: nil)
        } else {
            UserDefaults.standard.set(correo, forKey: "correoGuardado")
            UserDefaults.standard.set(contrasena, forKey: "contrasenaGuardada")
            UserDefaults.standard.synchronize();
            openWelcomeView()
        }
    }
    
    func openWelcomeView() {
        let bienvenidaVC = BienvenidaViewController()
        bienvenidaVC.modalPresentationStyle = .fullScreen
        present(bienvenidaVC, animated: true, completion: nil)
    }
}
