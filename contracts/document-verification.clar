;; Document Verification Contract
;; This contract verifies trade documents

(define-data-var admin principal tx-sender)

;; Document types
(define-constant DOC-TYPE-INVOICE u1)
(define-constant DOC-TYPE-BILL-OF-LADING u2)
(define-constant DOC-TYPE-CERTIFICATE-OF-ORIGIN u3)
(define-constant DOC-TYPE-INSURANCE u4)
(define-constant DOC-TYPE-INSPECTION u5)
(define-constant DOC-TYPE-OTHER u6)

;; Map to store document hashes
(define-map documents
  {
    doc-hash: (buff 32),
    doc-type: uint
  }
  {
    issuer: principal,
    issue-date: uint,
    expiry-date: uint,
    verified: bool,
    verifier: (optional principal),
    verification-date: (optional uint),
    metadata: (string-ascii 200)
  }
)

;; Public function to register a document
(define-public (register-document
    (doc-hash (buff 32))
    (doc-type uint)
    (expiry-date uint)
    (metadata (string-ascii 200)))
  (begin
    (asserts! (> expiry-date block-height) (err u1)) ;; Expiry date must be in the future
    (ok (map-set documents
      {
        doc-hash: doc-hash,
        doc-type: doc-type
      }
      {
        issuer: tx-sender,
        issue-date: block-height,
        expiry-date: expiry-date,
        verified: false,
        verifier: none,
        verification-date: none,
        metadata: metadata
      }
    ))
  )
)

;; Public function to verify a document
(define-public (verify-document (doc-hash (buff 32)) (doc-type uint))
  (let ((doc (map-get? documents {doc-hash: doc-hash, doc-type: doc-type})))
    (begin
      (asserts! (is-some doc) (err u1)) ;; Document must exist
      (asserts! (not (get verified (unwrap-panic doc))) (err u2)) ;; Document must not be already verified
      (ok (map-set documents
        {
          doc-hash: doc-hash,
          doc-type: doc-type
        }
        (merge (unwrap-panic doc)
          {
            verified: true,
            verifier: (some tx-sender),
            verification-date: (some block-height)
          }
        )
      ))
    )
  )
)

;; Read-only function to check if a document is verified
(define-read-only (is-document-verified (doc-hash (buff 32)) (doc-type uint))
  (let ((doc (map-get? documents {doc-hash: doc-hash, doc-type: doc-type})))
    (if (is-some doc)
      (get verified (unwrap-panic doc))
      false
    )
  )
)

;; Read-only function to get document details
(define-read-only (get-document-details (doc-hash (buff 32)) (doc-type uint))
  (map-get? documents {doc-hash: doc-hash, doc-type: doc-type})
)

;; Read-only function to check if a document is expired
(define-read-only (is-document-expired (doc-hash (buff 32)) (doc-type uint))
  (let ((doc (map-get? documents {doc-hash: doc-hash, doc-type: doc-type})))
    (if (is-some doc)
      (> block-height (get expiry-date (unwrap-panic doc)))
      false
    )
  )
)
