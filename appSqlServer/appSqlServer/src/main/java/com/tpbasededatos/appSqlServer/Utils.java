package com.tpbasededatos.appSqlServer;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Scanner;

public class Utils {

    public static Registro InputRegistrarPersonalJerarquico() {
        String formato = "dd/MM/yyyy";
        Scanner sc = new Scanner(System.in);
        System.out.println("Ingrese el nombre del personal");
        String nombre = sc.nextLine();
        System.out.println("Ingrese el apellido del personal");
        String apellido = sc.nextLine();
        System.out.println("Ingrese el dni del personal");
        String dni = sc.nextLine();
        System.out.println("Ingrese el genero del personal");
        char genero = sc.nextLine().charAt(0);
        System.out.println("Ingrese la fecha de nacimiento del personal");
        String fechaNacimiento = sc.nextLine();
        SimpleDateFormat sdf = new SimpleDateFormat(formato);
        java.util.Date fechaNacimientoDate=null;
		try {
			fechaNacimientoDate = sdf.parse(fechaNacimiento);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        Date fechaNacimientoSql = new Date(fechaNacimientoDate.getTime());

        System.out.println("Ingrese la contraseña del personal");
        String contraseña = sc.nextLine();
        System.out.println("Ingrese la huella del personal");
        String huella = sc.nextLine();
        System.out.println("Ingrese el numero de area del personal");
        int numero_area = sc.nextInt();
        sc.nextLine();  // consume the newline
        System.out.println("Ingrese la fecha de inicio del personal");
        String fecha_de_inicio = sc.nextLine();
        java.util.Date fecha_de_inicioDate=null;
        try {
            fecha_de_inicioDate = sdf.parse(fecha_de_inicio);
        } catch (ParseException e) {
            e.printStackTrace();
        }       
        Date fecha_de_inicioSql = new Date(fecha_de_inicioDate.getTime());
        Registro registro = new Registro( nombre, apellido, dni, genero, fechaNacimientoSql, contraseña, huella, numero_area, fecha_de_inicioSql );
        return registro;
    }

}
