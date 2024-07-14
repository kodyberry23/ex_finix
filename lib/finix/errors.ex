defmodule Finix.Errors do
  use Finix.Schema

  embedded_schema do
    field(:status, :integer)
    field(:total, :integer)

    embeds_one :_embedded, Embedded, primary_key: false do
      embeds_many :errors, Error, primary_key: false do
        field(:code, Finix.Enums.ErrorCode)
        field(:message, :string)
        field(:logref, :string)

        embeds_one :_links, Links, primary_key: false do
          embeds_one :source, Source, primary_key: false do
            field(:href, :string)
          end
        end
      end
    end
  end

  def changeset(errors, params \\ %{}) do
    errors
    |> cast(params, [:status, :total])
    |> cast_embed(:_embedded, with: &embedded_changeset/2)
  end

  def embedded_changeset(embedded, params \\ %{}) do
    embedded
    |> cast(params, [])
    |> cast_embed(:errors, with: &error_changeset/2)
  end

  def error_changeset(error, params \\ %{}) do
    error
    |> cast(params, [:code, :message, :logref])
    |> cast_embed(:_links, with: &links_changeset/2)
  end

  def links_changeset(links, params \\ %{}) do
    links
    |> cast(params, [])
    |> cast_embed(:source, with: &source_changeset/2)
  end

  def source_changeset(source, params \\ %{}) do
    cast(source, params, [:href])
  end
end

defmodule Finix.InvalidUsernameError do
  defexception message: """
               A `:username` is required in order to make calls to Finix.
               Please configure `:username` within your config.exs file.

               config :ex_finix, username: "your_username"
               """

  @type t() :: %__MODULE__{
          message: binary()
        }
end

defmodule Finix.InvalidPasswordError do
  defexception message: """
               A `:password` is required in order to make calls to Finix.
               Please configure `:password` within your config.exs file.

               config :ex_finix, password: "your_password"
               """

  @type t() :: %__MODULE__{
          message: binary()
        }
end
