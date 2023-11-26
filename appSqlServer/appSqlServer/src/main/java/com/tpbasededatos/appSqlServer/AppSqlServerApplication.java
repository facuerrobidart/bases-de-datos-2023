package com.tpbasededatos.appSqlServer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AppSqlServerApplication {

	public static void main(String[] args) {
		Connection conexion;
		System.out.println("Iniciando Aplicacion");
		
		
        try {
        	conexion = Conector.establecerConexion();
        	
        	//query 1
        	QueryPruebaEjemplo query= new QueryPruebaEjemplo(conexion);
    		query.execute();
    		//query 2
    		TransaccionPrueba transaccion1= new TransaccionPrueba(conexion);
    		transaccion1.execute();
    		
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
        


	}

}
