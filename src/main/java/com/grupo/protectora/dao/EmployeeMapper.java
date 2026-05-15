package com.grupo.protectora.dao;

import com.grupo.protectora.model.Trabajador;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;


import java.sql.ResultSet;
import java.sql.SQLException;

public class EmployeeMapper implements RowMapper<Trabajador> {
    @Override
    public Trabajador map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Trabajador(
                rs.getInt("id"),
                rs.getString("nombre"),
                rs.getString("telefono"),
                rs.getString("email"),
                rs.getString("dni")
        );
    }

}
