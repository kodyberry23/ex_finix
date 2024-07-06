defmodule Finix.Error do
  defmodule Logref do
    @derive [Poison.Encoder]
    defstruct [:logref]
  end

  defmodule Links do
    defmodule Source do
      @derive [Poison.Encoder]
      defstruct [:href]
    end

    @derive [Poison.Encoder]
    defstruct [:source]
  end

  defmodule Error do
    @derive [Poison.Encoder]
    defstruct [
      :code,
      :logref,
      :message,
      :_links
    ]
  end

  defmodule Embedded do
    @derive [Poison.Encoder]
    defstruct [:errors]
  end

  @derive [Poison.Encoder]
  defstruct [
    :total,
    :_embedded
  ]
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
