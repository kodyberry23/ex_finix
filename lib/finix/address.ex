defmodule Finix.Address do
  @moduledoc false
  use Finix.Schema

  embedded_schema do
    field(:city, :string)
    field(:country, :string)
    field(:line1, :string)
    field(:line2, :string)
    field(:postal_code, :string)
    field(:region, :string)
  end

  def changeset(address, params \\ %{}) do
    cast(address, params, __schema__(:fields))
  end
end
