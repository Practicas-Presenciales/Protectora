package com.grupo.protectora.Util;

import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class MessageErrorSuccess {

    // mensajes de error/exito
    public static void sendSuccess(HttpServletResponse response, String message) throws IOException {
        sendMessage(response, "success", message);
    }

    public static void sendError(HttpServletResponse response, String message) throws IOException {
        sendMessage(response, "danger", message);
    }

    public static void sendMessage(HttpServletResponse response, String type, String message) throws IOException {
        response.getWriter().println("<div class=\"alert alert-" + type + "\" role=\"alert\">\n" + message + "</div>");
    }
}
