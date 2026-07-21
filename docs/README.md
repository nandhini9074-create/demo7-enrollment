```markdown
# Demo7 Enrollment API

## Overview

The Demo7 Enrollment API provides endpoints to manage card enrollments and unenrollments for users. This service allows users to enroll their cards into the system and remove them when necessary.

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
   Create a `.env` file in the root directory and define the following variables:
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
   GRAVITEE_ENDPOINT=http://localhost:3000
   ```

4. Run the application:
   ```bash
   npm run start
   ```

5. Access the API documentation:
   Visit `http://localhost:3000/api-docs` in your browser.

## Endpoints

### 1. Enroll a Card

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
- **Responses**:
  - **200**: Card enrolled successfully.
  - **400**: Bad request.

### 2. Unenroll a Card

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
- **Responses**:
  - **200**: Card unenrolled successfully.
  - **400**: Bad request.

## Development

### Running Tests

To run tests, use the following command:
```bash
npm run test
```

### Linting

To lint the codebase, use:
```bash
npm run lint
```

## License

This project is licensed under the MIT License. See the LICENSE file for details.
```