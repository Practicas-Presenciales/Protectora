<%@ page import="com.grupo.protectora.model.Trabajador" %>
<%@ page import="com.grupo.protectora.dao.BaseDatos" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.grupo.protectora.dao.EmployeeDao" %>
<%@ page import="static com.grupo.protectora.dao.BaseDatos.jdbi" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>

<%

    List<Trabajador> allEmployees = new ArrayList<>();

  try{
      BaseDatos.connect();
      EmployeeDao employeeDao = jdbi.onDemand(EmployeeDao.class);
      allEmployees.addAll(employeeDao.getAllEmployees());
    } catch (ClassNotFoundException cnfe) {
        cnfe.printStackTrace();
    }
%>

<main class="container py-5">
    <h2 class="mb-4">Employee Management</h2>
    <div class="table-responsive">
        <table class="table table-striped">
            <thead class="table-dark">
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Document</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
            <%
              for (Trabajador employee : allEmployees) {
            %>
                <tr>
                    <td><%= employee.getName() %></td>
                    <td><%= employee.getEmail() %></td>
                    <td><%= employee.getPhone()%></td>
                    <td><%= employee.getDocument()%></td>
                    <td>

                        <a href="view-employees.jsp?id=<%= employee.getId() %>"
                           class="btn btn-warning px-4">
                            View Employee
                        </a>

                        <a href="delete-employee?id=<%= employee.getId() %>" class="btn btn-sm btn-outline-dark"
                               onclick="return confirm('Are you sure you want to delete this employee?')">
                              Delete
                        </a>

                        <a href="edit-employee.jsp?id=<%= employee.getId() %>"
                           class="btn btn-warning px-4">
                            Edit Employee
                        </a>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</main>

<%@include file="includes/footer.jsp"%>