# azure-model-execution

## Description

This project is a proof-of-concept for financial model execution in Microsoft Azure: data ingestion, transformation, staging, analytics, and reporting.

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

* Install Az module from a Powershell prompt (run as administrator):

```powershell
if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Module -Name AzureRM -ListAvailable)) {
    Write-Warning -Message ('Az module not installed. Having both the AzureRM and ' +
      'Az modules installed at the same time is not supported.')
} else {
    Install-Module -Name Az -AllowClobber -Scope CurrentUser
}
```

* Install [Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/) or use the web version in the Azure console instead

* Open a VS Code terminal and fix your PATH by running `setup.bat`

* Login to the Azure CLI by running `az login`

* Login to Azure via Powershell by running `Connect-AzAccount`

* Edit terraform settings in `variables.tf`
    * prefix.default should be univerally unique (i.e. across all Azure users)

* Run terraform commands: `terraform init`, `terraform plan`

## To Do

Moved to [Github Projects](https://github.com/ketanpatelcto/azure-model-execution/projects/1)
