# **FastAPI Base**
***

## **Project Structure**
- Running on Python 3.10
```
.
├── .github/
|   └── workflows/
|       └── linters-workflow.yml
├── app/
|   ├── api/
|   |   ├── endpoints/
|   |   |   ├── health_check/
|   |   |   └── router.py
|   |   └── services/
|   ├── core/
|   |   └── settings.py
|   └── main.py
├── dev/
|   ├── tools.sh
|   └── linters.sh
├── .dockerignore
├── .env.template
├── .gitignore
├── .pre-commit-config.yaml
├── CHANGELOG.md
├── Dockerfile
├── poetry.lock
├── poetry.toml
├── pyproject.toml
├── README.md
├── setup.cfg
└── start.sh
```

## **Installation**
### **Via Poetry**
- Be sure you are running on Poetry version 1.2 or greater. Install via `poetry install`
### **Via docker**
1. Add permission to build script `chmod +x ./dev/tools.sh`
2. Execute `./dev/tools.sh build`
### **Pre Commit**
1. Install pre-commit `pre-commit install`
2. Add permission to linter script `chmod +x ./dev/linters.sh`
3. Before you commit, be sure you are in the right environment. If you are using Docker, add the env variable `ENV=docker`.

## **Linters**
- Base linters used:
  - Black for Python code format.
  - Isort for imports sorting.
  - Flake8 for PEP code format.
  - PyDocStyle for Doc format.

## **Deploy**
- Dockerfile used to deploy 100% containerized. You can deploy by using ECR, Artifact Registry in GCP or a simple Heroku app by configuring a GitHub Action Workflow.
- Configure a Docker Compose file if you need to mock one or more services by a service registry, a network and/or a volume.
