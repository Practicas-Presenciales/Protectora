package com.grupo.protectora.servlet;


import com.grupo.protectora.dao.AnimalDao;
import com.grupo.protectora.dao.BaseDatos;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jdbi.v3.core.enums.DatabaseValue;

import java.io.IOException;

import static com.grupo.protectora.Util.MessageErrorSuccess.sendError;
import static com.grupo.protectora.Util.MessageErrorSuccess.sendSuccess;
import static com.grupo.protectora.dao.BaseDatos.jdbi;

@WebServlet("/edit-animal")
@MultipartConfig
public class EditAnimal extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        // recogemos la acción y el id para saber si editamos o creamos
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        String id_employee = request.getParameter("id_employee");

        int id = 0;
        if (idStr != null && !idStr.trim().isEmpty()) {
            id = Integer.parseInt(idStr);
        }

        String name = request.getParameter("name");
        // Validar campos vacío
        if (name == null || name.trim().isEmpty()) {
            sendError(response, "The name field must be required");
            return;
        }

        String type = request.getParameter("type");
        String ageStr = request.getParameter("age");
        if (ageStr.isEmpty()) {
            sendError(response ,"The animal's age is required");
            return;
        }

        int age = Integer.parseInt(ageStr);
        String vaccines = request.getParameter("vaccines");
        int id_employeeInt = 0;
        id_employeeInt = Integer.parseInt( id_employee);

        // Si va bien conectar bbdd
        try {
            BaseDatos.connect();
            AnimalDao animalDao = jdbi.onDemand(AnimalDao.class);

            if( id_employeeInt <= 0) {
                sendError(response, "The employee's ID is not valid");
                return;
            }

            // Comprobamos si registramos uno nuevo
            if (action.equals("Register")) {
                animalDao.add(name,type,age,vaccines,id_employeeInt);
                sendSuccess(response, "The animal has been added correctly");
            } else  {
                // modificamos
                animalDao.modify(name,type,age,vaccines, id_employeeInt, id);
                sendSuccess( response,"The animal has been modified correctly");
            }
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
            sendError(response,"An error occurred while saving." );
        }


    }
}
