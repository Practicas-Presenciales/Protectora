package com.grupo.protectora.servlet;

import com.grupo.protectora.dao.AnimalDao;
import com.grupo.protectora.dao.BaseDatos;
import com.grupo.protectora.dao.EmployeeDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.grupo.protectora.Util.MessageErrorSuccess.sendError;
import static com.grupo.protectora.dao.BaseDatos.jdbi;

@WebServlet("/delete-employee")
public class DeleteEmployee {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try{
            BaseDatos.connect();
            EmployeeDao employeeDao = jdbi.onDemand(EmployeeDao.class);

            AnimalDao animalDao = jdbi.onDemand(AnimalDao.class);
            int countAnimal = animalDao.countByEmployeeId(id);

            if (countAnimal > 0 ){
                sendError (response, "Sorry, this employee has animals in his care, it cannot be deleted");
                return;
            }

            employeeDao.delete(id);

            response.sendRedirect("employees-list.jsp");

        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        }
    }
}
