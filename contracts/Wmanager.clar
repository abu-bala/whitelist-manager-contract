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

;; Remove a user from the whitelist and update the count
(define-public (remove-whitelist (user principal))
    (begin
        (asserts! (is-eq tx-sender (var-get admin)) (err u100))
        (asserts! (not (is-eq user 'SP000000000000000000002Q6VF78)) (err u103))
        (let ((existing-entry (map-get? whitelisted {user: user})))
            (asserts! (is-some existing-entry) (err u102))
            (map-delete whitelisted {user: user})
            (var-set whitelist-count (- (var-get whitelist-count) u1))
            (ok true)
        )
    )
)
;; Get if a principal is whitelisted
(define-read-only (get-whitelisted (user principal))
    (ok (is-some (map-get? whitelisted {user: user})))
)
;; Check if a user is whitelisted
(define-read-only (is-whitelisted (user principal))
    (ok (default-to false (get whitelisted (map-get? whitelisted {user: user}))))
)

(define-public (set-admin (new-admin principal))
    (begin
        (asserts! (is-eq tx-sender (var-get admin)) (err u100))
        (asserts! (not (is-eq new-admin 'SP000000000000000000002Q6VF78)) (err u103))
        (var-set admin new-admin)
        (ok true)
    )
)
;; Get the admin principal  
(define-read-only (get-admin)
    (ok (var-get admin))
)

;; Add batch whitelist functionality
(define-public (add-whitelist-batch (users (list 200 principal)))
    (begin
        (try! (is-admin tx-sender))
        (ok (map add-single-whitelist users))
    )
)

;; Helper function for batch whitelist that also tracks count
(define-private (add-single-whitelist (user principal))
    (let ((is-blacklisted (is-eq user 'SP000000000000000000002Q6VF78))
          (already-whitelisted (default-to false (get whitelisted (map-get? whitelisted {user: user})))))
        (if (or is-blacklisted already-whitelisted)
            false
            (begin
                (map-set whitelisted {user: user} {whitelisted: true})
                (var-set whitelist-count (+ (var-get whitelist-count) u1))
                true
            )
        )
    )
)

;; Add whitelist count tracking
(define-data-var whitelist-count uint u0)

;; Get total number of whitelisted addresses
(define-read-only (get-whitelist-count)
    (ok (var-get whitelist-count))
    )



;; Implement pause functionality properly
(define-public (pause)
    (begin
        (try! (is-admin tx-sender))
        (var-set paused true)
        (ok true)
    )
)

(define-public (unpause)
    (begin
        (try! (is-admin tx-sender))
        (var-set paused false)
        (ok true)
    )
)

;; Update is-paused to use the var
(define-read-only (is-paused)
    (ok (var-get paused))
)

(define-public (get-version)
    (ok "1.0.0")
)
(define-public (get-name)
    (ok "WhitelistManager")
)
(define-public (get-description)
    (ok "A simple whitelist contract that allows admin-controlled management of whitelisted addresses.")
)
(define-public (get-implementation)
    (ok "WhitelistManager Contract")
)
(define-public (get-license)
    (ok "MIT")
)
(define-public (get-author)
    (ok "Hiro Systems PBC")
)
