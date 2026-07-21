```markdown
# Demo7 Enrollment API

## Overview

The Demo7 Enrollment API provides endpoints to manage card enrollments and unenrollments for users. This service allows users to enroll their cards into a system and remove them when necessary.

## Features

- **Enroll a Card**: Add a card to the user's account.
- **Unenroll a Card**: Remove a card from the user's account.

## Setup

### Prerequisites

- Node.js (v16 or higher)
- npm or yarn
- A running instance of the database (PostgreSQL)

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

3. Set up the environment variables:
   Create a `.env` file in the root directory and configure the following variables:
   ```env
   NODE_ENV=development
   SERVER_HTTP_PORT=3000
   SERVER_HTTP_HOST=localhost
   DB_DIALECT=postgres
   DB_PORT=5432
   DB_DATABASE=your_database_name
   DB_HOST=localhost
   DB_USERNAME=your_database_user
   DB_PASSWORD=your_database_password
   IS_SWAGGER_ENABLED=true
   ```

4. Run database migrations:
   ```bash
   npm run migrate
   ```

5. Start the server:
   ```bash
   npm run start:dev
   ```

6. Access the API documentation:
   Open [http://localhost:3000/api-docs](http://localhost:3000/api-docs) in your browser.

## Endpoints

### 1. Enroll a Card

**POST** `/card/enroll`

- **Description**: Enrolls a specific card from the user.
- **Request Body**:
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
- **Response**:
  ```json
  {
    "statusCode": 200,
    "message": "Success",
    "data": {}
  }
  ```

### 2. Unenroll a Card

**POST** `/card/unenroll`

- **Description**: Unenrolls a specific card from the user.
- **Request Body**:
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
- **Response**:
  ```json
  {
    "statusCode": 200,
    "message": "Success",
    "data": {}
  }
  ```

## Environment Variables

| Variable                  | Description                          | Default Value |
|---------------------------|--------------------------------------|---------------|
| `NODE_ENV`                | Application environment             | `development` |
| `SERVER_HTTP_PORT`        | Server port                         | `3000`        |
| `SERVER_HTTP_HOST`        | Server host                         | `localhost`   |
| `DB_DIALECT`              | Database dialect (e.g., postgres)   | `postgres`    |
| `DB_PORT`                 | Database port                       | `5432`        |
| `DB_DATABASE`             | Database name                       | -             |
| `DB_HOST`                 | Database host                       | -             |
| `DB_USERNAME`             | Database username                   | -             |
| `DB_PASSWORD`             | Database password                   | -             |
| `IS_SWAGGER_ENABLED`      | Enable Swagger documentation        | `true`        |

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
```