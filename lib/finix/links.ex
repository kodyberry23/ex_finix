defmodule Finix.Links do
  @moduledoc false
  use Finix.Schema

  defmodule Link do
    use Finix.Schema

    embedded_schema do
      field(:href, :string)
    end

    def changeset(link, params \\ %{}) do
      cast(link, params, [:href])
    end
  end

  embedded_schema do
    embeds_one(:application, Finix.Links.Link)
    embeds_one(:associated_identities, Finix.Links.Link)
    embeds_one(:authorizations, Finix.Links.Link)
    embeds_one(:disputes, Finix.Links.Link)
    embeds_one(:merchants, Finix.Links.Link)
    embeds_one(:payment_instruments, Finix.Links.Link)
    embeds_one(:self, Finix.Links.Link)
    embeds_one(:settlements, Finix.Links.Link)
    embeds_one(:transfers, Finix.Links.Link)
    embeds_one(:verifications, Finix.Links.Link)
  end

  def changeset(links, params \\ %{}) do
    fields = __schema__(:fields)
    changeset = cast(links, params, [])

    Enum.reduce(fields, changeset, fn field, acc ->
      cast_embed(acc, field)
    end)
  end
end
