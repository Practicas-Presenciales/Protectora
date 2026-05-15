<%@ page import="com.grupo.protectora.model.Animal" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.grupo.protectora.dao.BaseDatos" %>
<%@ page import="static com.grupo.protectora.dao.BaseDatos.jdbi" %>
<%@ page import="com.grupo.protectora.dao.AnimalDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<main class="container py-5">

    <section class="py-5 text-center container">
        <div class="row py-lg-5">
            <div class="col-lg-6 col-md-8 mx-auto">

                <h1 class="fw-light">Animal House shelter</h1>

                <p class="lead text-body-primary">
                    Welcome to our Shelter, we hope you love our furry friends.
                </p>

                <p>
                    <a href="edit-animals.jsp" class="btn btn-primary my-2">New Animal</a>
                </p>

            </div>
        </div>
    </section>

    <div class="album py-5 bg-body-tertiary">

        <div class="container">

            <div class="container mb-4">
                <form class="row g-3 bg-light p-3" method="get" action="index.jsp">

                    <div class="col-md-5">
                        <input type="text" name="type" class="form-control" placeholder="Type animal...">
                    </div>

                    <div class="col-md-3">
                        <button type="submit" class="btn btn-primary w-100">
                            Filter animal
                        </button>
                    </div>

                </form>
            </div>

            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">

                <%
                    String type = request.getParameter("type");
                    List<Animal> allAnimals = new ArrayList<>();

                    try {
                        BaseDatos.connect();
                        AnimalDao animaldao = jdbi.onDemand(AnimalDao.class);
                        if (type != null && !type.isEmpty()) {
                            allAnimals.addAll(animaldao.getByType("%" + type + "%"));
                        } else {
                            allAnimals.addAll(animaldao.getAllAnimals());
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    for (Animal animal : allAnimals) {
                %>

                <div class="col">

                    <div class="card h-100 shadow-sm">

                        <div class="card-body">

                            <h5 class="card-title fw-bold">
                                <%= animal.getName() %>
                            </h5>

                            <p class="card-text text-muted">
                                <i><%= animal.getType() %></i>
                            </p>

                            <div class="d-flex justify-content-between">
                                <a href="view-animals.jsp?id=<%= animal.getId() %>" class="btn btn-sm btn-primary">View Details</a>
                                <a href="remove-animal?id=<%= animal.getId() %>"
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure you want to delete this animal?')">Delete
                                </a>
                                <a href="edit-animals.jsp?id=<%= animal.getId() %>"
                                   class="btn btn-warning px-4">
                                    Edit Animal
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</main>

<%@include file="includes/footer.jsp"%>