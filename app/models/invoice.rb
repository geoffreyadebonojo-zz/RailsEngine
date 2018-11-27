class Invoice < ApplicationRecord

  enum status: %w(shipped)

end
