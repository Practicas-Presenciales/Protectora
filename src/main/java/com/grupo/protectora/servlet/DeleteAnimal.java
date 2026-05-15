package com.grupo.protectora.servlet;

import com.grupo.protectora.dao.AnimalDao;
import com.grupo.protectora.dao.BaseDatos;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.grupo.protectora.dao.BaseDatos.jdbi;

@WebServlet("/remove-animal")
public class DeleteAnimal extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws SecurityException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        // Conectar bbdd
        try {
            BaseDatos.connect();
            AnimalDao animalDao = jdbi.onDemand(AnimalDao.class);
            animalDao.delete(id);

            // le digo  que hacer una vez borrado
            response.sendRedirect("index.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        }
    }
}
