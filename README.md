# Pre-Commits

This repo contains a bunch of pre-commits that I find useful. You may too!

## Trivy

This pre-commit has been designed to use a local copy of Trivy to run trivy scans agains your repo.
I did consider using Docker but decided against it for the following reasons:

1. It requires Docker to be available on a system which may not be the case in all scenarios.
2. It supports using a local copy of Trivy which the user can then ensure has a version match with what's expected in their pipelines.
3. Because I made this repo and I decided to do ti this way :smile:.

### Usage
**[Install trivy](https://github.com/aquasecurity/trivy/releases)** - that's step 1. If you don't have it, it ain't working!

Next create something that looks like this:

```yaml
---
repos:
  - repo: https://github.com/drewbernetes/trivy-pre-commit.git
    rev: v0.1.0
    hooks:
      - id: trivy
        args:
          - fs
          - # Any additional flags
          - . # the location/files to scan
```

As it's using the cli, you can just replace the `fs` bit for any other trivy supported commands (see `trivy --help` for more info on this).
And that's it. It's simple, it's straightforward, and now you can scan things until your projects are happy and secure.

### Why do I need this?

Because you forgot to run `trivy` against your code before pushing again, didn't you? :wink:. I know I do sometimes!

# Docker
This pre-commit has been designed to build a docker image locally.
It does this by tagging it with `local/IMAGE_NAME:0.0.0`.

It requires Docker to be available on a system.

## Usage
**[Install Docker](https://docs.docker.com/engine/install/)** - that's step 1. If you don't have it, it ain't working!

Next create something that looks like this:

```yaml
---
repos:
  - repo: https://github.com/drewbernetes/docker-pre-commit.git
    rev: v0.1.0
    hooks:
      - id: docker
        args:
          - --image-name
          - SOME_IMAGE
          - --dockerfile-path
          - docker/Dockerfile
          - --context
          - .
```

That's it. You can pass in a bunch of args to supply if you like but the default command is: `docker build local/IMAGE_NAME:0.0.0 -f PATH CONTEXT`

## Why do I need this?

Because you need to know your image builds before attempting to do it in your CI.
