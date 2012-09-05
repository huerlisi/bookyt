# encoding: utf-8

# Main seed file
# ==============
# You probably want to load a local specific seed file from seeds/locales!


# Authorization
# =============
Role.create!([
  {:name => 'admin'},
  {:name => 'accountant'}
])

