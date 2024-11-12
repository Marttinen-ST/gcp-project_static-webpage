## gcp-project_static-webpage

### GCP Project with terraform and react to host static website in cloud object store + Packer script to build Jenkins CI server

This project has the intention to delivery an automation solution that uses GitHub repository and webhooks, a Jenkins CI server that will automaticaly deploy the terraform scripts and the React code into the storage bucket. Plus a packer image to create the Jenkins CI server.

### The code folder

Contains the React-app folders and files, this is where the website content is updated. The React-app will be automatically deployed by the Jenkins CI server after pushing changes to the branch and running Jenkinsfile script.

### The packer foder

To run the packer script, first locally install packer. Update the `gce-jenkins-image.pkr.hcl` file:
 * `line 4`: Add the GCP project ID
 * `line 15`: Add the path to the service account credentials json file

 Enter packer folder and run packer command to build the image:
 * `cd packer`
 * `packer build gce-jenkins-image.pks.hcl`

 ### The terraform folder

Folder content:

    - terraform
    | - modules
    | | - static-website-bucket
    | | | - static-website-bucket.tf
    | | | - variables.tf
    | | - static-website-lb
    | | | - output.tf
    | | | - static-website-lb.tf
    | | | - variables.tf
    | - main.tf
    | - variables.tf

The `main.tf` file have the provider, backend and call the modules `static-website-bucket` and `static-website-lb`. The terraform script will be automatically deployed by the Jenkins CI server after pushing changes to the branch and running Jenkinsfile script.

### The Jenkins file

Contains the deployment script used by Jenkins CI server.