//
//  LoggerJson.swift
//  ejercicio1
//
//  Created by Vidal Ruiz Vargas on 12/04/2025.
//  Descripción: Logger Singleton que guarda eventos con timestamp en formato JSON.
//

import Foundation

// MARK: - Modelo para cada entrada del log
struct LogEntry: Codable {
    let createdDate: String
    let message: String
}

// MARK: - Clase Singleton
class LoggerJson  {
    
    static let shared = LoggerJson()
    private let nombreArchivo = "log.json"
    
    private init() {}
    
    /// Guarda un mensaje en el archivo JSON, con la fecha actual
    func save(message: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let fechaActual = dateFormatter.string(from: Date())
        
        let nuevoEvento = LogEntry(createdDate: fechaActual, message: message)
        var eventos: [LogEntry] = []

        let url = getFileURL()
        
        // Leer el archivo actual si existe
        if let dataExistente = try? Data(contentsOf: url) {
            if let eventosExistentes = try? JSONDecoder().decode([LogEntry].self, from: dataExistente) {
                eventos = eventosExistentes
            }
        }
        
        // Agregar el nuevo evento y guardar el arreglo actualizado
        eventos.append(nuevoEvento)
        
        do {
            let data = try JSONEncoder().encode(eventos)
            try data.write(to: url)
            print("✅ Log agregado en log.json")
        } catch {
            print("❌ Error al guardar el log: \(error)")
        }
    }
    
    /// Lee y muestra los logs almacenados en log.json
    func read() {
        let url = getFileURL()
        
        do {
            let data = try Data(contentsOf: url)
            let eventos = try JSONDecoder().decode([LogEntry].self, from: data)
            print("📄 Contenido de log.json:")
            for evento in eventos {
                print("- \(evento.createdDate): \(evento.message)")
            }
        } catch {
            print("❌ No se pudo leer log.json: \(error)")
        }
    }
    
    /// Devuelve la URL completa al archivo log.json
    private func getFileURL() -> URL {
        let documentos = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentos.appendingPathComponent(nombreArchivo)
    }
}
