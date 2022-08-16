module Groups
  class Access
    OPEN = :open
    PRIVATE = :private

    VALID_ACCESSES = [
      OPEN,
      PRIVATE
    ].freeze
  end
end