# Food Zone on AWS

A hands-on AWS project where I take one web application, **Food Zone** (a React + Vite food ordering front end), and grow its hosting step by step: from a static website, to a container on a server, to a private network, and next to a highly available, automated platform.

Each phase builds on the previous one. Every phase folder has a README with what I built, why, the commands I used, the problems I hit and how I fixed them.

**Author:** [Lakshman Kadali](https://linkedin.com/in/lakshman.kadali) · **Region:** eu-north-1 (Stockholm) · **Status:** Phases 0 to 3 complete, Phase 4 next

---

## Phases

| Phase | What I built | Key AWS services | Status |
|---|---|---|---|
| [0. Account setup](./phase-0/README.md) | Secured a new AWS account: root MFA, IAM users and groups with least privilege, budget alerts, AWS CLI, verified a denied action in CloudTrail | IAM, AWS Budgets, CloudTrail, AWS CLI | ✅ Done |
| [1. Static website](./phase-1/README.md) | Hosted the React build on a private S3 bucket behind CloudFront, with SPA routing, cache invalidation, versioning and lifecycle rules | S3, CloudFront (OAC) | ✅ Done |
| [2. Docker on EC2](./phase-2/README.md) | Containerized the app (multi-stage Dockerfile, Nginx, 54 MB image), deployed it to EC2 with user data, baked an AMI, added Session Manager, EBS resize and a CloudWatch alarm with email alerts | EC2, AMI, EBS, Systems Manager, CloudWatch, SNS | ✅ Done |
| [3. Custom VPC](./phase-3/README.md) | Designed my own VPC across two Availability Zones with public and private subnets; ran the app in a private subnet with no public IP, behind a NAT gateway, reached through Session Manager port forwarding; tested security groups vs network ACLs | VPC, subnets, route tables, internet gateway, NAT gateway, NACLs | ✅ Done |
| 4. High availability | Application Load Balancer and Auto Scaling across both Availability Zones | ALB, Auto Scaling | ⏭️ Next |

Later phases will add CI/CD, infrastructure as code with Terraform, and monitoring.

---

## How the architecture has grown

```text
Phase 1:  User ──> CloudFront ──> private S3 bucket (static files)

Phase 2:  User ──> EC2 (public IP) ──> Docker container (Nginx + React build)

Phase 3:  VPC 10.0.0.0/16, two Availability Zones
          ├── Public subnets   ── internet gateway, NAT gateway
          └── Private subnets  ── EC2 with the app (no public IP)
                                  outbound only, through NAT
          Admin access: Session Manager (no SSH, no open ports)

Phase 4:  User ──> Load balancer (public subnets) ──> Auto Scaling group (private subnets)
```

---

## Skills shown in this project

- **Security:** least privilege IAM, MFA, no long-term keys on servers (instance roles), no SSH (Session Manager), private subnets
- **Networking:** CIDR planning, public vs private subnets, route tables, NAT, stateful vs stateless firewalls
- **Containers:** multi-stage Docker builds, health checks, image tagging, Docker Hub
- **Operations:** monitoring and alerts, EBS snapshots and AMIs, online disk resize
- **Cost control:** budgets, cleaning up hourly resources (NAT gateway, Elastic IP) after every phase
- **Troubleshooting:** each phase README has a "problems I hit" table with the cause, fix and lesson

## Tools

AWS CLI · AWS Console · PowerShell · Docker · Git · Linux (Amazon Linux 2023)

---

## About the app

Food Zone is a sample React front end that I did not write. I use it as the workload so I can focus on the cloud side: the Dockerfile, Nginx configuration, infrastructure and documentation are my own work. Application repo: [Lakshmankadali/FoodZone](https://github.com/Lakshmankadali/FoodZone).

I am also preparing for the **AWS Certified Cloud Practitioner** exam alongside this project.
