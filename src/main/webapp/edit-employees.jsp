<%@ page import="com.grupo.protectora.model.Trabajador" %>
<%@ page import="com.grupo.protectora.dao.BaseDatos" %>
<%@ page import="com.grupo.protectora.dao.EmployeeDao" %>
<%@ page import="static com.grupo.protectora.dao.BaseDatos.jdbi" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<script>
    $(document).ready(function () {
        $("#save-button").click(function (event) {
            event.preventDefault();
            const form = $("#employee-form")[0];
            const data = new FormData(form);

            $("#save-button").prop("disabled", true);
            $.ajax({
                type: "POST",
                url: "edit-employee",
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
                Trabajador employee = null;

                if (id != null) {
                    action = "Edit";
                    try {
                        BaseDatos.connect();
                        EmployeeDao employeeDao = jdbi.onDemand(EmployeeDao.class);
                        employee = employeeDao.getByIdEmployee(Integer.parseInt(id));

                    } catch (ClassNotFoundException cnfe) {
                        cnfe.printStackTrace();
                    }
                }
            %>

            <h2 class="mb-4"><%= action %> Employee</h2>

            <form id="employee-form" method="post">
                <div class="mb-3">
                    <label class="form-label">Name</label>
                    <input type="text" name="name" class="form-control"
                         value="<%= employee != null ? employee.getName() : ""%>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="text" name="email" class="form-control"
                         value="<%= employee != null ? employee.getEmail() : "" %>">
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Phone</label>
                        <input type="text" name="phone" class="form-control"
                             value="<%= employee != null ? employee.getPhone() : "" %>">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Document</label>
                        <input type="text" name="document" class="form-control"
                             value="<%= employee != null ? employee.getDocument() : "" %>">
                    </div>
                </div>

                <input type="hidden" name="id" value="<%= id != null ? id : ""%>">
                <input type="hidden" name="action" value="<%= action %>">

                <button id="save-button" class="btn btn-primary w-100"><%= action %> Employee</button>
            </form>
          <div id="result" class="mt-3"></div>
        </div>
    </div>
</main>

<%@include file="includes/footer.jsp"%>