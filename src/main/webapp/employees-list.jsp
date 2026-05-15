<%@ page import="com.grupo.protectora.model.Trabajador" %>
<%@ page import="com.grupo.protectora.dao.BaseDatos" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.grupo.protectora.dao.EmployeeDao" %>
<%@ page import="static com.grupo.protectora.dao.BaseDatos.jdbi" %>
<%@ page import="static com.grupo.protectora.Util.MessageErrorSuccess.sendError" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>

<%

    List<Trabajador> allEmployees = new ArrayList<>();

    String searchName = request.getParameter("searchName");

  try{
      BaseDatos.connect();
      EmployeeDao employeeDao = jdbi.onDemand(EmployeeDao.class);

      if(searchName !=null) {
          allEmployees.addAll(employeeDao.getByName("%" + searchName + "%"));
      } else{
          allEmployees.addAll(employeeDao.getAllEmployees());
      }
    } catch (ClassNotFoundException cnfe) {
        cnfe.printStackTrace();
    }
%>

<main class="container py-5">
    <h2 class="mb-4">Employee Management</h2>

    <p>
        <a href="edit-employees.jsp" class="btn btn-primary my-2">New Employee</a>
    </p>

    <%
        if ("1".equals(request.getParameter("error"))) {
    %>
    <div class="alert alert-danger">
        <p>Sorry, this employee has animals in his care, it cannot be deleted</p>
    </div>
    <%
        }
    %>

    <form class="row g-3 p-3" method="get" action="employees-list.jsp">
        <div class="col-md-6">
            <input type="text" name="searchName" class="form-control" placeholder="Search name...">
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-outline-dark w-100">Search</button>
        </div>
    </form>

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
                           class="btn btn-sm btn-primary">
                            View Employee
                        </a>

                        <a href="delete-employee?id=<%= employee.getId() %>" class="btn btn-sm btn-danger"
                               onclick="return confirm('Are you sure you want to delete this employee?')">
                              Delete
                        </a>

                        <a href="edit-employees.jsp?id=<%= employee.getId() %>"
                           class="btn btn-sm btn-warning px-4">
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