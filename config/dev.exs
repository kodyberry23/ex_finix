import Config

config :ex_finix,
  username: "US56tevGaC4rzGhBhbK5Sock",
  password: "783e84ad-6713-470d-94bb-b5a5a25b7018",
  api_version: "2022-02-01"

# body = %{
#   identity_roles: ["BUYER", "RECIPIENT"],
#   entity: %{
#     phone: "7145677613",
#     first_name: "Tyler",
#     last_name: "Smith",
#     email: "finix_example@finix.com",
#     personal_address: %{
#       city: "San Mateo",
#       country: "USA",
#       region: "CA",
#       line2: "Apartment 7",
#       line1: "741 Douglass St",
#       postal_code: "94114"
#     }
#   }
# }

# Finix.Identities.create(body)

# p_body = %{
#   type: "PAYMENT_CARD",
#   identity: "IDdMp5HEt3b4EkrpdRYMMsG1",
#   name: "Tyler Smith",
#   number: "4895047700003297",
#   address: %{
#     city: "San Mateo",
#     country: "USA",
#     region: "CA",
#     line1: "741 Douglass St",
#     postal_code: "94114"
#   },
#   attempt_bank_account_validation_check: true,
#   tags: %{
#     test: "card_test"
#   },
#   security_code: "022",
#   expiration_month: 12,
#   expiration_year: 2029
# }

# Finix.PaymentInstruments.create(p_body)

# Finix.PaymentInstruments.fetch("PIwFXT9LYFyU5CrnajiqU4eH")

# t_body = %{
#   amount: 1000,
#   currency: "USD",
#   merchant: "MUbZgL4gCWFr5r27gqCMMZtb",
#   source: "PI8Rb18XPNd6WDscr6kG6sxL"
# }

# a_body = %{
#   amount: 1000,
#   currency: "USD",
#   merchant: "MUbZgL4gCWFr5r27gqCMMZtb",
#   source: "PIqqBa2hB5CiCD9H7AiWZo8C",
# }

# Finix.Authorizations.create(a_body)
# Finix.Authorizations.fetch("AUbVXscyGt6x1RHdVJbHqB3b")
# Finix.Authorizations.capture("AUbVXscyGt6x1RHdVJbHqB3b", %{capture_amount: 1000})

# Finix.Transfers.create(t_body)

# Finix.PaymentInstruments.verify("PIqqBa2hB5CiCD9H7AiWZo8C", %{processor: "DUMMY_V1"})

# Finix.Verifications.fetch("VI46ZnJhgwhekizTjtms4SRA")

# Finix.Merchants.create("IDdMp5HEt3b4EkrpdRYMMsG1", %{processor: "DUMMY_V1", application: "APjSv2pLKtUwqNM3H49DsreZ"})
# Finix.Merchants.fetch("MUhHFCsjkbrywcNrG26wNNt")

# t_body = %{
#   amount: 4000,
#   currency: "USD",
#   destination: "PIqqBa2hB5CiCD9H7AiWZo8C",
#   processor: "DUMMY_V1"
# }

# Finix.Transfers.create(t_body)

# Finix.Transfers.fetch("TRmK9FPonci1Eg5nYJaqSiqL")
