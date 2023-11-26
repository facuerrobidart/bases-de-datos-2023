package com.tpbasededatos.appSqlServer;

import java.sql.Connection;
import java.sql.SQLException;

public class TransaccionPrueba extends Query{

	public TransaccionPrueba(Connection conexion) {
		super(conexion);
	}

	@Override
	public void execute() {
		try {
            conexion.setAutoCommit(false);

            stmt = conexion.createStatement();
            rs = stmt.executeQuery("SELECT * FROM area");

            /*Esta comentado para no arruinar los datos mock
            stmt.executeUpdate("INSERT INTO area (numero_area, nombre, nivel) VALUES\r\n" + //
            		"(6, 'Juan Pérez', 1),\r\n" + //
            		"(7, 'María Rodríguez', 2),\r\n" + //
            		"(8, 'Luis González', 3),\r\n" + //
            		"(9, 'Ana Martínez', 4),\r\n" + //
            		"(10, 'Pedro Sánchez', 5);");
*/
            //Si salio bien
            conexion.commit();
            System.out.println("Transaccion completada exitosamente");
        } catch (SQLException e) {
            e.printStackTrace();
            // Si sale mal, hacer rollback de la transacción
            try {
                conexion.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                conexion.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
	}
	
	

}
