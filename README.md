<div align="center">

# mean-stack-dockerized

**Production-grade contact manager built with the full MEAN stack and Docker**

MongoDB | Express.js | Angular 21 | Node.js | Docker | TypeScript

[Get Started](#getting-started) | [Docs](#documentation)

[![GitHub](https://img.shields.io/badge/GitHub-2015pushkar-181717?style=flat&logo=github)](https://github.com/2015pushkar)

</div>

---

## About

A containerized full-stack contact management app built to learn and demonstrate production-level patterns: JWT auth, REST APIs, Nginx reverse proxy, Docker Compose, CI/CD, and TypeScript across the entire stack. The domain is simple by design so the focus stays on the architecture.

---

## Architecture

```mermaid
flowchart TB
    subgraph Internet["INTERNET"]
        client(("Browser"))
    end

    subgraph Docker["DOCKER ENVIRONMENT"]
        subgraph Gateway["GATEWAY"]
            nginx{{"NGINX :80"}}
        end
        subgraph App["APPLICATION"]
            angular["Angular 21 :4000"]
            express["Express.js :3000"]
        end
        subgraph Data["DATA"]
            mongodb[("MongoDB :27017")]
        end
    end

    client ==>|"HTTP"| nginx
    nginx -->|"/* static"| angular
    nginx -->|"/api/*"| express
    express <-->|"CRUD"| mongodb

    classDef gateway fill:#c8e6c9,stroke:#2e7d32,stroke-width:3px,color:#1b5e20
    classDef frontend fill:#ffcdd2,stroke:#c62828,stroke-width:2px,color:#b71c1c
    classDef backend fill:#fff3e0,stroke:#ef6c00,stroke-width:2px,color:#e65100
    classDef database fill:#e8f5e9,stroke:#388e3c,stroke-width:2px,color:#2e7d32
    classDef user fill:#bbdefb,stroke:#1976d2,stroke-width:2px,color:#0d47a1

    class client user
    class nginx gateway
    class angular frontend
    class express backend
    class mongodb database
```

---

## Auth Flow

```mermaid
sequenceDiagram
    participant U as Browser
    participant A as Angular
    participant E as Express API
    participant D as MongoDB

    U->>A: Login (email + password)
    A->>E: POST /api/users/authenticate
    E->>D: Find user, verify bcrypt hash
    D-->>E: User record
    E-->>A: JWT token
    A->>A: Store token, activate route guards
    A->>E: GET /api/contacts (Authorization: Bearer <token>)
    E->>E: Verify JWT middleware
    E->>D: Query contacts
    D-->>E: Contact list
    E-->>A: JSON response
    A-->>U: Render contacts page
```

---

## CI/CD Pipeline

```mermaid
flowchart LR
    subgraph GitHub["GITHUB"]
        push(["git push"])
    end

    subgraph Actions["GITHUB ACTIONS"]
        lint["Lint"]
        build["Docker Build"]
        push_img["Push Image"]
    end

    subgraph DockerHub["DOCKER HUB"]
        img[("Images")]
    end

    subgraph Prod["PRODUCTION"]
        compose["docker-compose up"]
    end

    push --> lint --> build --> push_img --> img --> compose

    classDef action fill:#fff3e0,stroke:#ef6c00,stroke-width:2px
    classDef hub fill:#e8f5e9,stroke:#388e3c,stroke-width:2px
    class lint,build,push_img action
    class img hub
```

---

## Tech Stack

```mermaid
graph LR
    subgraph Frontend
        A21["Angular 21"]
        TS1["TypeScript"]
        BS5["Bootstrap 5"]
        RX["RxJS"]
    end
    subgraph Backend
        NJ["Node.js"]
        EX["Express.js"]
        TS2["TypeScript"]
        JWT["JWT Auth"]
    end
    subgraph Database
        MG["MongoDB 7.0"]
        MO["Mongoose ODM"]
    end
    subgraph DevOps
        DK["Docker"]
        DC["Docker Compose"]
        NG["Nginx"]
        GA["GitHub Actions"]
    end
```

---

## Getting Started

**Prerequisites:** Docker and Docker Compose, Git

```bash
git clone https://github.com/2015pushkar/mean-stack-dockerized
cd mean-stack-dockerized
cp .env.example .env
docker-compose -f docker-compose.nginx.yml up
```

Open [http://localhost](http://localhost) in your browser.

**Default login**

```
Email:    pushkarwani63@gmail.com
Password: P@ssword#321
```

---

## Deployment Modes

| Mode | Command | Access |
|------|---------|--------|
| Development (3 containers) | `docker-compose up` | Frontend :4000, API :3000 |
| Production (4 containers + Nginx) | `docker-compose -f docker-compose.nginx.yml up` | http://localhost |

---

## Features

| Area | Capabilities |
|------|-------------|
| Auth | Register, login, JWT-protected routes, change password |
| Contacts | Create, read, update, delete, search, sort, paginate |
| UI | Responsive Bootstrap 5, form validation, Angular route guards |
| API | RESTful Express.js with middleware and Mongoose ODM |

---

## Documentation

| Document | Description |
|----------|-------------|
| [Frontend](frontend/README.md) | Angular architecture and components |
| [Backend API](api/README.md) | Express.js endpoints and middleware |
| [Database](docs/mongo-readme.md) | MongoDB schemas and seed data |
| [Load Balancer](loadbalancer/README.md) | Nginx routing config |
| [Local Dev](docs/local-devlopment.md) | Running without Docker |
| [Docker Guide](docs/docker-guide.md) | Container setup |

---

## Roadmap 2026

| Quarter | Focus |
|:-------:|-------|
| Q1 | Unit tests, E2E with Cypress, CI coverage reporting |
| Q2 | Angular Material, dark/light theme |
| Q3 | RBAC (Admin/Manager/User), OAuth 2.0 |
| Q4 | Redis caching, rate limiting, Kubernetes |

---

## License

MIT. See [LICENSE](LICENSE).

<div align="center">

Built by [Pushkar Wani](https://github.com/2015pushkar)

</div>
