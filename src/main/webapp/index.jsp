<%@ page import="com.grupo.protectora.model.Animal" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.grupo.protectora.dao.BaseDatos" %>
<%@ page import="static com.grupo.protectora.dao.BaseDatos.jdbi" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<%

    List<Animal> allAnimals = new ArrayList<>();

    try{
        BaseDatos.connect();
        AnimalDao animaldao = jdbi.onDemand(AnimalDao.class);

        allAnimals.addAll(animaldao.getAllAnimals());

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<main class="container py-5">
    <section class="py-5 text-center container">
        <div class="row py-lg-5">
            <div class="col-lg-6 col-md-8 mx-auto">
                <h1 class="fw-light">Animal House shelter</h1>
                <p class="lead text-body-primary">
                    Welcome to our Shelter, we hope you love our furry friends.
                </p>

                <p>
                    <a href="create-animal.jsp" class="btn btn-primary my-2">New Animal</a>
                </p>
            </div>
        </div>
    </section>

    <div class="row row-cols-1 row-cols-md-3">
        <%
            for (Animal animal : allAnimals) {
        %>
        <div class="col">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title fw-bold"><%= animal.getName() %></h5>
                    <p class="card-text text-muted">
                        <i><%= animal.getType() %></i>
                    </p>
                    <div class="d-flex justify-content-between">
                        <a href="view-animal.jsp?id=<%= animal.getId() %>" class="btn btn-sm btn-outline-primary">View Details</a>
                        <a href="delete-animal?id=<%= animal.getId() %>"
                           class="btn btn-sm btn-danger"
                           onclick="return confirm('¿Estás seguro de eliminar esta tienda?')">Delete</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>

</main>

<%@include file="includes/footer.jsp"%>