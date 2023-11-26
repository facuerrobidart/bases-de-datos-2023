package com.tpbasededatos.appSqlServer;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public abstract class Query {
	protected Connection conexion;

	Statement stmt = null;
    ResultSet rs = null;
	public Query(Connection conexion) {
		this.conexion=conexion;
	}
	
	public abstract void execute();
}
