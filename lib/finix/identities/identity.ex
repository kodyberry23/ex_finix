defmodule Finix.Identities.Identity do
  use Finix.Schema

  alias Finix.Identities.Identity.Entity
  alias Finix.Links

  defmodule Entity do
    use Finix.Schema

    alias Finix.Address

    embedded_schema do
      field(:ach_max_transaction_amount, :integer)
      field(:amex_mid, :string)
      field(:annual_card_volume, :integer)
      field(:business_name, :string)
      field(:business_phone, :string)
      field(:business_tax_id_provided, :boolean)
      field(:business_type, :string)
      field(:default_statement_descriptor, :string)
      field(:discover_mid, :string)
      field(:dob, :date)
      field(:doing_business_as, :string)
      field(:email, :string)
      field(:first_name, :string)
      field(:has_accepted_credit_cards_previously, :boolean)
      field(:incorporation_date, :date)
      field(:last_name, :string)
      field(:max_transaction_amount, :integer)
      field(:mcc, :string)
      field(:ownership_type, :string)
      field(:phone, :string)
      field(:principal_percentage_ownership, :integer)
      field(:short_business_name, :string)
      field(:tax_authority, :string)
      field(:tax_id_provided, :boolean)
      field(:title, :string)
      field(:url, :string)

      embeds_one(:business_address, Address)
      embeds_one(:personal_address, Address)
    end

    def changeset(entity, params \\ %{}) do
      entity
      |> cast(params, __schema__(:fields) -- [:business_address, :personal_address])
      |> cast_embed(:business_address)
      |> cast_embed(:personal_address)
    end
  end

  embedded_schema do
    field(:id, :string)
    field(:created_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
    field(:application, :string)
    field(:tags, :map)
    field(:identity_roles, {:array, Finix.Enums.IdentityRole}, default: [])

    embeds_one(:entity, Entity)
    embeds_one(:_links, Links)
  end

  def changeset(identity, params \\ %{}) do
    identity
    |> cast(params, __schema__(:fields) -- [:entity, :_links])
    |> cast_embed(:entity)
    |> cast_embed(:_links)
  end
end
