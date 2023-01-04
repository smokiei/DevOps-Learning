# Jenkins 

## Create Jenkins pipeline wich will deploy my telegram bot in docker to AWS  

Install and unlock Jenkins on my server.  
  ![1](./1.PNG)  
  
install plugin Pyenv Pipeline to create venv  
  ![2](./2.PNG)  

Create pipeline to run my telegram bot (written on python, private repository on github)  
  Its not properly pipeline, because after run it will be working, until break, so it must be refactor to run in docker  
  ![3](./3.PNG)  


Create pipeline item in Jenkins 
  connect it to github repository, get Jenkinsfile from repository too. Connect with token  
  ![4](./4.PNG)  
  ![5](./5.PNG)

Configure webhook to allow Jenkins to be notified of push happen
  ![6](./6.PNG)

Do some changes, commit them and push to github. Check what happens. Great! Its work!
  ![7](./7.PNG)

Ok lets run application in docker. Create Dokerfile  
  ![8](./8.PNG)
  and do some refactor with Jenkinsfile  
  ![9](./9.PNG)
Its stell not properly pipeline, because after run docker will be working, until break,  
so after break it is must be script with wiping out (stop container, delete container and image)  

Ok but pipeline run in Jenkins. This is bad practice. Lets run it in some node  
lets create Permanent Agent on AWS EC2  
create EC2 Ubuntu instance with t2.micro on free tier  
  ![10](./10.PNG)

Setup environment on server for agent work properly  
  install Docker and Java 11  
  ![11](./11.PNG) 

Then, save ssh keys from AWS to access EC2 insta from Jenkins  
And setup new agent on Jenkins  
  ![12](./12.PNG)  
  ![13](./13.PNG)  
  ![14](./14.PNG)  

Set Number of executors to 0 on build-in node for preventing running jobs on it  
  ![15](./15.PNG)  

Start manual build - all OK! application work well  
  ![16](./16.PNG)  
  ![17](./17.PNG)  

This is not perfect pipeline, its need manual break - it will be improved in future  
and try to automate Jenkins agent deployment  

  install Docker Pipeline plugin  
  ![8](./8.PNG)  
  and refactor Jenkinsfile  



  
