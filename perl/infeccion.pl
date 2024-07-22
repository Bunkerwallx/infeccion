#!/usr/bin/perl
use strict;
use warnings;
use LWP::Simple;

# Función para decompilar un APK
sub decompile_apk {
    my ($apk_file, $output_dir) = @_;
    system("apktool d $apk_file -o $output_dir");
    if ($? == 0) {
        print "APK decompilado correctamente en $output_dir\n";
    } else {
        die "Error al decompilar el APK\n";
    }
}

# Función para inyectar un payload en el directorio decompilado
sub inject_payload {
    my ($target_dir, $payload_file) = @_;
    system("cp $payload_file $target_dir");
    if ($? == 0) {
        print "Payload inyectado correctamente en $target_dir\n";
    } else {
        die "Error al inyectar el payload\n";
    }
}

# Función para recompilar un APK
sub recompile_apk {
    my ($input_dir, $output_apk) = @_;
    system("apktool b $input_dir -o $output_apk");
    if ($? == 0) {
        print "APK recompilado correctamente en $output_apk\n";
    } else {
        die "Error al recompilar el APK\n";
    }
}

# Función para firmar y alinear un APK
sub sign_apk {
    my ($apk_file, $keystore, $alias, $storepass) = @_;
    system("jarsigner -keystore $keystore -storepass $storepass $apk_file $alias");
    if ($? == 0) {
        print "APK firmado correctamente\n";
        system("zipalign -v 4 $apk_file ${apk_file%.apk}_aligned.apk");
        if ($? == 0) {
            print "APK alineado correctamente\n";
        } else {
            die "Error al alinear el APK\n";
        }
    } else {
        die "Error al firmar el APK\n";
    }
}

# Función para verificar permisos de root
sub check_permissions {
    if ($> != 0) {
        die "Este script debe ejecutarse como root\n";
    } else {
        print "Permisos de root verificados\n";
    }
}

# Función para obtener datos de una URL
sub fetch_data {
    my ($url) = @_;
    my $response = getstore($url, 'data/temp_file');
    if ($response == 200) {
        print "Datos obtenidos correctamente de $url\n";
    } else {
        die "Error al obtener datos de $url\n";
    }
}

# Función para descargar un APK desde una URL
sub download_apk {
    my ($url, $output_file) = @_;
    my $response = getstore($url, $output_file);
    if ($response == 200) {
        print "APK descargado correctamente en $output_file\n";
    } else {
        die "Error al descargar el APK\n";
    }
}

# Función para mostrar el menú interactivo
sub show_menu {
    while (1) {
        print "Seleccione una opción:\n";
        print "1) Descargar APK específico\n";
        print "2) Decompilar APK\n";
        print "3) Inyectar payload\n";
        print "4) Recompilar APK\n";
        print "5) Firmar y alinear APK\n";
        print "6) Verificar permisos de root\n";
        print "7) Obtener datos de una URL\n";
        print "8) Salir\n";
        print "Opción: ";
        chomp(my $option = <STDIN>);

        if ($option == 1) {
            print "URL del APK: ";
            chomp(my $url = <STDIN>);
            print "Ruta de salida del APK: ";
            chomp(my $output_file = <STDIN>);
            download_apk($url, $output_file);
        } elsif ($option == 2) {
            print "Ruta del archivo APK: ";
            chomp(my $apk_file = <STDIN>);
            print "Directorio de salida: ";
            chomp(my $output_dir = <STDIN>);
            if (-f $apk_file) {
                decompile_apk($apk_file, $output_dir);
            } else {
                print "El archivo APK no existe.\n";
            }
        } elsif ($option == 3) {
            print "Directorio objetivo: ";
            chomp(my $target_dir = <STDIN>);
            print "Archivo de payload: ";
            chomp(my $payload_file = <STDIN>);
            if (-d $target_dir && -f $payload_file) {
                inject_payload($target_dir, $payload_file);
            } else {
                print "Directorio objetivo o archivo de payload no válido.\n";
            }
        } elsif ($option == 4) {
            print "Directorio de entrada: ";
            chomp(my $input_dir = <STDIN>);
            print "Archivo APK de salida: ";
            chomp(my $output_apk = <STDIN>);
            if (-d $input_dir) {
                recompile_apk($input_dir, $output_apk);
            } else {
                print "El directorio de entrada no existe.\n";
            }
        } elsif ($option == 5) {
            print "Archivo APK a firmar: ";
            chomp(my $apk_file = <STDIN>);
            print "Ruta del keystore: ";
            chomp(my $keystore = <STDIN>);
            print "Alias del keystore: ";
            chomp(my $alias = <STDIN>);
            print "Contraseña del keystore: ";
            chomp(my $storepass = <STDIN>);
            if (-f $apk_file && -f $keystore) {
                sign_apk($apk_file, $keystore, $alias, $storepass);
            } else {
                print "Archivo APK o keystore no válido.\n";
            }
        } elsif ($option == 6) {
            check_permissions();
        } elsif ($option == 7) {
            print "URL para obtener datos: ";
            chomp(my $url = <STDIN>);
            fetch_data($url);
        } elsif ($option == 8) {
            print "Saliendo...\n";
            last;
        } else {
            print "Opción no válida, por favor intente de nuevo.\n";
        }
    }
}

# Mostrar el menú interactivo
show_menu();
