terraform {
  // Copyright 2017 The TensorFlow Authors. All Rights Reserved.
  cloud {
    organization = "Ayodev"
    workspaces {
      name = "new_project"
    }
  }

}

provider "aws" {
  region = "us-west-1"
}
