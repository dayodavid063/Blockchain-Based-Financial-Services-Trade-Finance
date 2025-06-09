# Blockchain-Based Trade Finance System

A comprehensive trade finance platform built on the Stacks blockchain using Clarity smart contracts. This system provides secure, transparent, and efficient management of trade finance operations including bank verification, letters of credit, document verification, payment processing, and risk management.

## Features

### 🏦 Bank Verification
- Register and verify financial institutions
- Track verification status and dates
- Admin-controlled verification process
- Country-based bank registration

### 📄 Letter of Credit Management
- Create, issue, and manage letters of credit
- Multi-party workflow (issuer, beneficiary, applicant)
- Status tracking throughout the lifecycle
- Document requirements and terms management
- Expiry date validation

### 📋 Document Verification
- Register trade documents with cryptographic hashes
- Support for multiple document types (invoices, bills of lading, certificates, etc.)
- Verification workflow with timestamps
- Expiry date management
- Metadata storage for additional information

### 💰 Payment Processing
- Create and track trade payments
- Multi-status payment lifecycle
- Reference linking to letters of credit
- Refund capabilities
- Multi-currency support

### ⚠️ Risk Management
- Entity risk profiling with credit scores
- Transaction limit enforcement
- Risk level assessment (Low, Medium, High)
- Transaction-specific risk evaluations
- Approval workflow for high-risk transactions

## Smart Contracts

### 1. Bank Verification Contract (`bank-verification.clar`)
Manages the registration and verification of financial institutions participating in trade finance.

**Key Functions:**
- `register-bank`: Register a new bank
- `verify-bank`: Verify a registered bank
- `is-bank-verified`: Check verification status
- `get-bank-details`: Retrieve bank information

### 2. Letter of Credit Contract (`letter-of-credit.clar`)
Handles the complete lifecycle of letters of credit from creation to fulfillment.

**Key Functions:**
- `create-letter-of-credit`: Create a new letter of credit
- `issue-letter-of-credit`: Issue a draft letter of credit
- `accept-letter-of-credit`: Beneficiary accepts the letter of credit
- `fulfill-letter-of-credit`: Mark as fulfilled

### 3. Document Verification Contract (`document-verification.clar`)
Provides secure document registration and verification using cryptographic hashes.

**Key Functions:**
- `register-document`: Register a document with hash
- `verify-document`: Verify a registered document
- `is-document-verified`: Check verification status
- `is-document-expired`: Check if document has expired

### 4. Payment Processing Contract (`payment-processing.clar`)
Manages trade payments with comprehensive status tracking and refund capabilities.

**Key Functions:**
- `create-payment`: Create a new payment
- `complete-payment`: Mark payment as completed
- `fail-payment`: Mark payment as failed
- `refund-payment`: Process payment refund

### 5. Risk Management Contract (`risk-management.clar`)
Provides risk assessment and management capabilities for trade finance operations.

**Key Functions:**
- `set-risk-profile`: Set entity risk profile
- `assess-transaction-risk`: Assess specific transaction risk
- `is-within-transaction-limit`: Check transaction limits

## Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd trade-finance
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

## Testing

The project includes comprehensive test suites for all smart contracts using Vitest. Tests cover:

- Contract function behavior
- Error handling
- State management
- Access control
- Business logic validation

Run tests with:
\`\`\`bash
npm test
\`\`\`

## Usage

### Deploying Contracts

Deploy the contracts to the Stacks blockchain in the following order:

1. Bank Verification Contract
2. Risk Management Contract
3. Document Verification Contract
4. Letter of Credit Contract
5. Payment Processing Contract

### Basic Workflow

1. **Bank Registration**: Register and verify participating banks
2. **Risk Assessment**: Set up risk profiles for entities
3. **Letter of Credit Creation**: Create and issue letters of credit
4. **Document Management**: Register and verify trade documents
5. **Payment Processing**: Process payments linked to trade transactions

## Security Considerations

- All contracts implement proper access control
- Admin functions are restricted to authorized principals
- Input validation prevents invalid state transitions
- Cryptographic hashes ensure document integrity
- Time-based validations prevent expired operations

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions or support, please open an issue in the repository or contact the development team.
\`\`\`

```md project="Trade Finance" file="PR-DETAILS.md"
# Pull Request: Blockchain-Based Trade Finance System

## Overview
This PR introduces a comprehensive blockchain-based trade finance system built on the Stacks blockchain using Clarity smart contracts. The system provides end-to-end management of trade finance operations with five core smart contracts.

## Changes Made

### 🆕 New Smart Contracts

#### 1. Bank Verification Contract (`contracts/bank-verification.clar`)
- **Purpose**: Validates financial institutions participating in trade finance
- **Key Features**:
  - Bank registration with name and country
  - Admin-controlled verification process
  - Verification status tracking with timestamps
  - Admin transfer functionality

#### 2. Letter of Credit Contract (`contracts/letter-of-credit.clar`)
- **Purpose**: Manages the complete lifecycle of letters of credit
- **Key Features**:
  - Multi-party workflow (issuer, beneficiary, applicant)
  - Status progression (Draft → Issued → Accepted → Fulfilled)
  - Document requirements specification
  - Expiry date validation
  - Terms and conditions storage

#### 3. Document Verification Contract (`contracts/document-verification.clar`)
- **Purpose**: Verifies trade documents using cryptographic hashes
- **Key Features**:
  - Support for 6 document types (Invoice, Bill of Lading, Certificate of Origin, etc.)
  - Hash-based document integrity
  - Verification workflow with timestamps
  - Expiry date management
  - Metadata storage

#### 4. Payment Processing Contract (`contracts/payment-processing.clar`)
- **Purpose**: Processes trade payments with comprehensive tracking
- **Key Features**:
  - Multi-status payment lifecycle (Pending → Completed/Failed/Refunded)
  - Multi-currency support
  - Letter of credit integration
  - Reference tracking
  - Refund capabilities

#### 5. Risk Management Contract (`contracts/risk-management.clar`)
- **Purpose**: Manages trade finance risks and entity assessments
- **Key Features**:
  - Entity risk profiling with credit scores
  - Three-tier risk levels (Low, Medium, High)
  - Transaction limit enforcement
  - Transaction-specific risk assessments
  - Approval workflow integration

### 🧪 Comprehensive Test Suite

#### Test Files Added:
- `tests/bank-verification.test.js` - 6 test cases covering registration, verification, and admin functions
- `tests/letter-of-credit.test.js` - 6 test cases covering LOC lifecycle and expiry validation
- `tests/document-verification.test.js` - 6 test cases covering document registration and verification
- `tests/payment-processing.test.js` - 6 test cases covering payment lifecycle and refunds
- `tests/risk-management.test.js` - 6 test cases covering risk profiling and transaction limits

#### Test Coverage:
- ✅ Function behavior validation
- ✅ Error handling and edge cases
- ✅ Access control mechanisms
- ✅ State management verification
- ✅ Business logic validation
- ✅ Mock-based testing without external dependencies

### 📚 Documentation

#### README.md
- Comprehensive project overview
- Feature descriptions for all contracts
- Installation and usage instructions
- Security considerations
- Contributing guidelines

#### PR-DETAILS.md
- Detailed change summary
- Technical implementation details
- Testing strategy
- Security considerations

## Technical Implementation

### Architecture Decisions
1. **Modular Design**: Each contract handles a specific domain (banking, credit, documents, payments, risk)
2. **Access Control**: Admin-based permissions for critical operations
3. **State Management**: Efficient use of Clarity maps and data variables
4. **Error Handling**: Comprehensive error codes for different failure scenarios
5. **Time Validation**: Block height-based expiry and timestamp tracking

### Security Features
- **Access Control**: Admin-only functions for sensitive operations
- **Input Validation**: Comprehensive validation of all inputs
- **State Consistency**: Proper state transitions and validations
- **Hash Integrity**: Cryptographic hashes for document verification
- **Time-based Security**: Expiry date validations prevent stale operations

### Testing Strategy
- **Unit Testing**: Individual function testing with Vitest
- **Mock-based**: No external dependencies, pure JavaScript mocks
- **Edge Cases**: Comprehensive error condition testing
- **State Verification**: Validation of contract state changes
- **Access Control Testing**: Verification of permission systems

## Breaking Changes
None - This is a new implementation.

## Dependencies
- **Testing**: Vitest for test execution
- **Blockchain**: Stacks blockchain with Clarity smart contracts
- **No External Libraries**: Pure Clarity implementation without external dependencies

## Performance Considerations
- Efficient map-based storage for scalability
- Minimal gas consumption through optimized Clarity code
- Indexed access patterns for quick lookups
- Proper data structure choices for each use case

## Future Enhancements
- Integration with external oracle services for real-time data
- Multi-signature support for enhanced security
- Automated compliance checking
- Integration with traditional banking systems
- Mobile application interface

## Testing Instructions
1. Install dependencies: `npm install`
2. Run all tests: `npm test`
3. Run specific contract tests: `npm test bank-verification.test.js`

## Deployment Notes
Deploy contracts in the following order to ensure proper dependencies:
1. Bank Verification Contract
2. Risk Management Contract  
3. Document Verification Contract
4. Letter of Credit Contract
5. Payment Processing Contract

## Review Checklist
- [ ] All contracts compile successfully
- [ ] All tests pass (30 test cases total)
- [ ] Security review completed
- [ ] Documentation is comprehensive
- [ ] Code follows Clarity best practices
- [ ] Access control mechanisms verified
- [ ] Error handling is comprehensive
