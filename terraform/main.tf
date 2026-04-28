provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "quantum_sim" {
  name = "quantum-sim"
}

resource "aws_ecs_cluster" "main" {
  name = "quantum-cluster"
}

resource "aws_instance" "jenkins" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  tags = { Name = "Jenkins-Server" }
}