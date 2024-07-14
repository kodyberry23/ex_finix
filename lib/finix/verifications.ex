defmodule Finix.Verifications do
  @moduledoc """
  # Verifications

  Verifications are used to verify Identities and Payment Instruments.

  For Identities, a verification represents an attempt to onboard and underwrite an identity.

  For Payment Instruments, a verification represents getting additional information from the card brands to verify a card is eligible for push to card.

  See Finix Verification API Documentation for more info: https://finix.com/docs/api/tag/Payment-Instruments/
  """
  require Logger

  alias Finix.Verifications.Verification

  @verifications_url "/verifications"

  @doc """
  Retrieve the details of a Verification.
  """
  def fetch(verification_id, client_opts \\ %{}) do
    params =
      %{
        method: :get,
        opts: [path_params: [verification_id: verification_id]],
        url: @verifications_url <> "/:verification_id"
      }

    result = IO.inspect(params |> Finix.request(client_opts))

    result |> Finix.handle_response(Verification)
  end
end
