<%@ page import="com.grupo.protectora.model.Animal" %>
<%@ page import="com.grupo.protectora.dao.BaseDatos" %>
<%@ page import="com.grupo.protectora.dao.AnimalDao" %>
<%@ page import="static com.grupo.protectora.dao.BaseDatos.jdbi" %>
<%@ page import="com.grupo.protectora.dao.EmployeeDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.grupo.protectora.model.Trabajador" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<script>
    $(document).ready(function () {
        $("#save-button").click(function (event) {
            event.preventDefault();
            const form = $("#animal-form")[0];
            const data = new FormData(form);

            $("#save-button").prop("disabled", true);
            $.ajax({
                type: "POST",
                url: "edit-animal",
                data: data,
                processData: false,
                contentType: false,
                success: function (data) {
                    $("#result").html(data);
                    $("#save-button").prop("disabled", false);
                },
                error: function (error) {
                    $("#result").html(error.responseText);
                    $("#save-button").prop("disabled", false);
                }
            });
        });
    });
</script>

<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <%
                String id = request.getParameter("id");
                String action = "Register";
                Animal animal = null;
                Trabajador employeeUpdate = null;

                List<Trabajador> allEmployees = new ArrayList<>();

                if (id != null) {
                    action = "Edit";
                    try {
                        BaseDatos.connect();
                        AnimalDao animalDao = jdbi.onDemand(AnimalDao.class);
                        animal = animalDao.getByIdAnimal(Integer.parseInt(id));

                        EmployeeDao employeeDao = jdbi.onDemand(EmployeeDao.class);

                        int idEmployee = animal.getId_employee();
                        employeeUpdate = employeeDao.getByIdEmployee(idEmployee);
                    } catch (ClassNotFoundException cnfe) {
                        cnfe.printStackTrace();
                    }
                }


                try {
                    BaseDatos.connect();
                    EmployeeDao employeeDao = jdbi.onDemand(EmployeeDao.class);
                    allEmployees.addAll(employeeDao.getAllEmployees());

                } catch (ClassNotFoundException cnfe) {
                    cnfe.printStackTrace();
                }
            %>

            <h2 class="mb-4"><%= action %> Animal</h2>

            <form id="animal-form" method="post">
                <div class="mb-3">
                    <label class="form-label">Name</label>
                    <input type="text" name="name" class="form-control"
                         value="<%= animal != null ? animal.getName() : ""%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Type</label>
                    <input type="text" name="type" class="form-control"
                         value="<%= animal != null ? animal.getType() : "" %>">
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Age</label>
                        <input type="number" name="age" class="form-control"
                             value="<%= animal != null ? animal.getAge() : "" %>">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Vaccines</label>
                        <input type="text" name="vaccines" class="form-control"
                             value="<%= animal != null ? animal.getVaccines() : "" %>">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Caretaker</label>
                        <select name="id_employee" class="form-control">
                            <%
                                if (action.equalsIgnoreCase("Edit")) {
                            %>
                            <option value="<%= employeeUpdate.getId()%>">Currently: <%= employeeUpdate.getName()%></option>
                            <%
                                }
                            %>
                            <%
                                for (Trabajador employee : allEmployees) {
                            %>
                            <option value="<%= employee.getId()%>"> <%= employee.getName()%> </option>
                            <%
                              }
                            %>
                        </select>
                    </div>
                </div>
                <input type="hidden" name="id" value="<%= id != null ? id : ""%>">
                <input type="hidden" name="action" value="<%= action %>">

                <button id="save-button" class="btn btn-primary w-100"><%= action %> Animal</button>
            </form>
            <div id="result" class="mt-3"></div>
        </div>
    </div>
</main>

<%@include file="includes/footer.jsp"%>