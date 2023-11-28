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
        Registro registro = new Registro( nombre, apellido, dni, genero, fechaNacimientoSql, contraseña, huella);
        return registro;
    }

}
