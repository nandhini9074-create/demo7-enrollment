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
        unenrollmentSvc["UnenrollmentService"]
    end

    subgraph restrictedZone ["Restricted / PCI Zone"]
        postgres["PostgreSQL"]
        vault["Vault"]
    end

    partner -- "HTTPS" --> apiGw
    apiGw -- "HTTPS" --> integrationLayer
    integrationLayer -- "HTTPS" --> enrollmentSvc
    integrationLayer -- "HTTPS" --> unenrollmentSvc
    enrollmentSvc -- "SQL" --> postgres
    unenrollmentSvc -- "SQL" --> postgres
    enrollmentSvc -- "Secrets API" --> vault
    unenrollmentSvc -- "Secrets API" --> vault
```

## Sequence Diagrams

### Enrollment / Onboarding

```mermaid
sequenceDiagram
    participant partner as Partner System
    participant apiGw as API Gateway
    participant integrationLayer as Integration Layer
    participant enrollmentSvc as EnrollmentService
    participant postgres as PostgreSQL
    participant vault as Vault

    partner ->> apiGw: POST /card/enroll
    apiGw ->> integrationLayer: POST /card/enroll
    integrationLayer ->> enrollmentSvc: enrollCard(payload)
    enrollmentSvc ->> postgres: SELECT * FROM customers WHERE customerId = ?
    alt Customer exists
        enrollmentSvc ->> postgres: INSERT INTO user_cards (card details)
    else Customer does not exist
        enrollmentSvc ->> postgres: INSERT INTO customers (customerId)
        enrollmentSvc ->> postgres: INSERT INTO user_cards (card details)
    end
    enrollmentSvc ->> vault: Store card fingerprint
    enrollmentSvc -->> integrationLayer: Enrollment response
    integrationLayer -->> apiGw: Enrollment response
    apiGw -->> partner: Enrollment response
```

## Data Flow Diagram (DFD)

```mermaid
flowchart TD
    subgraph untrustedZone ["Untrusted Zone"]
        partner["Partner System(s)"]
    end

    subgraph dmz ["DMZ"]
        apiGw["API Gateway"]
    end

    subgraph trustedZone ["Trusted Zone"]
        integrationLayer["Integration Layer"]
        enrollmentSvc["EnrollmentService"]
        unenrollmentSvc["UnenrollmentService"]
    end

    subgraph restrictedZone ["Restricted / PCI Zone"]
        postgres["PostgreSQL<br/>[PII, encrypted; AES-256 at rest]"]
        vault["Vault<br/>[Credentials, encrypted; AES-256 at rest]"]
    end

    partner -- "HTTPS (TLS1.3)" --> apiGw
    apiGw -- "HTTPS (mTLS)" --> integrationLayer
    integrationLayer -- "HTTPS (mTLS)" --> enrollmentSvc
    integrationLayer -- "HTTPS (mTLS)" --> unenrollmentSvc
    enrollmentSvc -- "SQL (TLS1.3)" --> postgres
    unenrollmentSvc -- "SQL (TLS1.3)" --> postgres
    enrollmentSvc -- "Secrets API (mTLS)" --> vault
    unenrollmentSvc -- "Secrets API (mTLS)" --> vault
```
```