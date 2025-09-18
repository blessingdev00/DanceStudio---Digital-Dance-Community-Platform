;; DanceStudio - Digital Dance Community Platform
;; A blockchain-based platform for dance classes, practice logs,
;; and dancer community rewards

;; Contract constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-exists (err u102))
(define-constant err-unauthorized (err u103))
(define-constant err-invalid-input (err u104))

;; Token constants
(define-constant token-name "DanceStudio Rhythm Token")
(define-constant token-symbol "DRT")
(define-constant token-decimals u6)
(define-constant token-max-supply u55000000000) ;; 55k tokens with 6 decimals

;; Reward amounts (in micro-tokens)
(define-constant reward-practice u2500000) ;; 2.5 DRT
(define-constant reward-class u3700000) ;; 3.7 DRT
(define-constant reward-milestone u8000000) ;; 8.0 DRT

;; Data variables
(define-data-var total-supply uint u0)
(define-data-var next-class-id uint u1)
(define-data-var next-practice-id uint u1)

;; Token balances
(define-map token-balances principal uint)

;; Dancer profiles
(define-map dancer-profiles
  principal
  {
    username: (string-ascii 24),
    dance-style: (string-ascii 12), ;; "ballet", "hiphop", "salsa", "jazz", "contemporary"
    practices-logged: uint,
    classes-taught: uint,
    total-minutes: uint,
    rhythm-score: uint, ;; 1-5
    join-date: uint
  }
)

;; Dance classes
(define-map dance-classes
  uint
  {
    class-title: (string-ascii 6),
    style: (string-ascii 12),
    difficulty: (string-ascii 4), ;; "easy", "med", "hard"
    duration: uint, ;; minutes
    music-bpm: uint,
    max-students: uint,
    instructor: principal,
    practice-count: uint,
    flow-rating: uint ;; average flow
  }
)

;; Practice logs
(define-map practice-logs
  uint
  {
    class-id: uint,
    dancer: principal,
    style-practiced: (string-ascii 12),
    practice-time: uint, ;; minutes
    music-tempo: uint, ;; BPM
    coordination: uint, ;; 1-5
    rhythm-feel: uint, ;; 1-5
    energy-level: uint, ;; 1-5
    practice-notes: (string-ascii 12),
    practice-date: uint,
    flowing: bool
  }
)

;; Class reviews
(define-map class-reviews
  { class-id: uint, reviewer: principal }
  {
    rating: uint, ;; 1-10
    review-text: (string-ascii 12),
    teaching-style: (string-ascii 3), ;; "fun", "ok", "hard"
    review-date: uint,
    beat-votes: uint
  }
)

;; Dancer milestones
(define-map dancer-milestones
  { dancer: principal, milestone: (string-ascii 12) }
  {
    achievement-date: uint,
    practice-count: uint
  }
)

;; Helper function to get or create profile
(define-private (get-or-create-profile (dancer principal))
  (match (map-get? dancer-profiles dancer)
    profile profile
    {
      username: "",
      dance-style: "hiphop",
      practices-logged: u0,
      classes-taught: u0,
      total-minutes: u0,
      rhythm-score: u1,
      join-date: stacks-block-height
    }
  )
)

;; Token functions
(define-read-only (get-name)
  (ok token-name)
)

(define-read-only (get-symbol)
  (ok token-symbol)
)

(define-read-only (get-decimals)
  (ok token-decimals)
)

(define-read-only (get-balance (user principal))
  (ok (default-to u0 (map-get? token-balances user)))
)

(define-private (mint-tokens (recipient principal) (amount uint))
  (let (
    (current-balance (default-to u0 (map-get? token-balances recipient)))
    (new-balance (+ current-balance amount))
    (new-total-supply (+ (var-get total-supply) amount))
  )
    (asserts! (<= new-total-supply token-max-supply) err-invalid-input)
    (map-set token-balances recipient new-balance)
    (var-set total-supply new-total-supply)
    (ok amount)
  )
)

;; Create dance class
(define-public (create-dance-class (class-title (string-ascii 6)) (style (string-ascii 12)) (difficulty (string-ascii 4)) (duration uint) (music-bpm uint) (max-students uint))
  (let (
    (class-id (var-get next-class-id))
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> (len class-title) u0) err-invalid-input)
    (asserts! (> duration u0) err-invalid-input)
    (asserts! (and (>= music-bpm u60) (<= music-bpm u180)) err-invalid-input)
    (asserts! (> max-students u0) err-invalid-input)
    
    (map-set dance-classes class-id {
      class-title: class-title,
      style: style,
      difficulty: difficulty,
      duration: duration,
      music-bpm: music-bpm,
      max-students: max-students,
      instructor: tx-sender,
      practice-count: u0,
      flow-rating: u0
    })
    
    ;; Update profile
    (map-set dancer-profiles tx-sender
      (merge profile {classes-taught: (+ (get classes-taught profile) u1)})
    )
    
    ;; Award class creation tokens
    (try! (mint-tokens tx-sender reward-class))
    
    (var-set next-class-id (+ class-id u1))
    (print {action: "dance-class-created", class-id: class-id, instructor: tx-sender})
    (ok class-id)
  )
)

;; Log dance practice
(define-public (log-practice (class-id uint) (style-practiced (string-ascii 12)) (practice-time uint) (music-tempo uint) (coordination uint) (rhythm-feel uint) (energy-level uint) (practice-notes (string-ascii 12)) (flowing bool))
  (let (
    (practice-id (var-get next-practice-id))
    (dance-class (unwrap! (map-get? dance-classes class-id) err-not-found))
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> practice-time u0) err-invalid-input)
    (asserts! (and (>= music-tempo u50) (<= music-tempo u200)) err-invalid-input)
    (asserts! (and (>= coordination u1) (<= coordination u5)) err-invalid-input)
    (asserts! (and (>= rhythm-feel u1) (<= rhythm-feel u5)) err-invalid-input)
    (asserts! (and (>= energy-level u1) (<= energy-level u5)) err-invalid-input)
    
    (map-set practice-logs practice-id {
      class-id: class-id,
      dancer: tx-sender,
      style-practiced: style-practiced,
      practice-time: practice-time,
      music-tempo: music-tempo,
      coordination: coordination,
      rhythm-feel: rhythm-feel,
      energy-level: energy-level,
      practice-notes: practice-notes,
      practice-date: stacks-block-height,
      flowing: flowing
    })
    
    ;; Update class stats if flowing
    (if flowing
      (let (
        (new-practice-count (+ (get practice-count dance-class) u1))
        (current-flow (* (get flow-rating dance-class) (get practice-count dance-class)))
        (flow-score (/ (+ coordination rhythm-feel energy-level) u3))
        (new-flow-rating (/ (+ current-flow flow-score) new-practice-count))
      )
        (map-set dance-classes class-id
          (merge dance-class {
            practice-count: new-practice-count,
            flow-rating: new-flow-rating
          })
        )
        true
      )
      true
    )
    
    ;; Update profile
    (if flowing
      (begin
        (map-set dancer-profiles tx-sender
          (merge profile {
            practices-logged: (+ (get practices-logged profile) u1),
            total-minutes: (+ (get total-minutes profile) practice-time),
            rhythm-score: (+ (get rhythm-score profile) (/ rhythm-feel u10))
          })
        )
        (try! (mint-tokens tx-sender reward-practice))
        true
      )
      (begin
        (try! (mint-tokens tx-sender (/ reward-practice u3)))
        true
      )
    )
    
    (var-set next-practice-id (+ practice-id u1))
    (print {action: "practice-logged", practice-id: practice-id, class-id: class-id})
    (ok practice-id)
  )
)

;; Write class review
(define-public (write-review (class-id uint) (rating uint) (review-text (string-ascii 12)) (teaching-style (string-ascii 3)))
  (let (
    (dance-class (unwrap! (map-get? dance-classes class-id) err-not-found))
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (and (>= rating u1) (<= rating u10)) err-invalid-input)
    (asserts! (> (len review-text) u0) err-invalid-input)
    (asserts! (is-none (map-get? class-reviews {class-id: class-id, reviewer: tx-sender})) err-already-exists)
    
    (map-set class-reviews {class-id: class-id, reviewer: tx-sender} {
      rating: rating,
      review-text: review-text,
      teaching-style: teaching-style,
      review-date: stacks-block-height,
      beat-votes: u0
    })
    
    (print {action: "review-written", class-id: class-id, reviewer: tx-sender})
    (ok true)
  )
)

;; Vote review beat
(define-public (vote-beat (class-id uint) (reviewer principal))
  (let (
    (review (unwrap! (map-get? class-reviews {class-id: class-id, reviewer: reviewer}) err-not-found))
  )
    (asserts! (not (is-eq tx-sender reviewer)) err-unauthorized)
    
    (map-set class-reviews {class-id: class-id, reviewer: reviewer}
      (merge review {beat-votes: (+ (get beat-votes review) u1)})
    )
    
    (print {action: "review-voted-beat", class-id: class-id, reviewer: reviewer})
    (ok true)
  )
)

;; Update dance style
(define-public (update-dance-style (new-dance-style (string-ascii 12)))
  (let (
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> (len new-dance-style) u0) err-invalid-input)
    
    (map-set dancer-profiles tx-sender (merge profile {dance-style: new-dance-style}))
    
    (print {action: "dance-style-updated", dancer: tx-sender, style: new-dance-style})
    (ok true)
  )
)

;; Claim milestone
(define-public (claim-milestone (milestone (string-ascii 12)))
  (let (
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (is-none (map-get? dancer-milestones {dancer: tx-sender, milestone: milestone})) err-already-exists)
    
    ;; Check milestone requirements
    (let (
      (milestone-met
        (if (is-eq milestone "dancer-120") (>= (get practices-logged profile) u120)
        (if (is-eq milestone "teacher-23") (>= (get classes-taught profile) u23)
        false)))
    )
      (asserts! milestone-met err-unauthorized)
      
      ;; Record milestone
      (map-set dancer-milestones {dancer: tx-sender, milestone: milestone} {
        achievement-date: stacks-block-height,
        practice-count: (get practices-logged profile)
      })
      
      ;; Award milestone tokens
      (try! (mint-tokens tx-sender reward-milestone))
      
      (print {action: "milestone-claimed", dancer: tx-sender, milestone: milestone})
      (ok true)
    )
  )
)

;; Update username
(define-public (update-username (new-username (string-ascii 24)))
  (let (
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> (len new-username) u0) err-invalid-input)
    (map-set dancer-profiles tx-sender (merge profile {username: new-username}))
    (print {action: "username-updated", dancer: tx-sender})
    (ok true)
  )
)

;; Read-only functions
(define-read-only (get-dancer-profile (dancer principal))
  (map-get? dancer-profiles dancer)
)

(define-read-only (get-dance-class (class-id uint))
  (map-get? dance-classes class-id)
)

(define-read-only (get-practice-log (practice-id uint))
  (map-get? practice-logs practice-id)
)

(define-read-only (get-class-review (class-id uint) (reviewer principal))
  (map-get? class-reviews {class-id: class-id, reviewer: reviewer})
)

(define-read-only (get-milestone (dancer principal) (milestone (string-ascii 12)))
  (map-get? dancer-milestones {dancer: dancer, milestone: milestone})
)