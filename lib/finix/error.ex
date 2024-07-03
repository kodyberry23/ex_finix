defmodule Finix.Error do
  defexception [:message, :status]

  @type t() :: %__MODULE__{
          message: binary(),
          status: integer()
        }

  @impl true
  def exception(response) do
    %__MODULE__{message: response.body, status: response.status}
  end
end

defmodule Finix.InvalidUsernameError do
  defexception message:
                 "Username cannot be empty. Please provide a valid :username config within your applications config/config.exs file"

  @type t() :: %__MODULE__{
          message: binary()
        }
end

defmodule Finix.InvalidPasswordError do
  defexception message:
                 "Password cannot be empty. Please provide a valid :password config within your applications config/config.exs file"

  @type t() :: %__MODULE__{
          message: binary()
        }
end
