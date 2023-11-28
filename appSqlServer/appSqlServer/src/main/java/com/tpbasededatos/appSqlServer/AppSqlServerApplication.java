package com.tpbasededatos.appSqlServer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

public class AppSqlServerApplication {

	public static void main(String[] args) {
		Connection conexion;
		System.out.println("Iniciando Aplicacion");
		
		
        try {
        	conexion = Conector.establecerConexion();
			Scanner sc = new Scanner(System.in);
			int opcion = 0;
			System.out.println("Bienvenido al sistema de creacion de personal, por favor seleccione una opcion (0 para salir)");
			do {
				System.out.println("1. Crear Personal Jerarquico");
				System.out.println("2. Crear Personal Profesional");
				System.out.println("3. Crear Personal No profesional");
				opcion = sc.nextInt();
				switch (opcion) {
				case 1:
					Registro registro= Utils.InputRegistrarPersonalJerarquico();
					TRX_CREAR_PERSONAL_JERARQUICO trx = new TRX_CREAR_PERSONAL_JERARQUICO(conexion);
		    		trx.execute(registro);
					break;
				default:
					break;
				}
			} while (opcion != 0);
        	
    		
    		
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
        


	}

}
