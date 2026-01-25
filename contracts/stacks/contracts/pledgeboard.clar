;; PledgeBoard - Community pledge tracker

(define-data-var pledge-counter uint u0)

(define-map pledges uint {
    pledger: principal,
    commitment: (string-utf8 256),
    timestamp: uint,
    deadline: uint,
    completed: bool,
    verified: bool
})

(define-constant ERR-UNAUTHORIZED (err u101))

(define-public (create-pledge (commitment (string-utf8 256)) (duration uint))
    (let ((pledge-id (var-get pledge-counter)))
        (map-set pledges pledge-id {
            pledger: tx-sender,
            commitment: commitment,
            timestamp: block-height,
            deadline: (+ block-height duration),
            completed: false,
            verified: false
        })
        (var-set pledge-counter (+ pledge-id u1))
        (ok pledge-id)))

(define-public (complete-pledge (pledge-id uint))
    (let ((pledge (unwrap! (map-get? pledges pledge-id) ERR-UNAUTHORIZED)))
        (asserts! (is-eq (get pledger pledge) tx-sender) ERR-UNAUTHORIZED)
        (ok (map-set pledges pledge-id (merge pledge {completed: true})))))

(define-public (verify-pledge (pledge-id uint))
    (let ((pledge (unwrap! (map-get? pledges pledge-id) ERR-UNAUTHORIZED)))
        (ok (map-set pledges pledge-id (merge pledge {verified: true})))))

(define-read-only (get-pledge (pledge-id uint))
    (ok (map-get? pledges pledge-id)))
