# Agentic Alert Triage with Wazuh and n8n

## 🎯 Project Overview

Building an automated cybersecurity alert triage system using:
- **Wazuh** - Open-source SIEM for security monitoring
- **n8n** - Workflow automation platform
- **Claude AI** - Intelligent alert analysis and prioritization

The goal is to reduce alert fatigue and Mean Time to Triage (MTTT) by automatically analyzing, categorizing, and prioritizing security alerts using AI agents.

---

## 🏗️ Architecture

```
┌─────────────────┐
│  Security       │
│  Events/Logs    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│     Wazuh       │
│  (SIEM/Manager) │
│  Detects Alerts │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│      n8n        │
│  (Orchestration)│
│  - Poll alerts  │
│  - Parse data   │
│  - Enrich       │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Claude API    │
│  (AI Analysis)  │
│  - Categorize   │
│  - Prioritize   │
│  - Recommend    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│    Actions      │
│  - Tickets      │
│  - Slack/Email  │
│  - Automation   │
└─────────────────┘
```

---

## 🛠️ Technology Stack

| Component | Technology | Purpose |
|-----------|-----------|---------|
| **SIEM** | Wazuh 4.7 | Security event monitoring and alerting |
| **Orchestration** | n8n | Workflow automation and integration |
| **AI Engine** | Claude (Anthropic) | Intelligent alert analysis |
| **Database** | PostgreSQL | n8n workflow persistence |
| **Infrastructure** | AWS / Local VMs | Hosting environment |

---

## 📋 Project Phases

### ✅ Phase 0: Infrastructure Setup
- [x] Set up development environment
- [x] Install Ubuntu Server
- [x] Configure networking
- [ ] Migrate to AWS (in progress)

### 🔄 Phase 1: Wazuh Deployment
- [x] Install Wazuh All-in-One
- [x] Configure Wazuh Manager
- [x] Verify Wazuh Dashboard access
- [x] Generate test alerts
- [ ] Deploy Wazuh agents

### 🔄 Phase 2: n8n Setup
- [x] Deploy n8n with Docker
- [x] Configure PostgreSQL backend
- [x] Access n8n web interface
- [ ] Configure authentication to Wazuh

### ⏳ Phase 3: Build Triage Workflow
- [ ] Create alert polling workflow
- [ ] Parse and normalize alert data
- [ ] Integrate Claude API
- [ ] Implement triage logic
- [ ] Add output actions

### ⏳ Phase 4: AI Integration
- [ ] Design prompt engineering for triage
- [ ] Implement severity classification
- [ ] Add context enrichment
- [ ] Create response recommendations

### ⏳ Phase 5: Testing & Refinement
- [ ] Generate diverse test alerts
- [ ] Validate AI accuracy
- [ ] Measure performance metrics
- [ ] Document lessons learned

---

## 🚀 Current Status

**Status**: Phase 1-2 Complete, Moving to AWS Infrastructure

**Completed:**
- Wazuh 4.7 successfully installed on Ubuntu VM
- Wazuh dashboard accessible and generating alerts
- n8n deployed with Docker Compose and PostgreSQL
- Network connectivity established between components

**In Progress:**
- Resolving authentication between n8n and Wazuh
- Planning AWS deployment for better resource management

**Next Steps:**
1. Deploy infrastructure on AWS
2. Complete n8n → Wazuh integration
3. Build first alert triage workflow
4. Integrate Claude API for intelligent analysis

---

## 📁 Repository Structure

```
wazuh-n8n-alert-triage/
├── README.md                    # This file
├── docs/
│   ├── 01-infrastructure.md     # Setup documentation
│   ├── 02-wazuh-install.md      # Wazuh installation guide
│   ├── 03-n8n-setup.md          # n8n configuration
│   ├── 04-workflow-design.md    # Workflow architecture
│   └── 05-troubleshooting.md    # Common issues & solutions
├── workflows/
│   └── alert-triage-workflow.json  # n8n workflow export
├── config/
│   ├── docker-compose.yml       # n8n Docker configuration
│   └── wazuh-config.yml         # Wazuh configuration snippets
├── scripts/
│   └── setup-scripts/           # Automation scripts
└── screenshots/
    └── (architecture & progress screenshots)
```

---

## 🎓 Learning Objectives

- Deploy and configure enterprise SIEM (Wazuh)
- Build workflow automation with n8n
- Integrate AI/LLM APIs for security operations
- Practice Infrastructure as Code principles
- Document technical projects for portfolio

---

## 🔗 Resources

- [Wazuh Documentation](https://documentation.wazuh.com/)
- [n8n Documentation](https://docs.n8n.io/)
- [Anthropic Claude API](https://docs.anthropic.com/)

---

## 📝 Blog Posts & Updates

*Coming soon - follow along as I document this journey!*

- [ ] LinkedIn: Project Announcement
- [ ] LinkedIn: Architecture & Design Decisions
- [ ] LinkedIn: Progress Update - Challenges & Solutions
- [ ] LinkedIn: Final Results & Lessons Learned
- [ ] Medium/Dev.to: Detailed Technical Write-up

---

## 👤 Author

**Jonathan Herring**
- LinkedIn: [[Jonathan Herring]](https://www.linkedin.com/in/jonathan-herring-code/)

---

## 📄 License

MIT License - Feel free to use this for learning and development

---

**Last Updated**: January 5, 2026
**Project Start Date**: January 4, 2026
