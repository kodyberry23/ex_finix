defmodule Finix.Identities do
  @moduledoc """
  # Identities

  An Identity resource represents either a person or business in Finix. You'll create an Identity to onboard your sellers, and verify the different owners.

  See Finix Indentities API Documentation: https://finix.com/docs/api/tag/Identities/
  """
  alias Finix.Client

  @indentities_url "/identities"

  defmodule Identity do
    defmodule Entity do
      @derive [Poison.Encoder]
      defstruct [
        :ach_max_transaction_amount,
        :amex_mid,
        :annual_card_volume,
        :business_address,
        :business_name,
        :business_phone,
        :business_tax_id_provided,
        :business_type,
        :default_statement_descriptor,
        :discover_mid,
        :dob,
        :doing_business_as,
        :email,
        :first_name,
        :has_accepted_credit_cards_previously,
        :incorporation_date,
        :last_name,
        :max_transaction_amount,
        :mcc,
        :ownership_type,
        :personal_address,
        :phone,
        :principal_percentage_ownership,
        :short_business_name,
        :tax_authority,
        :tax_id_provided,
        :title,
        :url
      ]
    end

    @derive [Poison.Encoder]
    defstruct [
      :_links,
      :application,
      :created_at,
      :entity,
      :id,
      :identity_roles,
      :tags,
      :type,
      :updated_at
    ]
  end

  @doc """
  Create an Identity for your seller or buyer.

  All fields for a buyer's Identity are optional.

  Providing `business_type` indicates that the Identity is being created for a Merchant.
  """
  @spec create_identity(map(), map()) :: struct()
  def create_identity(body, client_opts \\ %{}) do
    %{
      url: @indentities_url,
      method: :post,
      body: body
    }
    |> Client.request(client_opts)
    |> Finix.Client.handle_response(%Finix.Identities.Identity{
      entity: %Finix.Identities.Identity.Entity{
        personal_address: %Finix.Address{}
      },
      _links: %Finix.Links{
        self: %Finix.Links.Link{},
        verifications: %Finix.Links.Link{},
        merchants: %Finix.Links.Link{},
        settlements: %Finix.Links.Link{},
        authorizations: %Finix.Links.Link{},
        transfers: %Finix.Links.Link{},
        payment_instruments: %Finix.Links.Link{},
        associated_identities: %Finix.Links.Link{},
        disputes: %Finix.Links.Link{},
        application: %Finix.Links.Link{}
      }
    })
  end
end
