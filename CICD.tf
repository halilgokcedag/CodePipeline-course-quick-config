resource "aws_codecommit_repository" "angular_repo" {
  repository_name = "Angular-project-repo"
  description     = "This is the Angular Project Repository"
}