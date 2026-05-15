<%@ page import="com.grupo.protectora.model.Trabajador" %>
<%@ page import="com.grupo.protectora.dao.EmployeeDao" %>
<%@ page import="com.grupo.protectora.dao.BaseDatos" %>
<%@ page import="static com.grupo.protectora.dao.BaseDatos.jdbi" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="includes/header.jsp"%>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    Trabajador employee = null;

    try {
        BaseDatos.connect();
        EmployeeDao employeeDao = jdbi.onDemand(EmployeeDao.class);
        employee = employeeDao.getByIdEmployee(id);
    } catch (ClassNotFoundException cnfe) {
        cnfe.printStackTrace();
    }
%>

<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-lg border-0">
                <div class="card-header bg-dark text-white p-4">
                    <h1 class="display-5 mb-0"><%= employee.getName() %></h1>
                </div>

                <div class="card-body p-5">
                    <div class="row mb-4">
                        <div class="col-sm-4 text-muted fw-bold">Email:</div>
                        <div class="col-sm-8 fs-5"><%= employee.getEmail() %></div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-sm-4 text-muted fw-bold">Document:</div>
                        <div class="col-sm-8 fs-5"><%= employee.getDocument()%></div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-sm-4 text-muted fw-bold">Phone:</div>
                        <div class="col-sm-8 fs-5"><%= employee.getPhone() %></div>
                    </div>

                    <div class="d-flex gap-3 mt-4">
                        <a href="employees-list.jsp" class="btn btn-outline-secondary px-4">
                            Back to all employees
                        </a>

                        <a href="delete-employees?id=<%= employee.getId() %>"
                           class="btn btn-danger px-4"
                           onclick="return confirm('Are you sure you want to delete this animal?')">
                            Delete Employee
                        </a>

                        <a href="edit-employee?id=<%= employee.getId() %>"
                           class="btn btn-warning px-4">
                            Edit Employee
                        </a>

                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@include file="includes/footer.jsp"%>