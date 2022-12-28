# Terraform 
create (./main.tf) like sample with actual Ubuntu ami
run Terraform init
  ![1](./1.PNG)
  
run Terraform plan
  ![2](./2.PNG)  

run Terraform apply
  ![3](./3.PNG)  

Check AWS - instance created
  ![4](./4.PNG) 

dont forger terraform destroy 
  ![5](./5.PNG)

Check AWS - instance destroyed
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



  
