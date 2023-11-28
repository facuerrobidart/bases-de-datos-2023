package com.tpbasededatos.appSqlServer;

import java.sql.Connection;
import java.sql.SQLException;

public class TRX_CREAR_PERSONAL_JERARQUICO extends Query {

	public TRX_CREAR_PERSONAL_JERARQUICO(Connection conexion) {
		super(conexion);
		// TODO Auto-generated constructor stub
	}

	public void execute(Registro registro) {
		try {
            conexion.setAutoCommit(false);

            stmt = conexion.createStatement();
            
            System.out.println("Transaccion a ejecutar: "+ "INSERT INTO personal (id_personal, nombre, apellido, dni, genero, fecha_nacimiento, contraseña, huella) VALUES "
            		+ "("+ registro.getIdPersonal() +", '"+registro.getNombre()+"', '"+registro.getApellido()+"', "+registro.getDni()+", '"+registro.getGenero()+"', '"+registro.getFechaNacimiento()+"', '"+registro.getContraseña()+"', '"+registro.getHuella()+"')");
            
            stmt.executeUpdate("INSERT INTO personal (id_personal, nombre, apellido, dni, genero, fecha_nacimiento, contraseña, huella) VALUES "
            		+ "("+ registro.getIdPersonal() +", '"+registro.getNombre()+"', '"+registro.getApellido()+"', "+registro.getDni()+", '"+registro.getGenero()+"', '"+registro.getFechaNacimiento()+"', '"+registro.getContraseña()+"', '"+registro.getHuella()+"')");
            
            System.out.println("INSERT INTO personal_jerarquico (id_personal, numero_area, fecha_de_inicio)"
            		+ "VALUES "
            		+ "("+ registro.getIdPersonal() +", '"+registro.getNumero_area()+"', '"+registro.getFecha_de_inicio()+"')");
            
            stmt.executeUpdate("INSERT INTO personal_jerarquico (id_personal, numero_area, fecha_de_inicio)"
            		+ "VALUES "
            		+ "("+ registro.getIdPersonal() +", '"+registro.getNumero_area()+"', '"+registro.getFecha_de_inicio()+"',3)");
            //	    + "("+ registro.getIdPersonal() +", '"+registro.getNumero_area()+"', '"+registro.getFecha_de_inicio()+"')");
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

	@Override
	public void execute() {
		// TODO Auto-generated method stub
		
	}

	

}
