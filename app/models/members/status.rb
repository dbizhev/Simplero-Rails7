module Members
  class Status
    PENDING = :pending
    ACCEPTED = :accepted
    REJECTED = :rejected

    VALID_STATUSES = [
      PENDING,
      ACCEPTED,
      REJECTED
    ].freeze
  end
end