## Create a docker image with Python Flask app

The goal of this exercise is to create a Docker image which will run my educational Flask app.
  
My educational flask-app is api, that provide some information about films  
  
lets write Dockerfile  
Content of **Dockerfile** file:  
![1](./1.png)  
  
Building docker image  
![2](./2.png)  
  
Check out what we have
![3](./3.png)

Launch container from the film-api-image image with port forwarding from 5001 to port 9000  
![4](./4.png)  

Open ```localhost:9000``` in the web browser and check out our web application - its working!
![5](./5.png)

List all the images and containers that we have by typing ```docker image ls``` and ```docker ps -a``` commands.
![6](./6.png)  

Login to Docker Hub with ```docker login```. After that you must enter your username and password for your account. I already have a Docker Hub account – **jundevops**.

And push our image to Docker Hub registry.

 ![17](screenshots/17.png)  
 
Check on Docker Hub site that our image has been downloaded.

![18](screenshots/18.png)  














