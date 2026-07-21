```markdown
## High-Level Architecture Diagram
```mermaid
flowchart LR
  subgraph dmz ["DMZ"]
    partner["Partner System(s)"]
    apiGw["API Gateway"]
  end

  subgraph trustedZone ["Trusted Zone"]
    integrationLayer["Integration Layer"]
    enrollmentSvc["EnrollmentService"]
    authSvc["AuthService"]
    webhookSvc["WebhookService"]
    reconciliationSvc["ReconciliationService"]
  end

  subgraph restrictedZone ["Restricted / PCI Zone"]
    db[(PostgreSQL)]
    vault[/"Vault: Tokenize<br/>AES-256 at rest"/]
    logs[("Audit Logs<br/>Masked")]
  end

  partner -- "HTTPS" --> apiGw
  apiGw -- "HTTPS" --> integrationLayer
  integrationLayer -- "HTTPS" --> enrollmentSvc
  integrationLayer -- "HTTPS" --> authSvc
  integrationLayer -- "HTTPS" --> webhookSvc
  integrationLayer -- "HTTPS" --> reconciliationSvc
  enrollmentSvc -- "SQL" --> db
  authSvc -- "SQL" --> db
  webhookSvc -- "HTTPS" --> externalApi["3rd-Party APIs"]
  reconciliationSvc -- "SQL" --> db
  db -- "Audit-Event" --> logs
  db -- "Credentials" --> vault
```

## Sequence Diagrams
### Enrollment / Onboarding
```mermaid
sequenceDiagram
  participant partner as Partner System
  participant apiGw as API Gateway
  participant integrationLayer as Integration Layer
  participant enrollmentSvc as EnrollmentService
  participant db as PostgreSQL
  participant logs as Audit Logs

  partner->>apiGw: POST /card/enroll
  apiGw->>integrationLayer: POST /card/enroll
  integrationLayer->>enrollmentSvc: enrollCard(enrollCardDto)
  enrollmentSvc->>db: Query customer
  alt Customer exists
    enrollmentSvc->>db: Insert card details
    db-->>enrollmentSvc: Success
  else Customer does not exist
    enrollmentSvc->>db: Insert customer and card details
    db-->>enrollmentSvc: Success
  end
  enrollmentSvc-->>integrationLayer: Enrollment response
  integrationLayer-->>apiGw: Enrollment response
  apiGw-->>partner: Enrollment response
  Note over db,logs: Audit-Event logged
```

## Data Flow Diagram (DFD)
```mermaid
flowchart TD
  subgraph untrusted ["Untrusted Zone"]
    partner["Partner System(s)"]
  end

  subgraph dmz ["DMZ"]
    apiGw["API Gateway"]
  end

  subgraph trusted ["Trusted Zone"]
    integrationLayer["Integration Layer"]
    enrollmentSvc["EnrollmentService"]
    authSvc["AuthService"]
    webhookSvc["WebhookService"]
    reconciliationSvc["ReconciliationService"]
  end

  subgraph restrictedPCI ["Restricted / PCI Zone"]
    db[(PostgreSQL<br/>AES-256 at rest)]
    vault[/"Vault: Tokenize<br/>AES-256 at rest"/]
    logs[("Audit Logs<br/>Masked")]
  end

  partner -- "PII, AuthN-Token<br/>TLS1.3" --> apiGw
  apiGw -- "PII, AuthN-Token<br/>TLS1.3" --> integrationLayer
  integrationLayer -- "PII, AuthN-Token<br/>TLS1.3" --> enrollmentSvc
  enrollmentSvc -- "PII<br/>SQL (TLS1.3)" --> db
  db -- "PII<br/>AES-256 at rest" --> vault
  db -- "Audit-Event<br/>AES-256 at rest" --> logs
  integrationLayer -- "AuthN-Token<br/>TLS1.3" --> authSvc
  integrationLayer -- "Public<br/>TLS1.3" --> webhookSvc
  integrationLayer -- "PII<br/>TLS1.3" --> reconciliationSvc
  webhookSvc -- "Public<br/>TLS1.3" --> externalApi["3rd-Party APIs"]
```
