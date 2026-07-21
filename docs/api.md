openapi: 3.0.0
info:
  title: Demo7 Enrollment API
  description: API for enrolling and unenrolling cards for users.
  version: 1.0.0
servers:
  - url: http://localhost:3000
    description: Local development server
paths:
  /card/enroll:
    post:
      summary: Enroll a card
      description: Enrolls a specific card from the user.
      operationId: enrollCard
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/EnrollCardDto'
      responses:
        '200':
          description: Card enrolled successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/BaseResponse'
  /card/unenroll:
    post:
      summary: Unenroll a card
      description: Unenrolls a specific card from the user.
      operationId: unenrollCard
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/UnenrollCardDto'
      responses:
        '200':
          description: Card unenrolled successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/BaseResponse'
components:
  schemas:
    EnrollCardDto:
      type: object
      required:
        - customerId
        - schemeUserId
        - cardDetails
      properties:
        customerId:
          type: string
          description: The ID of the customer.
        schemeUserId:
          type: string
          description: The ID of the user in the scheme.
        cardDetails:
          type: array
          items:
            $ref: '#/components/schemas/CardDetailsDto'
    CardDetailsDto:
      type: object
      required:
        - cardId
        - schemeCardId
        - isNewCard
      properties:
        cardId:
          type: string
          description: The ID of the card.
        schemeCardId:
          type: string
          description: The ID of the card in the scheme.
        cardLast4:
          type: string
          description: The last 4 digits of the card.
        isNewCard:
          type: boolean
          description: Indicates if the card is new.
        supplementaryCards:
          type: array
          items:
            $ref: '#/components/schemas/SupplementaryCardDto'
    SupplementaryCardDto:
      type: object
      required:
        - cardId
        - schemeCardId
        - isNewCard
      properties:
        cardId:
          type: string
          description: The ID of the supplementary card.
        schemeCardId:
          type: string
          description: The ID of the supplementary card in the scheme.
        cardLast4:
          type: string
          description: The last 4 digits of the supplementary card.
        isNewCard:
          type: boolean
          description: Indicates if the supplementary card is new.
    UnenrollCardDto:
      type: object
      required:
        - unenrollCards
      properties:
        unenrollCards:
          type: array
          items:
            $ref: '#/components/schemas/UnenrollCardItemDto'
    UnenrollCardItemDto:
      type: object
      required:
        - mimojoCardId
      properties:
        mimojoCardId:
          type: string
          description: The ID of the card to be unenrolled.
        replaceSchemeCardId:
          type: string
          description: The ID of the replacement scheme card.
    BaseResponse:
      type: object
      properties:
        statusCode:
          type: integer
          description: HTTP status code.
        message:
          type: string
          description: Response message.
        data:
          type: object
          description: Response data.