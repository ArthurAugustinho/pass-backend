package com.pass.authservice.service;

import com.pass.authservice.config.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.User;

@Service
public class AuthService {

    @Autowired
    private JwtUtils jwtUtils;

    @Autowired
    private AuthenticationManager authenticationManager;

    public String authenticate(String username, String password) {
        // Criação do token de autenticação
        UsernamePasswordAuthenticationToken authenticationToken =
            new UsernamePasswordAuthenticationToken(username, password);

        // Autentica o usuário
        authenticationManager.authenticate(authenticationToken);

        // Se a autenticação for bem-sucedida, retorna o JWT
        return jwtUtils.generateToken(username);
    }
}
