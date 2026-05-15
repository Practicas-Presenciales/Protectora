package com.grupo.protectora.model;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Trabajador {
    private int id;
    private String name;
    private String phone;
    private String email;
    private String document;
}