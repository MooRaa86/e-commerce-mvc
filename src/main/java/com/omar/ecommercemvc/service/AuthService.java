package com.omar.ecommercemvc.service;

import com.omar.ecommercemvc.dao.UserDAO;
import com.omar.ecommercemvc.model.User;
import org.mindrot.jbcrypt.BCrypt;

public class AuthService {

    private final UserDAO userDAO =
            new UserDAO();

    public void register(User user) {

        String hashedPassword =
                BCrypt.hashpw(
                        user.getPassword(),
                        BCrypt.gensalt()
                );

        user.setPassword(hashedPassword);

        user.setRole("USER");

        userDAO.save(user);

    }

    public User login(String email,
                      String password) {

        User user =
                userDAO.findByEmail(email);

        if (user == null) {

            return null;
        }

        boolean isPasswordCorrect =
                BCrypt.checkpw(
                        password,
                        user.getPassword()
                );

        if (isPasswordCorrect) {

            return user;
        }

        return null;
    }

}