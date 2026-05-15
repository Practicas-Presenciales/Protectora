package com.grupo.protectora.dao;

import com.grupo.protectora.model.Animal;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class AnimalMapper implements RowMapper<Animal> {

    @Override
    public Animal map(ResultSet sr, StatementContext ctx) throws SQLException {
        return new Animal(
                sr.getInt("id"),
                sr.getString("nombre"),
                sr.getString("tipo"),
                sr.getInt("edad"),
                sr.getString("vacunas"),
                sr.getInt("id_trabajadores")
        );
    }
}