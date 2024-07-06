defmodule Finix.Address do
  @moduledoc false

  @derive [Poison.Encoder]
  defstruct [
    :city,
    :country,
    :line1,
    :line2,
    :postal_code,
    :region
  ]
end
