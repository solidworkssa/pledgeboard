;; ────────────────────────────────────────
;; PledgeBoard v1.0.0
;; Author: solidworkssa
;; License: MIT
;; ────────────────────────────────────────

(define-constant VERSION "1.0.0")

;; Error codes
(define-constant ERR-NOT-AUTHORIZED (err u401))
(define-constant ERR-NOT-FOUND (err u404))
(define-constant ERR-ALREADY-EXISTS (err u409))
(define-constant ERR-INVALID-INPUT (err u422))

;; PledgeBoard Clarity Contract
;; Community pledge tracker for crowdfunding.


(define-map pledges principal uint)
(define-data-var total-pledged uint u0)
(define-data-var goal uint u10000000)

(define-public (pledge (amount uint))
    (begin
        (try! (stx-transfer? amount contract-caller (as-contract contract-caller)))
        (map-set pledges contract-caller (+ (default-to u0 (map-get? pledges contract-caller)) amount))
        (var-set total-pledged (+ (var-get total-pledged) amount))
        (ok true)
    )
)

