action "Docker Login" {
  uses = "actions/docker/login@master"
  needs = [
    "On master branch",
  ]
  secrets = [
    "DOCKER_USERNAME",
    "DOCKER_PASSWORD",
  ]
}

action "GitHub Package Registry Login" {
  uses = "parkr/dockerfiles/.github/actions/github-pkg-login@master"
  needs = [
    "On master branch",
  ]
  secrets = [
    "GPR_USERNAME",
    "GPR_PASSWORD",
  ]
}

action "On master branch" {
  uses = "actions/bin/filter@master"
  args = "branch master"
}

workflow "Build & test on push" {
  on = "push"
  resolves = [
    "Test octodns",
  ]
}

workflow "Publish to Docker Hub on push to master" {
  on = "push"
  resolves = [
    "Publish octodns",
  ]
}

workflow "Publish to GitHub Package Registry on push to master" {
  on = "push"
  resolves = [
    "Publish octodns to GitHub Package Registry",
  ]
}


action "Test octodns" {
  uses = "parkr/actions/docker-make@master"
  args = "test-octodns"
}

action "Publish octodns" {
  uses = "parkr/actions/docker-make@master"
  needs = [
    "Docker Login",
  ]
  args = [
    "publish-octodns",
  ]
}

action "Publish octodns to GitHub Package Registry" {
  uses = "parkr/actions/docker-make@master"
  needs = [
    "GitHub Package Registry Login",
  ]
  args = [
    "publish-octodns",
    "-e",
    "NAMESPACE=docker.pkg.github.com/cjs/docker-octodns",
  ]
}

workflow "New workflow" {
  on = "push"
}
