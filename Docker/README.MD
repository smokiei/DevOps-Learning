## Create a docker image with Python Flask app

The goal of this task is to create a Docker image which will run my educational Flask app.
  
My educational flask-app is api, that provides some information about films  
  
let's write Dockerfile  
Content of **Dockerfile** file:  
![1](./1.PNG)  
  
Building docker image  
![2](./2.PNG)  
  
Check out what we have  
![3](./3.PNG)  
  
Launch container from the film-api-image image with port forwarding from 5001 to port 9000  
![4](./4.PNG)  
  
Open ```localhost:9000``` in the web browser and check out our web application - its working!  
![5](./5.PNG)  
  
List all the images and containers that we have by typing ```docker image ls``` and ```docker ps -a``` commands  
![6](./6.PNG)  
  
Log in to Docker Hub with ```docker login```  
![7](./7.PNG)  
  
Tag and push our image to Docker Hub registry  
![8](./8.PNG)  
  
Check on Docker Hub site where our image has been downloaded  
![9](./9.PNG)  













