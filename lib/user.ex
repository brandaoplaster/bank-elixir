defmodule User do
  defstruct name: nil, email: nil

  def create_user(name. email) do
    %{name: name, email: email}
  end
end