;; Bank Verification Contract
;; This contract validates financial institutions participating in trade finance

(define-data-var admin principal tx-sender)

;; Map to store verified banks
(define-map verified-banks principal
  {
    name: (string-ascii 100),
    country: (string-ascii 50),
    verified: bool,
    verification-date: uint
  }
)

;; Public function to register a bank
(define-public (register-bank (name (string-ascii 100)) (country (string-ascii 50)))
  (let ((bank-principal tx-sender))
    (begin
      (asserts! (is-eq tx-sender (var-get admin)) (err u1)) ;; Only admin can register banks
      (ok (map-set verified-banks bank-principal
        {
          name: name,
          country: country,
          verified: false,
          verification-date: u0
        }
      ))
    )
  )
)

;; Public function to verify a bank
(define-public (verify-bank (bank-principal principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u1)) ;; Only admin can verify banks
    (asserts! (is-some (map-get? verified-banks bank-principal)) (err u2)) ;; Bank must be registered
    (ok (map-set verified-banks bank-principal
      (merge (unwrap-panic (map-get? verified-banks bank-principal))
        {
          verified: true,
          verification-date: block-height
        }
      )
    ))
  )
)

;; Public function to check if a bank is verified
(define-public (is-bank-verified (bank-principal principal))
  (let ((bank-info (map-get? verified-banks bank-principal)))
    (if (is-some bank-info)
      (ok (get verified (unwrap-panic bank-info)))
      (ok false)
    )
  )
)

;; Read-only function to get bank details
(define-read-only (get-bank-details (bank-principal principal))
  (map-get? verified-banks bank-principal)
)

;; Function to transfer admin rights
(define-public (transfer-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u1)) ;; Only current admin can transfer admin rights
    (ok (var-set admin new-admin))
  )
)
