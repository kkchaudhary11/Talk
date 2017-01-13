package com.talk.imgupload;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.json.simple.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.sun.jersey.core.header.FormDataContentDisposition;
import com.sun.jersey.multipart.FormDataParam;

@Path("/file")
public class FileUploadService {
	
	
	@POST
	@Path("/upload")
	@Consumes(MediaType.MULTIPART_FORM_DATA)
	public  ResponseEntity<String> uploadFile(@FormDataParam("file") InputStream uploadedInputStream,@FormDataParam("file") FormDataContentDisposition fileDetails)
	{
		String uploadLocation="D://collaborationPortal//uploads/"+fileDetails.getFileName();
		
		try
		{
			BufferedOutputStream out=new BufferedOutputStream(new FileOutputStream(new File(uploadLocation)));
			  int read = 0;
              byte[] bytes = new byte[1048576];//supports file size of 1 MB
              
              while ((read = uploadedInputStream.read(bytes)) != -1) {
                  out.write(bytes, 0, read);
            }
              
              out.close();
			
		}catch(IOException ioe)
		{
			ioe.printStackTrace();
		}
		
		System.out.println("file uploaded to "+uploadLocation);
		
		JSONObject json = new JSONObject();
        
        json.put("imgstatus", "UPLOADED");
        System.out.println(json.toString());
        
        return new ResponseEntity<String>(json.toString(), HttpStatus.OK);
		
	
	}
	

}
