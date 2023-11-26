package com.tpbasededatos.appSqlServer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conector {
	
	public static Connection establecerConexion() throws SQLException {

		String usuario= "sa";
		String contraseña = "Password123";
		
		Connection conexion=null;
	    
		conexion = DriverManager.getConnection(
			        "jdbc:sqlserver://localhost:1433;databaseName=master;encrypt=false;trustServerCertificate=true",
			        usuario,
			        contraseña
		);
		System.out.println("Conexion exitosa con la base de datos");
		
		
		return conexion;
	}
}
