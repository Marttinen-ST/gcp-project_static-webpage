
variable "project_id" {
  type    = string
  default = "long-sum-441213-v5"
}

variable "source_image_family" {
  type    = string
  default = "ubuntu-2204-lts"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "googlecompute" "jenkins" {
  account_file        = "/home/monitor/RGA/ServiceAccount/long-sum-441213-v5-2df2b21e07ed.json"
  image_name          = "jenkins-ubuntu-image-${local.timestamp}"
  machine_type        = "e2-medium"
  project_id          = "${var.project_id}"
  source_image_family = "${var.source_image_family}"
  ssh_username        = "packer"
  zone                = "us-central1-a"
}

build {
  sources = ["source.googlecompute.jenkins"]

  provisioner "shell" {
    inline = [
      "sudo DEBIAN_FRONTEND=noninteractive apt-get -y update", 
      "echo \"Waiting for cloud init.\"",
      "echo \"Waiting for OS to settle\"",
      "sleep 60",
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo \"Waiting...\"; sleep 5; done",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade",
      "sleep 60",
      "echo \"*****************##############*****************\"",
      "echo \"*****************INSTALLING JDK*****************\"",
      "echo \"*****************##############*****************\"",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-21-jdk", 
      "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get -y update", 
      "echo \"*****************#################*****************\"",
      "echo \"*****************INSTALLING APACHE*****************\"",
      "echo \"*****************#################*****************\"",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y apache2",
      "sudo systemctl start apache2",
      "sleep 10",
      "echo \"*****************####################*****************\"",
      "echo \"*****************INSTALLING TERRAFORM*****************\"",
      "echo \"*****************####################*****************\"",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y gnupg software-properties-common",
      "wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null",
      "gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint",
      "echo deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main | sudo tee /etc/apt/sources.list.d/hashicorp.list",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get update",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y terraform",
      "echo \"**************##########################************\"",
      "echo \"**************INSTALLING NODEJS AND YARN************\"",
      "echo \"**************##########################************\"",
      "curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh",
      "sudo bash nodesource_setup.sh",
      "sudo apt-get install -y nodejs",
      "sudo npm install -g yarn",
      "echo \"*****************##################*****************\"",
      "echo \"*****************INSTALLING JENKINS*****************\"",
      "echo \"*****************##################*****************\"",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y jenkins", 
      "sudo systemctl enable jenkins"]
  }

}
