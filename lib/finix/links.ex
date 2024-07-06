defmodule Finix.Links do
  @moduledoc false

  defmodule Link do
    @derive [Poison.Encoder]
    defstruct [:href]
  end

  @derive [Poison.Encoder]
  defstruct [
    :application,
    :associated_identities,
    :authorizations,
    :disputes,
    :merchants,
    :payment_instruments,
    :self,
    :settlements,
    :transfers,
    :verifications
  ]
end
