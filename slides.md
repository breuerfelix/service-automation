---
author: Felix Breuer
paging: Slide %d / %d
---

# Service Automation

---

# About Me

* 2020 TH Köln Bachelor Technische Informatik
* Cloud Systems Engineer @ inovex GmbH
* Kubernetes as a Service @ STACKIT
* Kubernetes Platform Engineering @ Big German Streaming Platform

---

# About this Talk

* handle many Services in large Teams
=> Automation & Rules
* everything on public Services / for free
* stuff to check out @ home

---

# Scenario

Our Company:
* 10 Teams
* 6 Engineers per Team
* 1 Product Owner per Team

Our Service:
* simple Go Web Server
* greets people on request

---

# Development

Problem:


=> works on my machine

---

# Development

* `nix-shell -p nodejs`
* impure shell => not like a container
* real version pinning is hard
  * is done with flakes

```nix
{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    buildInputs = with pkgs; [
      go_1_19
      # go
    ];

    shellHook = ''
      export FOO="some important build arg"
    '';
}
```

---

# Development

Alternatives:
* Dev Containers
  * supported by GitHub
  * needs Docker
* asdf-vm
  * runtime version manager
  * only installs tools

---

# Repository

Problem:


=> everyone can push code on `main`

---

# Repository

* `main` Branch protection
  * Repo -> Settings -> Branches
* Require a pull request before merging
* Require status checks to pass before merging
* Require conversation resolution before merging

---

# Pull Requests

Problem:


=> have you already run your tests?

---

# Pull Requests

* use Pipelines
* `build | lint | test`
* deploy to `dev` stage
* run `e2e` tests

=> `service-automation.yml`

No need to check out the PR locally!

---

# Tagging

Problem:


=> major, minor or patch?

---

# Semantic Versioning

`MAJOR.MINOR.PATCH`

`5.1.20`

`MAJOR`: incompatible API changes

`MINOR`: add functionality in a backward compatible manner

`PATCH`: backward compatible bug fixes

=> semver.org

---

# Conventional Commits

`<type>[optional scope]: <description>`

type: `fix | feat | feat!`

```git
feat[router]: adds hello world route
```

```git
feat!: changes hello world path
```

* `feat!` -> MAJOR
* `feat` -> MINOR
* `fix` -> PATCH

=> conventionalcommits.org

---

# Tagging

* `commitizen` to assist locally
* `commitlint` on PR
* `semantic-release` to create a Tag

---

# Deploy

Problem:


=> is this already live?

=> you forgot to update the docs...

---

# Deploy

* containerize app
  * runs in different environments
* multiple stages
  * `dev | preprod | prod`
* deploy:
  * via pipelines
  * PR manually to `dev`
  * `main` to `preprod`
  * `x.x.x` manually to `prod`

---

# Deploy

* build a container image
  * build on every PR to rollout on `dev`
* push to a container registry
* roll out to a stage
* only allow rebase merging
  * only tagging the image on `main` is needed
* auto tag based on commit messages

---

# Updating

Problem:


=> outdated libraries

---

# Renovate Bot

* scans your Repositories daily
* opens a PR if a version updates
* is configureable to lock packages

---

# Code quality

Problem:


=> is your feature tested?

---

# Sonarqube

* runs on PR
* calculates code coverage
* lets you define quality gates
