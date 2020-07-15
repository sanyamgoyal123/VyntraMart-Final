package com.shopping.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import com.shopping.entity.User;
import com.shopping.security.JWT.JwtProvider;
import com.shopping.service.UserService;
import com.shopping.vo.request.LoginForm;
import com.shopping.vo.response.JwtResponse;

import java.io.FileWriter;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


@CrossOrigin
@RestController
public class UserController {

    @Autowired
    UserService userService;

    public	static PrincipalImp principalImp;

    public static String emailS;
    @Autowired
    JwtProvider jwtProvider;

    @Autowired
    AuthenticationManager authenticationManager;

    @PostMapping("/login")
    @ResponseBody
    public ResponseEntity<?> login(@RequestBody LoginForm loginForm) {
        // throws Exception if authentication failed

        try {
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginForm.getUsername(), loginForm.getPassword()));
            System.out.println(authentication+"  "+loginForm);
            SecurityContextHolder.getContext().setAuthentication(authentication);
           // String jwt = jwtProvider.generate(authentication);
            String jwt="eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJtYW5hZ2VyMUBlbWFpbC5jb20iLCJpYXQiOjE1NDY2Njk5MjksImV4cCI6MTU0Njc1NjMyOX0.OJdSH3wrQrCkU-pc3efPL2CX1t8H1SVWkLbzuQ_3e_-NUvFuwU8snaKZcmhG5kh5ffBUwDId4s8Hb5HjythGaw";
            UserDetails userDetails = (UserDetails) authentication.getPrincipal();
           // principalImp=new PrincipalImp(userDetails);
            System.out.println("user  details "+userDetails);
            User user = userService.findOne(userDetails.getUsername());
            System.out.println("Data --> "+user);
            if(userDetails.getUsername().equals(user.getEmail()))
            {
            	  FileWriter fileWriter;
				try {
					fileWriter = new FileWriter("user.txt");
					String fileContent = user.getEmail() ;
	                  fileWriter.write(fileContent);
	                  fileWriter.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
                  
            	 System.out.println("User Data --> "+user +"  "+jwt);
            	 Map<String,String> list=new HashMap<String,String>();
            	 list.put("token",jwt);
            	 list.put("account",user.getEmail());
            	 emailS=user.getEmail();
            	 list.put("name",user.getName());
            	 list.put("role", user.getRole());
            	//return  ResponseEntity.ok(new JwtResponse(jwt, user.getEmail(), user.getName(), user.getRole()));
            return new ResponseEntity<>(list,HttpStatus.OK);
            }
            } catch (AuthenticationException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
    }

    public String getEmailId()
    {
    	return emailS;
    }

    @PostMapping("/register")
    public ResponseEntity<User> save(@RequestBody User user) {
        try {
            return ResponseEntity.ok(userService.save(user));
        } catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @PutMapping("/profile")
    public ResponseEntity<User> update(@RequestBody User user, Principal principal) {

        try {
        if(!user.getEmail().isEmpty()) throw new IllegalArgumentException();{
           // if (!principal.getName().equals(user.getEmail())) throw new IllegalArgumentException();
            return ResponseEntity.ok(userService.update(user));
        }} catch (Exception e) {
            return ResponseEntity.badRequest().build();
        }
    }

    @GetMapping("/profile/{email}")
    public ResponseEntity<User> getProfile(@PathVariable("email") String email, Principal principal) {
        if (!email.isEmpty()) {
            return ResponseEntity.ok(userService.findOne(email));
        } else {
            return ResponseEntity.badRequest().build();
        }

    }
}
