package com.grupo.protectora.dao;

import com.grupo.protectora.model.Animal;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface AnimalDao {

    @SqlUpdate("INSERT INTO animales (nombre, tipo, edad, vacunas, id_trabajadores) VALUES (?,?,?,?,?)")
    void add(String name, String type, int age, String vaccines, int id_employee);

    @SqlUpdate("DELETE FROM animales WHERE id = ?")
    void delete(int id);

    @SqlUpdate("UPDATE animales SET nombre=?, tipo=?, edad=?, vacunas=?, id_trabajadores=? WHERE id = ?")
    void modify(String name, String type, int age, String vaccines, int id_employee, int id);

    @SqlQuery("SELECT COUNT(*) FROM animales WHERE id_trabajadores = ?")
    int countByEmployeeId(int idEmployee);

    @SqlQuery("SELECT * FROM animales")
    @UseRowMapper(AnimalMapper.class)
    List<Animal> getAllAnimals();

    @SqlQuery("SELECT * FROM animales WHERE id = ?")
    @UseRowMapper(AnimalMapper.class)
    Animal getByIdAnimal(int id_animal);

    @SqlQuery("SELECT * FROM animales WHERE id = ?")
    @UseRowMapper(AnimalMapper.class)
    List<Animal> getAllAnimalsByEmployeeId(int id_employee);
}
