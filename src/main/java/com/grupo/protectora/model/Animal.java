package com.grupo.protectora.model;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Animal {
    private  int id;
    private String name;
    private String type;
    private int age;
    private String vaccines;
    private int id_employee;

}


