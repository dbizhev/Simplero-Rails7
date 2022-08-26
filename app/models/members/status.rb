module Members
  class Status
    PENDING = 'PENDING'
    ACCEPTED = 'ACCEPTED'
    REJECTED = 'REJECTED'
    OWNER = 'OWNER'

    VALID_STATUSES = [
      PENDING,
      ACCEPTED,
      REJECTED,
      OWNER
    ].freeze
  end
end