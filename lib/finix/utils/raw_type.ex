defmodule Finix.Utils.RawType do
  use Ecto.Type

  def type, do: :map

  def cast(value) when is_binary(value), do: {:ok, value}
  def cast(value) when is_map(value), do: {:ok, value}
  def cast(_), do: :error

  def load(value) when is_binary(value), do: {:ok, value}
  def load(value) when is_map(value), do: {:ok, value}
  def load(_), do: :error

  def dump(value) when is_binary(value), do: {:ok, value}
  def dump(value) when is_map(value), do: {:ok, value}
  def dump(_), do: :error
end
