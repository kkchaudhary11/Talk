package com.talk.controller;


import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.MediaType;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.util.UriComponentsBuilder;

import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataParam;
import com.talk.dao.BlogDAO;
import com.talk.dao.UserDAO;
import com.talk.model.Blog;
import com.talk.model.User;

@RestController
public class RESTController {

	@Autowired
	UserDAO userdao;
	
	@Autowired
	BlogDAO blogdao;
	
	@Autowired
    ServletContext context;
	
	@GetMapping("/userdata")
	public ResponseEntity<User> UserProfile(){
		
		//authentication
		String username = null;
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null && !auth.getName().equals("anonymousUser")) {
			System.out.println(auth.getName());
			// System.out.println("User present");
			username = auth.getName();
		} 
		
		
		//return if not authorized
		if(username==null){
			return new ResponseEntity<User>(HttpStatus.NETWORK_AUTHENTICATION_REQUIRED);	
		}
		
		//get user data if user is authorized
			User user = userdao.getUserByEmail(username);
			return new ResponseEntity<User>(user, HttpStatus.OK);
		
	}
	
	@GetMapping("admin/allusers")
		public ResponseEntity<List<User>> allUsers(){
		
		List<User> list = userdao.listUser();
		
		return new ResponseEntity<List<User>>(list, HttpStatus.OK);
		
			}

	
	@PostMapping("/deleteuser")
	public ResponseEntity<List<User>> deleteUser(@RequestBody String inputdata){
		System.out.println(inputdata);
	
		
		userdao.deleteUser(Integer.parseInt(inputdata));
	
		List<User> list = userdao.listUser();
		return new ResponseEntity<List<User>>(list, HttpStatus.OK);
	
		}
	
	
	@PostMapping("/updateuser")
	public ResponseEntity<String> updateUser(@RequestBody JSONObject data){
		System.out.println(data);
		
		int userid = Integer.parseInt(data.get("UserId").toString());
	
		User user = userdao.getUserById(userid);
		
		user.setUserId(userid);
		user.setUsername(data.get("Username").toString());
		user.setPhone(data.get("Phone").toString());
		user.setCity(data.get("City").toString());
		user.setDob(data.get("DOB").toString());
		user.setGender(data.get("Gender").toString());
		
		userdao.updateUser(user);
		
		JSONObject json = new JSONObject();
        
        json.put("status", "DETAILS UPDATED");
        System.out.println(json.toString());
        
        return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
		}
	
	
	
	@PostMapping("/updatepassword")
	public ResponseEntity<String> UserPasswordUpdate(@RequestBody String password, Principal principal){
		
		
		System.out.println(principal.getName());
		System.out.println(password);
		
		User user = userdao.getUserByEmail(principal.getName());
		user.setPassword(password);
		userdao.updateUser(user);
		
		JSONObject json = new JSONObject();
        
        json.put("status", "PASSWORD UPDATED");
        System.out.println(json.toString());
        
        return new ResponseEntity<String>(json.toString(), HttpStatus.ACCEPTED);
	}
	
	@RequestMapping(value = "/updateProfilePicture/", method = RequestMethod.POST )
    public ResponseEntity<String> updateProfilePicture(MultipartHttpServletRequest request , HttpServletResponse response , UriComponentsBuilder ucBuilder) {
        
		System.out.println( request.getHeader("user") );
		
		System.out.println( request.getFile("file").getName() );
		System.out.println( request.getFile("file").getSize() );
		System.out.println( request.getFile("file").getContentType() );
		System.out.println( request.getFile("file").getOriginalFilename() );
		
		JSONObject json = new JSONObject();
		
		BufferedOutputStream stream = null;
		
		try
	    {
			String path = context.getRealPath("/");
	        
	        System.out.println(path);
	        
	        File directory = null;
	        
	        System.out.println( request.getFile("file") );
	        
	        if (request.getFile("file").getContentType().contains("image"))
	        {
	            directory = new File(path + "\\resources\\images");
	            
	            System.out.println(directory);
	            
	            byte[] bytes = null;
	            File file = null;
	            bytes = request.getFile("file").getBytes();
	            
	            if (!directory.exists()) directory.mkdirs();
	           
	            
	            	file = new File(directory.getAbsolutePath() + System.getProperty("file.separator") + request.getHeader("user") + ".jpg");
		            
		            System.out.println(file.getAbsolutePath());
		            
		            stream = new BufferedOutputStream(new FileOutputStream(file));
		            stream.write(bytes);
		            
		            json.put("status", "IMAGE UPLOADED");
		            
		            stream.close();
		            
		          /*  Profile p = ps.getProfile(request.getHeader("user"));
		            
		            if( p != null )
		            {
		            	p.setImage("resources/images/" + HashManager.generateHashCode( request.getHeader("user") + hashname[0] ) + ".jpg" );
		            	
		            	ps.updateProfile(p);
		            	
		            	json.put("status", "Uploaded");
		            	json.put("imagesrc", "resources/images/" + HashManager.generateHashCode( request.getHeader("user") + hashname[0] ) + ".jpg" );
		            }*/
	            
	        }
	    }
	    catch (Exception e)
	    {
	    	e.printStackTrace();
	    }
		
		System.out.println(json.toString());
        
        return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
    }
	
	
	 @RequestMapping(value = "/deleteUserImage", method = RequestMethod.POST)
	    public ResponseEntity<String> deleteUserImage(HttpServletResponse response,@RequestBody String user, UriComponentsBuilder ucBuilder, Principal p) {
	        
			System.out.println(user);
			
			
			String path = context.getRealPath("/");
	        
	        System.out.println(path);
	        
	        
	        
	        File directory = new File(path + "resources\\images\\" + p.getName()+".jpg" );
			
	        directory.delete();
			
			JSONObject json = new JSONObject();
	        	        
	        json.put("status", "PICTURE DELETED");
	       	        
	        System.out.println(json.toString());
	        
	        return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
	    }
	 
	 
	 @PostMapping("/postblog")
		public ResponseEntity<String> postBlog(@RequestBody JSONObject data, Principal p){
			System.out.println(data);
			
			
			User user = userdao.getUserByEmail(p.getName());
			
			/*DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");*/
			Date date = new Date();
			System.out.println(date);
			
			Blog blog = new Blog();
			
			blog.setTitle(data.get("BlogTitle").toString());
			blog.setDescription(data.get("BlogDesc").toString());
			blog.setBlogdate(date);
			
			blog.setUserId(user);
		
			blogdao.addBlog(blog);
			
			JSONObject json = new JSONObject();
	        
	        json.put("status", "BLOG POSTED");
	        System.out.println(json.toString());
	        
	        return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
			}
	 

	 @GetMapping("admin/allblogs")
		public ResponseEntity<List<Blog>> allBlogs(){
		
		List<Blog> list = blogdao.listAllBlogs();
		
		return new ResponseEntity<List<Blog>>(list, HttpStatus.OK);
		
		}
	 
	 @PostMapping("/publishblog")
		public ResponseEntity<String> publishBlog(@RequestBody String inputdata){
			System.out.println(inputdata);
		
			int blogid = Integer.parseInt(inputdata);
			
		
			System.out.println(blogid);
			
			Blog blog = blogdao.getBlogById(blogid);
			
			blog.setPosted(true);
			
			//update blog 
			blogdao.addBlog(blog);
			
			JSONObject json = new JSONObject();
			
			json.put("status", "BLOG PUBLISHED");
	        System.out.println(json.toString());
	        
	        return new ResponseEntity<String>(json.toString(), HttpStatus.CREATED);
		
			
			}
	 
		@GetMapping("/blogs")
		public ResponseEntity<List<Blog>> blogs(){
		
		List<Blog> list = blogdao.listBlogs();
		
		return new ResponseEntity<List<Blog>>(list, HttpStatus.OK);
		
			}

		
	 
	 
	
	
	
	
}
