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

    subgraph restrictedPCI ["Restricted / PCI Zone"]
        postgresDB[("PostgreSQL<br/>AES-256 at rest")]
        vault[/"Vault: Tokenize<br/>AES-256 at rest"/]
    end

    partner -- "HTTPS" --> apiGw
    apiGw -- "HTTPS (mTLS)" --> integrationLayer
    integrationLayer -- "HTTPS" --> enrollmentSvc
    integrationLayer -- "HTTPS" --> authSvc
    integrationLayer -- "HTTPS" --> webhookSvc
    integrationLayer -- "HTTPS" --> reconciliationSvc
    enrollmentSvc -- "SQL" --> postgresDB
    enrollmentSvc -- "Tokenization" --> vault
```

## Sequence Diagrams

### Enrollment / Onboarding
```mermaid
sequenceDiagram
    participant partner as Partner System
    participant apiGw as API Gateway
    participant integrationLayer as Integration Layer
    participant enrollmentSvc as EnrollmentService
    participant postgresDB as PostgreSQL
    participant vault as Vault

    partner->>apiGw: POST /card/enroll
    apiGw->>integrationLayer: POST /card/enroll
    integrationLayer->>enrollmentSvc: POST /enrollCard
    enrollmentSvc->>postgresDB: INSERT INTO customers, user_cards
    enrollmentSvc->>vault: Tokenize card details
    vault-->>enrollmentSvc: Tokenized data
    enrollmentSvc-->>integrationLayer: Enrollment response
    integrationLayer-->>apiGw: Enrollment response
    apiGw-->>partner: Enrollment response
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

    subgraph trustedZone ["Trusted Zone"]
        integrationLayer["Integration Layer"]
        enrollmentSvc["EnrollmentService"]
    end

    subgraph restrictedPCI ["Restricted / PCI Zone"]
        postgresDB[("PostgreSQL<br/>AES-256 at rest")]
        vault[/"Vault: Tokenize<br/>AES-256 at rest"/]
    end

    partner -- "PII, AuthN-Token<br/>TLS1.3" --> apiGw
    apiGw -- "PII, AuthN-Token<br/>HTTPS (mTLS)" --> integrationLayer
    integrationLayer -- "PII<br/>HTTPS" --> enrollmentSvc
    enrollmentSvc -- "[PII, Token]<br/>SQL" --> postgresDB
    enrollmentSvc -- "[PAN]<br/>HTTPS" --> vault
    vault -- "[Token]<br/>HTTPS" --> enrollmentSvc
```