package com.ejemplo;

public class Permissions {
    public static void checkPermissions() {
        if (System.getProperty("user.name").equals("root")) {
            System.out.println("Permisos de root verificados");
        } else {
            System.out.println("Este script debe ejecutarse como root");
        }
    }
}
