package com.grupo.protectora.servlet;

import com.grupo.protectora.dao.BaseDatos;
import com.grupo.protectora.dao.EmployeeDao;
import com.grupo.protectora.model.Trabajador;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.grupo.protectora.Util.MessageErrorSuccess.sendError;
import static com.grupo.protectora.Util.MessageErrorSuccess.sendSuccess;
import static com.grupo.protectora.dao.BaseDatos.jdbi;

@WebServlet("/edit-employee")
@MultipartConfig
public class EditEmployee extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    String idStr = request.getParameter("id");

    String name = request.getParameter("name");
    //Validamos campo name
    if (name == null || name.trim().isEmpty()) {
        sendError(response, "Name is required");
        return;
    }

    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    String document = request.getParameter("document");

    try {
        BaseDatos.connect();
        EmployeeDao employeeDao = jdbi.onDemand(EmployeeDao.class);

        if (action.equals("Register")) {
            employeeDao.add(name, phone, email, document);
        }else{
            int id = Integer.parseInt(idStr);

            Trabajador current = employeeDao.getByIdEmployee(id);
            employeeDao.modify(name, phone, email, document, id);

            sendSuccess(response, "successfully modified employee");
        }
    } catch (Exception e) {
        e.printStackTrace();
        sendError(response, "Server error" + e.getMessage());
    }
    }
}