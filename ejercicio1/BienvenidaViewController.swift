//
//  BienvenidaViewController.swift
//  ejercicio1
//
//  Created by Vidal Ruiz Vargas on 11/04/2025.
//  Descripción: Segunda vista de bienvenida que muestra los datos almacenados en UserDefaults.
//

import UIKit

class BienvenidaViewController: UIViewController {
    
    let bienvenidaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cerrarSesionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cerrar sesión", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.systemGreen, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        view.addSubview(bienvenidaLabel)
        view.addSubview(cerrarSesionButton)

        NSLayoutConstraint.activate([
            bienvenidaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bienvenidaLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            bienvenidaLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            bienvenidaLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            cerrarSesionButton.topAnchor.constraint(equalTo: bienvenidaLabel.bottomAnchor, constant: 40),
            cerrarSesionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cerrarSesionButton.widthAnchor.constraint(equalToConstant: 150),
            cerrarSesionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        let correo = UserDefaults.standard.string(forKey: "correoGuardado") ?? "correo desconocido"
        bienvenidaLabel.text = "¡Bienvenido!\nCorreo: \(correo)";
        Logger.shared.saveOnFile(message: "El usuario inició sesión");
        LoggerJson.shared.save(message: "El usuario abrió la app");

        cerrarSesionButton.addTarget(self, action: #selector(closeSession), for: .touchUpInside);
    }
    
    /// Elimina los datos y regresa a la pantalla de login
    @objc func closeSession() {
        let alerta = UIAlertController(
            title: "¿Cerrar sesión?",
            message: "Se eliminarán tus datos guardados.",
            preferredStyle: .alert
        )

        let confirmar = UIAlertAction(title: "Sí", style: .destructive) { _ in
            // Borrar datos
            let defaults = UserDefaults.standard
            defaults.removeObject(forKey: "correoGuardado")
            defaults.removeObject(forKey: "contrasenaGuardada")
            Logger.shared.saveOnFile(message: "El usuario cerro la app")
            LoggerJson.shared.save(message: "El usuario cerro la app")

            // Volver al login
            self.dismiss(animated: true, completion: nil)
        }

        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)

        alerta.addAction(confirmar)
        alerta.addAction(cancelar)

        present(alerta, animated: true, completion: nil)
    }
    

}
