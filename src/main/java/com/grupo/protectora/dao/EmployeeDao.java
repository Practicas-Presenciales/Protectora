package com.grupo.protectora.dao;

import com.grupo.protectora.model.Trabajador;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface EmployeeDao {
    @SqlUpdate("INSERT INTO trabajadores (nombre, telefono, email, dni) VALUES (?, ? ,?, ?)")
    void add(String name, String phone, String email, String document);

    @SqlUpdate("DELETE FROM trabajadores WHERE id= ?")
    void delete(int id);

    @SqlUpdate("UPDATE trabajadores SET nombre = ?, telefono = ?, email = ?, dni = ? WHERE id = ?")
    void modify (String name, String phone, String email, String document,  int id);

    @SqlQuery("SELECT * FROM trabajadores")
    @UseRowMapper(EmployeeMapper.class)
    List<Trabajador> getAllEmployees();

    @SqlQuery("SELECT * FROM trabajadores WHERE id = ?")
    @UseRowMapper(EmployeeMapper.class)
    Trabajador getByIdEmployee(int id);

    @SqlQuery("SELECT * FROM trabajadores WHERE nombre LIKE ?")
    @UseRowMapper(EmployeeMapper.class)
    List<Trabajador> getByName(String name);


}