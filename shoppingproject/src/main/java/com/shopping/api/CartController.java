package com.shopping.api;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import com.shopping.entity.Cart;
import com.shopping.entity.ProductInOrder;
import com.shopping.entity.ProductInfo;
import com.shopping.entity.User;
import com.shopping.form.ItemForm;
import com.shopping.repository.ProductInOrderRepository;
import com.shopping.service.*;

import lombok.var;

import java.io.BufferedReader;
import java.io.FileReader;
import java.security.Principal;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/cart")
public class CartController {
    @Autowired
    CartService cartService;
    @Autowired
    UserService userService;
    @Autowired
    ProductService productService;
    @Autowired
    ProductInOrderService productInOrderService;
    @Autowired
    ProductInOrderRepository productInOrderRepository;
    
    private static String email=UserController.emailS;
  
    @GetMapping("/viewSessionData") 
    public java.util.Map<String,Integer> start(HttpServletRequest request) {
        Integer integer =(Integer) request.getSession().getAttribute("hitCounter");
        if(integer==null){
            integer=new Integer(0);
            integer++;
            request.getSession().setAttribute("hitCounter",integer);
        }else{
            integer++;
            request.getSession().setAttribute("hitCounter",integer);
        }
        java.util.Map<String,Integer> hitCounter=new HashMap<>();
        hitCounter.put("Hit Counter",integer);
        return hitCounter;
    }

    @PostMapping("")
    public ResponseEntity<Cart> mergeCart(@RequestBody Collection<ProductInOrder> productInOrders, User principal) {
    	try{BufferedReader bufferedReader = new BufferedReader(new FileReader("user.txt")) ;
	    String line = bufferedReader.readLine();
	    while(line != null) {
	        System.out.println(line);
	        email=line;
	        break;
	        }
	} catch (Exception e) {
		// TODO: handle exception
	}
	
    	System.out.println("Mail Post "+email);
    	
        User user = userService.findOne(email);
        System.out.println("Post data cart "+user +" Product order "+productInOrders);
        try {
            cartService.mergeLocalCart(productInOrders, user);
        } catch (Exception e) {
            ResponseEntity.badRequest().body("Merge Cart Failed");
        }
        
        return ResponseEntity.ok(cartService.getCart(user));
    }

    @GetMapping("")
    public Cart getCart() {
    	try {
    		BufferedReader bufferedReader = new BufferedReader(new FileReader("user.txt")) ;
    	    String line = bufferedReader.readLine();
    	    while(line != null) {
    	        System.out.println(line);
    	        email=line;
    	        break;
    	        }
		} catch (Exception e) {
			// TODO: handle exception
		}
    	
    	System.out.println("Mail "+email);
        User user = userService.findOne(email);
        System.out.println(user);
        return cartService.getCart(user);
    }


    @PostMapping("/add")
    public boolean addToCart(@RequestBody ItemForm form) {
        ProductInfo productInfo = productService.findOne(form.getProductId());
        try {
        BufferedReader bufferedReader = new BufferedReader(new FileReader("user.txt")) ;
	    String line = bufferedReader.readLine();
	    while(line != null) {
	        System.out.println(line);
	        email=line;
	        break;
	        }
        }catch (Exception e) {
			System.out.println(e);
		}
        System.out.println("Data >>"+productInfo+"  ");
        User user = userService.findOne(email);
        System.out.println("Data >>User "+user+"  ");
        try {
            mergeCart(Collections.singleton(new ProductInOrder(productInfo, form.getQuantity())), user);
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    @PutMapping("/{itemId}")
    public ProductInOrder modifyItem(@PathVariable("itemId") String itemId, @RequestBody Integer quantity, Principal principal) {
        User user = userService.findOne(principal.getName());
         productInOrderService.update(itemId, quantity, user);
        return productInOrderService.findOne(itemId, user);
    }

    @DeleteMapping("/{itemId}")
    public void deleteItem(@PathVariable("itemId") String itemId, Principal principal) {
        User user = userService.findOne(principal.getName());
         cartService.delete(itemId, user);
         // flush memory into DB
    }


    @PostMapping("/checkout")
    public ResponseEntity checkout(Principal principal) {
    	 try {
    	        BufferedReader bufferedReader = new BufferedReader(new FileReader("user.txt")) ;
    		    String line = bufferedReader.readLine();
    		    while(line != null) {
    		        System.out.println(line);
    		        email=line;
    		        break;
    		        }
    	        }catch (Exception e) {
    				System.out.println(e);
    			}
    	
        User user = userService.findOne(email);// Email as username
        cartService.checkout(user);
        return ResponseEntity.ok(null);
    }


}
