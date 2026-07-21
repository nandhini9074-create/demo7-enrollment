```markdown
# Demo7 Enrollment API

## Overview
The Demo7 Enrollment API provides endpoints for managing card enrollments and unenrollments for users. It allows users to enroll new cards and remove existing cards from the system.

## Features
- Enroll a card for a user.
- Unenroll a card for a user.

## Setup
### Prerequisites
- Node.js (v16 or higher)
- npm or yarn
- PostgreSQL database

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/nandhini9074-create/mimojo-enrollment-template-service-main.git
   cd mimojo-enrollment-template-service-main
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Configure environment variables:
   Create a `.env` file in the root directory and set the following variables:
   ```env
   NODE_ENV=development
   SERVER_HTTP_PORT=3000
   SERVER_HTTP_HOST=localhost
   DB_DIALECT=postgres
   DB_PORT=5432
   DB_DATABASE=mimojo
   DB_HOST=localhost
   DB_USERNAME=your_db_username
   DB_PASSWORD=your_db_password
   IS_SWAGGER_ENABLED=true
   GRAVITEE_ENDPOINT=http://localhost:3000
   ```

### Running the Application
Start the application:
```bash
npm run start:dev
```

Access the API documentation at [http://localhost:3000/api-docs](http://localhost:3000/api-docs).

## Environment Variables
| Variable               | Description                          | Default Value |
|------------------------|--------------------------------------|---------------|
| `NODE_ENV`             | Application environment             | `development` |
| `SERVER_HTTP_PORT`     | HTTP server port                    | `3000`        |
| `SERVER_HTTP_HOST`     | HTTP server host                    | `localhost`   |
| `DB_DIALECT`           | Database dialect                    | `postgres`    |
| `DB_PORT`              | Database port                       | `5432`        |
| `DB_DATABASE`          | Database name                       | `mimojo`      |
| `DB_HOST`              | Database host                       | `localhost`   |
| `DB_USERNAME`          | Database username                   | -             |
| `DB_PASSWORD`          | Database password                   | -             |
| `IS_SWAGGER_ENABLED`   | Enable Swagger documentation        | `true`        |
| `GRAVITEE_ENDPOINT`    | Gravitee API Gateway endpoint       | -             |

## API Endpoints
### Enroll a Card
**POST** `/card/enroll`

Enrolls a specific card for the user.

#### Request Body
```json
{
  "customerId": "string",
  "schemeUserId": "string",
  "cardDetails": [
    {
      "cardId": "string",
      "schemeCardId": "string",
      "cardLast4": "string",
      "isNewCard": true,
      "supplementaryCards": [
        {
          "cardId": "string",
          "schemeCardId": "string",
          "cardLast4": "string",
          "isNewCard": true
        }
      ]
    }
  ]
}
```

#### Response
```json
{
  "success": true,
  "message": "Card enrolled successfully",
  "data": {}
}
```

---

### Unenroll a Card
**POST** `/card/unenroll`

Unenrolls a specific card for the user.

#### Request Body
```json
{
  "unenrollCards": [
    {
      "mimojoCardId": "string",
      "replaceSchemeCardId": "string"
    }
  ]
}
```

#### Response
```json
{
  "success": true,
  "message": "Card unenrolled successfully",
  "data": {}
}
```

## License
This project is licensed under the MIT License.
```