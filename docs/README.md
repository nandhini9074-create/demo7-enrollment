# Demo7 Enrollment API

## Overview
The Demo7 Enrollment API provides endpoints for managing card enrollments and unenrollments for users. This service is designed to handle operations such as enrolling new cards and removing existing cards from a user's account.

## Setup
To set up the project locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/nandhini9074-create/mimojo-enrollment-template-service-main.git
   cd mimojo-enrollment-template-service-main
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Start the application:
   ```bash
   npm run start
   ```

## Required Environment Variables
The following environment variables must be configured:

- `NODE_ENV`: Environment mode (e.g., `development`, `production`).
- `SERVER_HTTP_PORT`: Port number for the HTTP server.
- `SERVER_HTTP_HOST`: Hostname for the HTTP server.
- `IS_SWAGGER_ENABLED`: Enable Swagger documentation (`true` or `false`).
- `GRAVITEE_ENDPOINT`: URL for the Gravitee API Gateway.

## API Endpoints

### Enroll a Card
**POST** `/card/enroll`

- **Description**: Enrolls a specific card for a user.
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
  - **200**: Card enrolled successfully.
  - **400**: Bad request.

### Unenroll a Card
**POST** `/card/unenroll`

- **Description**: Unenrolls a specific card for a user.
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
  - **200**: Card unenrolled successfully.
  - **400**: Bad request.

## Documentation
Swagger documentation is available at `/api-docs` when `IS_SWAGGER_ENABLED` is set to `true`.

## License
This project is licensed under the MIT License.