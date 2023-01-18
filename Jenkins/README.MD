# Jenkins 

## Create the Jenkins pipeline which will deploy my telegram bot in docker to AWS  

Install and unlock Jenkins on my server.  
  ![1](./1.PNG)  
  
install plugin Pyenv Pipeline to create venv  
  ![2](./2.PNG)  
  
Create pipeline to run my telegram bot (written on python, private repository on github)  
  It’s not a proper pipeline, because after running it will be working, until break, so it must be refactored to run in a docker 
  ![3](./3.PNG)  
  
Create pipeline item in Jenkins  
  connect it to the github repository, get Jenkinsfile from the repository as well. Connect with token  
  ![4](./4.PNG)  
  ![5](./5.PNG)  
  
Configure webhook to allow Jenkins to be notified when pushes happen  
  ![6](./6.PNG)   
  
Do some changes, commit them and push to github. Check what happens. Great! It works!
  ![7](./7.PNG)  
  
Ok let’s run an application in docker. Create Dokerfile  
  ![8](./8.PNG)  
  and do some refactoring with Jenkinsfile  
  ![9](./9.PNG)  
It's still not properly a pipeline, because after run docker will be working, until break,
so after break it is must be part with wiping out (stop container, delete container and image)  
  
Ok but the pipeline runs in Jenkins. This is bad practice. Let’s run it in some node  
let’s create Permanent Agent on AWS EC2  
create EC2 Ubuntu instance with t2.micro on free tier  
  ![10](./10.PNG)
  
Setup environment on server for an agent to work properly  
  install Docker and Java 11  
  ![11](./11.PNG) 
  
Then, save ssh keys from AWS to get an access EC2 instance from Jenkins  
And setup a new agent on Jenkins  
  ![12](./12.PNG)  
  ![13](./13.PNG)  
  ![14](./14.PNG)  
  
Set Number of executors to 0 on build-in node for preventing running jobs on it  
  ![15](./15.PNG)  
  
Start manual build  
Everything is OK, the application works well
  ![16](./16.PNG)  
  ![17](./17.PNG)  
  ![18](./18.PNG)  
This is not a perfect pipeline, it needs a manual wipe (stop container and remove iamge) - it will be improved in future
and try to automate Jenkins agent deployment




  
