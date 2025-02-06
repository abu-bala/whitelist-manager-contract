;;WhitelistManager Contract
;; A simple whitelist contract that allows admin-controlled management of whitelisted addresses.

(define-data-var admin principal tx-sender)
(define-map whitelisted {user: principal} {whitelisted: bool})
(define-data-var paused bool false)
(define-data-var version (string-utf8 10) u"1.0.0")
(define-data-var name (string-utf8 20) u"WhitelistManager")
(define-data-var description (string-utf8 100) u"A simple whitelist contract that allows admin-controlled management of whitelisted addresses.")
(define-data-var implementation (string-utf8 50) u"WhitelistManager Contract")

;; Only admin can call certain functions
(define-read-only (is-admin (sender principal))
    (if (is-eq sender (var-get admin))
        (ok true)
        (err u403)
    )
)
;; Initialize the whitelist manager
(define-public (initialize)
    (begin
        (var-set admin tx-sender)
        (ok true)
    )
)
;; Add a user to the whitelist
(define-public (add-whitelist (user principal))
    (begin
        (try! (is-admin tx-sender))
        (asserts! (not (is-eq user 'SP000000000000000000002Q6VF78)) (err u103))
        (let ((existing-entry (map-get? whitelisted {user: user})))
            (asserts! (is-none existing-entry) (err u101))
            (map-set whitelisted {user: user} {whitelisted: true})
            (ok true)
        )
    )
)

