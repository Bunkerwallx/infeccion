package com.ejemplo;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class Injector {
    public static void injectPayload(String targetDir, String payloadFile) {
        try {
            File target = new File(targetDir);
            File payload = new File(payloadFile);
            if (target.isDirectory() && payload.isFile()) {
                Files.copy(payload.toPath(), Paths.get(targetDir, payload.getName()));
                System.out.println("Payload inyectado correctamente en " + targetDir);
            } else {
                System.out.println("Directorio objetivo o archivo de payload no válido.");
            }
        } catch (IOException e) {
            System.out.println("Error al inyectar el payload: " + e.getMessage());
        }
    }
}
