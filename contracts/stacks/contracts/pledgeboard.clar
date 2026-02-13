;; PledgeBoard Clarity Contract
;; Community pledge tracker for crowdfunding.


(define-map pledges principal uint)
(define-data-var total-pledged uint u0)
(define-data-var goal uint u10000000)

(define-public (pledge (amount uint))
    (begin
        (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
        (map-set pledges tx-sender (+ (default-to u0 (map-get? pledges tx-sender)) amount))
        (var-set total-pledged (+ (var-get total-pledged) amount))
        (ok true)
    )
)

