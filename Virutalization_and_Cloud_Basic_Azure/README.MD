#### Virutalization and Cloud Basic (Azure)

################ Part 1 Configure application
1.	Create a service connection in a Azure DevOps project to your subscription - https://learn.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml
2.	Find a .net pet project for the experiments
3.	Build your app locally .net project via dotnet tool. dotnet restore/build/run
![1](./1.png)

4.	Create an Azure DevOps repo - https://learn.microsoft.com/en-us/azure/devops/repos/git/create-new-repo?view=azure-devops  You can use import repository to import from existing source control version like github
![2](./2.png)
![3](./3.png)

5.	Create a branching policy for you application. Added yourself as a reviewer - https://learn.microsoft.com/en-us/azure/devops/repos/git/branch-policies?view=azure-devops&tabs=browser As branching strategy use a github flow (It will be applied by default when you strict commit to your main branch)
![4](./4.png)

################ Part 2 Configure a pipeline to deploy infrastructure 
Terraform storage account 
1.	Create a separate resource group and deploy azure storage accoun
![5](./5.png)

2.	Create a container with the name “tfstate” 
![6](./6.png)

Terraform preparation
1.	Create another repo to store devops code
    lets do it on local folder
2.	Create a folder terraform

3.	Add app service implementation - https://learn.microsoft.com/en-us/azure/app-service/provision-resource-terraform 
run terraform init
![7](./7.png)

4.	Integrate application insights with app service
login in azure
![8](./8.png)

run terraform plan
![9](./9.png)

terraform apply
![10](./10.png)

check deployment
![11](./11.png)
![12](./12.png)

terraform destroy
![13](./13.png)

5.	Updated backend “azurerm” according to the guide - https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli
update main.tf like that with created subscription_id resource_group_name and storage_account_name
  backend "azurerm" {
		subscription_id      = "8b884c5f-7b62-4e9f-841c-3fe8232e0978"
        resource_group_name  = "devops"
        storage_account_name = "forterraform"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
   }
terraform init
![14](./14.png)

terraform plan
![15](./15.png)

6.	Run az login or Connect-AzAccount to connect the azure subscription from your local
already :)

7.	Run terraform apply to deploy infrastructure 
terraform apply
![16](./16.png)

check if terraform.tfstate was created
![17](./17.png)
and webapp was created
![18](./18.png)

terraform destroy
![19](./19.png)

Create a terraform pipeline
1.	Create a yaml pipeline with the following steps: terraform install, terraform init, terraform plan/apply. Plan is an optional one 
![22](./22.png)
2.	Inside yaml pipeline add trigger to main branch. The scenario – when main is updated, pipeline should run automatically - https://learn.microsoft.com/en-us/azure/devops/pipelines/yaml-schema/trigger?view=azure-pipelines
![21](./21.png)
3.	Added 3 steps – terraform install, terraform init, terraform plan/apply. Plan is an optional one. You may add it as 4th step
![22](./22.png)

Part 3 – Create a deploy pipeline to app service
1.	Add yml pipeline to the application folder
2.	Your pipeline structure should contain 2 stages. 1st – build, create zip archieve, and publish an artifact. 2nd – download an artifact and deploy it to azure app service 
3.	To deploy .zip to app service use azure app service deployment task
![20](./20.png)
