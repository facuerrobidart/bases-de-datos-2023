package com.tpbasededatos.appSqlServer;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

public class QueryPruebaEjemplo extends Query{

	
	public QueryPruebaEjemplo(Connection conexion) {
		super(conexion);
	}


    
	
	public void execute() {

		try {
			stmt = conexion.createStatement();
			rs = stmt.executeQuery("SELECT * FROM area");

			//muestra de resultados
			// Obtener los metadatos del ResultSet
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();

            // Procesar el ResultSet
            while (rs.next()) {
                // Iterar sobre todas las columnas
                for (int i = 1; i <= columnCount; i++) {
                    String columnName = rsmd.getColumnName(i);
                    String value = rs.getString(i);
                    System.out.println(columnName + ": " + value);
                }
                System.out.println("-------------------");
            }
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	}
}
