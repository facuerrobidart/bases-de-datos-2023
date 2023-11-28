package com.tpbasededatos.appSqlServer;

import java.sql.Date;

public class Registro {

	 private int idPersonal;
	    private String nombre;
	    private String apellido;
	    private String dni;
	    private char genero;
	    private Date fechaNacimiento;
	    private String contraseña;
	    private String huella;
		private int numero_area;
		private Date fecha_de_inicio;
	    // Constructor
	    public Registro( String nombre, String apellido, String dni, char genero, Date fechaNacimiento, String contraseña, String huella, int numero_area, Date fecha_de_inicio) {
	        
	        this.nombre = nombre;
	        this.apellido = apellido;
	        this.dni = dni;
	        this.genero = genero;
	        this.fechaNacimiento = fechaNacimiento;
	        this.contraseña = contraseña;
	        this.huella = huella;
			this.numero_area = numero_area;
			this.fecha_de_inicio = fecha_de_inicio;
	    }

	    // Getters y Setters
	    public int getIdPersonal() {
	        return idPersonal;
	    }

	    public void setIdPersonal(int idPersonal) {
	        this.idPersonal = idPersonal;
	    }

	    public String getNombre() {
	        return nombre;
	    }

	    public void setNombre(String nombre) {
	        this.nombre = nombre;
	    }

	    public String getApellido() {
	        return apellido;
	    }

	    public void setApellido(String apellido) {
	        this.apellido = apellido;
	    }

	    public String getDni() {
	        return dni;
	    }

	    public void setDni(String dni) {
	        this.dni = dni;
	    }

	    public char getGenero() {
	        return genero;
	    }

	    public void setGenero(char genero) {
	        this.genero = genero;
	    }

	    public Date getFechaNacimiento() {
	        return fechaNacimiento;
	    }

	    public void setFechaNacimiento(Date fechaNacimiento) {
	        this.fechaNacimiento = fechaNacimiento;
	    }

	    public String getContraseña() {
	        return contraseña;
	    }

	    public void setContraseña(String contraseña) {
	        this.contraseña = contraseña;
	    }

	    public String getHuella() {
	        return huella;
	    }

	    public void setHuella(String huella) {
	        this.huella = huella;
	    }

		public int getNumero_area() {
			return numero_area;
		}
		
		public void setNumero_area(int numero_area) {
			this.numero_area = numero_area;
		}

		public Date getFecha_de_inicio() {
			return fecha_de_inicio;
		}

		public void setFecha_de_inicio(Date fecha_de_inicio) {
			this.fecha_de_inicio = fecha_de_inicio;
		}


}
