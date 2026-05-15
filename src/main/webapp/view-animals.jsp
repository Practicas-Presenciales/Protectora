<%@ page import="com.grupo.protectora.model.Animal" %>
<%@ page import="com.grupo.protectora.dao.BaseDatos" %>
<%@ page import="static com.grupo.protectora.dao.BaseDatos.jdbi" %>
<%@ page import="com.grupo.protectora.dao.AnimalDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    Animal animal = null;

    try {
        BaseDatos.connect();
        AnimalDao animalDao = jdbi.onDemand(AnimalDao.class);
        animal = animalDao.getByIdAnimal(id);
    } catch (ClassNotFoundException cnfe) {
        cnfe.printStackTrace();
    }
%>

<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-lg border-0">
                <div class="card-header bg-dark text-white p-4">
                    <h1 class="display-5 mb-0"><%= animal.getName() %></h1>
                </div>

                <div class="card-body p-5">
                    <div class="row mb-4">
                        <div class="col-sm-4 text-muted fw-bold">Type:</div>
                        <div class="col-sm-8 fs-5"><%= animal.getType() %></div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-sm-4 text-muted fw-bold">Age:</div>
                        <div class="col-sm-8 fs-5"><%= animal.getAge()%></div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-sm-4 text-muted fw-bold">Vaccines:</div>
                        <div class="col-sm-8 fs-5"><%= animal.getVaccines() %></div>
                    </div>

                    <div class="d-flex gap-3 mt-4">
                        <a href="index.jsp" class="btn btn-outline-secondary px-4">
                            Back to all animals
                        </a>

                        <a href="delete-animals?id=<%= animal.getId() %>"
                           class="btn btn-danger px-4"
                           onclick="return confirm('Are you sure you want to delete this animal?')">
                            Delete Animal
                        </a>

                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@include file="includes/footer.jsp"%>