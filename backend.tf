terraform {
  cloud {
    organization = "sparky-studios"

    workspaces {
      name = "trak-library-vcs-development-eu-west"
    }
  }
}