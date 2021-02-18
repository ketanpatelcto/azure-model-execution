# azure-model-execution

## Description

This project is envisioned to hold my thoughts & experiments as I develop a proof-of-concept for financial model execution in Microsoft Azure.

## Who Am I? 

See my [profile on LinkedIn](https://www.linkedin.com/in/ketan-patel-42369b27/)

## Getting Started

* Install Git
* Install VS Code
* Install VS Code Extensions: hashicorp.terraform, ms-azuretools.vscode-azureterraform
* Install Choco from a Powershell prompt (run as administrator):
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```
* Install Terraform from a Powershell prompt (run as administrator):
```powershell
choco install terraform
```
* Install Azure CLI from a Powershell prompt (run as administrator):

```powershell
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
```

* Open a VS Code terminal and fix your PATH by running `setup.bat`

* Login to the Azure CLI by running `az login`

* Edit terraform settings in `variables.tf`
    * prefix.default should be univerally unique (i.e. across all Azure users)

* Run terraform commands: `terraform init`, `terraform plan`

## To Do

* Create a new Azure account
* Create a storage account
    * ADLS
    * Where do we put our dummy input CSV files?
* Pushing files from public internet to datafactory
    * FTP?
    * Events when files arrive?
* Create a data factory manually
    * Create a data factory using Terraform


|Component|Notes|
|---|---|
|Data Factory|- Requires Git<br>- Need to figure out how to use a custom key|
|Key Vault||
|DevOps|- Do we need this if we're using Github?|
|Users||