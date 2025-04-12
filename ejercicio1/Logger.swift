//
//  Logger.swift
//  ejercicio1
//
//  Created by ruizvi | VIDAL RUIZ VARGAS on 12/04/25.
//  Descripción: Clase Singleton para administrar logs en archivo local utilizando FileManager.
//

import Foundation

public class Logger {

    // MARK: - Singleton
    static let shared = Logger()
    private init() {}

    // MARK: - Propiedades internas
    private let nombreArchivo = "log.txt"

    /// Guarda un mensaje en el archivo de log (agregando al final si ya existe).
    func saveOnFile(message: String) {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("❌ No se pudo acceder al directorio Documents")
            return
        }

        let archivoURL = documentsURL.appendingPathComponent(nombreArchivo)

        // Convertimos el mensaje en datos con salto de línea
        let mensajeConSalto = message + "\n"
        guard let datos = mensajeConSalto.data(using: .utf8) else {
            print("❌ No se pudo convertir el mensaje a datos")
            return
        }

        // Si el archivo ya existe, lo abrimos en modo append
        if FileManager.default.fileExists(atPath: archivoURL.path) {
            if let fileHandle = try? FileHandle(forWritingTo: archivoURL) {
                fileHandle.seekToEndOfFile()
                fileHandle.write(datos)
                fileHandle.closeFile()
                print("✅ Mensaje agregado al archivo existente")
            } else {
                print("❌ No se pudo abrir el archivo para escritura")
            }
        } else {
            // Si no existe, lo creamos
            do {
                try datos.write(to: archivoURL)
                print("✅ Archivo creado y mensaje guardado")
            } catch {
                print("❌ Error al crear archivo: \(error)")
            }
        }
    }

    /// Lee el contenido completo del archivo de log
    func readFile() {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("❌ No se pudo acceder al directorio Documents")
            return
        }

        let archivoURL = documentsURL.appendingPathComponent(nombreArchivo)

        do {
            let contenido = try String(contentsOf: archivoURL, encoding: .utf8)
            print("📄 Contenido del archivo:\n\(contenido)")
        } catch {
            print("❌ Error al leer el archivo: \(error)")
        }
    }
}
