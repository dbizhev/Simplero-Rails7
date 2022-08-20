module Members
  class Status
    PENDING = 'PENDING'
    ACCEPTED = 'ACCEPTED'
    REJECTED = 'REJECTED'

    VALID_STATUSES = [
      PENDING,
      ACCEPTED,
      REJECTED
    ].freeze
  end
end